# 多线程与线程间通信

在 iOS 开发中，多线程有这几种方案 `pthread`、`NSThread`、`GCD`、`NSOperationQueue`。除此之外，还需要了解 `NSRunloop`。

## 简介
### pthread
[POSIX 线程](http://en.wikipedia.org/wiki/POSIX_Threads) API，非常基础的多线程 API。使用非常麻烦，在 [ObjC 中国-并发编程](https://objccn.io/issue-2-1/) 文中有相应的代码，大家有兴趣可以了解一下。看完以后，你也许就明白为什么你没用这个了。

### NSThread
对 `pthread` 的封装，代码看起来更亲切。示例还是见上一节中文的文章，当然也可以查一下 Apple 的文档。

### GCD
Grand Central Dispatch 是 iOS 4 引入的，为了让开发者更加容易的使用设备的多核 CPU。GCD 在后端维护了一个线程池，对上层提供了几个队列，更容易使用。

### NSOperationQueue
是对 GCD 的队列模型的 Cocoa 抽象。对多个任务的处理要更方便一些，比如取消任务、设定任务优先级以及依赖等。

### Run Loops
Run Loop 只是消息循环，并不能执行任务。它配合任务的执行，提供一种异步执行代码的机制。

## 挑战
### 资源共享
并发编程中许多问题的根源就是在多线程中访问共享资源。资源可以是一个属性、一个对象，通用的内存、网络设备或者一个文件等等。在多线程中任何一个共享的资源都可能是一个潜在的冲突点，你必须精心设计以防止这种冲突的发生。

举个例子：

公共资源是计数器的整数值，我们有两个并行线程 A 和 B，两个线程都尝试增加计数的值。问题在于，不管是 C 还是 Objective-C 写代码在大多数情况对 CPU 都不仅仅是一条机器指令。要想增加计数器的值，当前的必须被从内存中读出，然后增加计数器的值，最后还需要将这个增加后的值写回内存中。

很有可能的执行情况是这样的：

![](http://shjborage-public.qiniudn.com/2017-03-30-14908620492165.png)

线程 A 和 B 都从内存中读取出了计数器的值，假设为 17 ，然后线程A将计数器的值加1，并将结果 18 写回到内存中。同时，线程B也将计数器的值加 1 ，并将结果 18 写回到内存中。实际上，此时计数器的值已经被破坏掉了，因为计数器的值 17 被加 1 了两次，而它的值却是 18。

这个问题被叫做[竞态条件](http://en.wikipedia.org/wiki/Race_conditions#Software)，在多线程里面访问一个共享的资源，如果没有一种机制来确保在线程 A 结束访问一个共享资源之前，线程 B 就不会开始访问该共享资源的话，资源竞争的问题就总是会发生。

### 互斥锁
[互斥](http://en.wikipedia.org/wiki/Mutex)访问的意思就是同一时刻，只允许一个线程访问某个特定资源。为了实现互斥，每个希望访问共享资源和线程，首先需要获取一个互斥锁，一旦某个线程对资源完成了操作，就释放掉这个锁，别的线程就可以访问了。

![](http://shjborage-public.qiniudn.com/2017-03-30-14908622601947.png)

>   除了确保互斥访问，还需要解决代码无序执行所带来的问题。如果不能确保 CPU 访问内存的顺序跟编程时的代码指令一样，那么仅仅依靠互斥访问是不够的。为了解决由 CPU 的优化策略引起的副作用，还需要引入内存屏障。通过设置内存屏障，来确保没有无序执行的指令能跨过屏障而执行。

>   当然，互斥锁自身的实现是需要没有竞争条件的。这实际上是非常重要的一个保证，并且需要在现代 CPU 上使用特殊的指令。更多关于原子操作（atomic operation）的信息，请阅读 Daniel 写的文章：底层并发技术。
> 
>   在这里有一个东西需要进行权衡：获取和释放锁所是要带来开销的，因此你需要确保你不会频繁地进入和退出临界区段（比如获取和释放锁）。同时，如果你获取锁之后要执行一大段代码，这将带来锁竞争的风险：其它线程可能必须等待获取资源锁而无法工作。这并不是一项容易解决的任务。

### 死锁
互斥锁解决了竞态条件的问题，但很不幸同时这也引入了一些其他问题，其中一个就是死锁。当多个线程在相互等待着对方的结束时，就会发生死锁，这时程序可能会被卡住。

![](http://shjborage-public.qiniudn.com/2017-03-30-14908642364654.png)

你在线程之间共享的资源越多，你使用的锁也就越多，同时程序被死锁的概率也会变大。例子还是可以见[这里的死锁章节](https://objccn.io/issue-2-1/)

### 资源饥饿（Starvation）
还不是很理解 >_<  TODO
>   当你认为已经足够了解并发编程面临的问题时，又出现了一个新的问题。锁定的共享资源会引起读写问题。大多数情况下，限制资源一次只能有一个线程进行读取访问其实是非常浪费的。因此，在资源上没有写入锁的时候，持有一个读取锁是被允许的。这种情况下，如果一个持有读取锁的线程在等待获取写入锁的时候，其他希望读取资源的线程则因为无法获得这个读取锁而导致资源饥饿的发生。

### 优先级反转
优先级反转是指程序在运行时低优先级的任务阻塞了高优先级的任务，有效的反转了任务的优先级。由于 GCD 提供了拥有不同优先级的后台队列，甚至包括一个 I/O 队列，所以我们最好了解一下优先级反转的可能性。

![](http://shjborage-public.qiniudn.com/2017-03-30-14908671676684.png)

> 高优先级和低优先级的任务之间共享资源时，就可能发生优先级反转。当低优先级的任务获得了共享资源的锁时，该任务应该迅速完成，并释放掉锁，这样高优先级的任务就可以在没有明显延时的情况下继续执行。然而高优先级任务会在低优先级的任务持有锁的期间被阻塞。如果这时候有一个中优先级的任务(该任务不需要那个共享资源)，那么它就有可能会抢占低优先级任务而被执行，因为此时高优先级任务是被阻塞的，所以中优先级任务是目前所有可运行任务中优先级最高的。此时，中优先级任务就会阻塞着低优先级任务，导致低优先级任务不能释放掉锁，这也就会引起高优先级任务一直在等待锁的释放。
> 
> 遇到优先级反转时，一般没那么严重。

> 解决这个问题的方法，通常就是不要使用不同的优先级。通常最后你都会以让高优先级的代码等待低优先级的代码来解决问题。当你使用 GCD 时，总是使用默认的优先级队列（直接使用，或者作为目标队列）。如果你使用不同的优先级，很可能实际情况会让事情变得更糟糕。

## 初步建议
我们建议采纳的安全模式是这样的：从主线程中提取出要使用到的数据，并利用一个操作队列在后台处理相关的数据，最后回到主队列中来发送你在后台队列中得到的结果。使用这种方式，你不需要自己做任何锁操作，这也就大大减少了犯错误的几率。

## 常见的后台实践

### 后台绘制
以下两个常见的做法，在 WWDC 2012 中都有详细说明。

-   1. 如果你确定 `drawRect:` 是你的应用的性能瓶颈，那么你可以将这些绘制代码放到后台去做。通常是将绘制的代码，先在后台线程绘制为一个图片，然后在主线程中渲染图片。

```
UIGraphicsBeginImageContextWithOptions(size, NO, 0);
// drawing code here
UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
return i;
```

-   2. 如果你在 table view 或者是 collection view 的 cell 上做了自定义绘制的话，最好将它们放入 operation 的子类中去。你可以将它们添加到后台操作队列，也可以在用户将 cell 滚动出边界时的 `didEndDisplayingCell` 委托方法中进行取消。

### 异步网络请求
这块大家都比较了解了，是比较基本的内容，不展开讲了。有兴趣可以看下 [ObjC 这一章的详情](https://objccn.io/issue-2-2/)。

### 进阶：后台文件 I/O
主要是 `NSInputStream` 的使用，大体流程如下：

> 1. 建立一个中间缓冲层以提供，当没有找到换行符号的时候可以向其中添加数据
> 2. 从 stream 中读取一块数据
> 3. 对于这块数据中发现的每一个换行符，取中间缓冲层，向其中添加数据，直到（并包括）这个换行符，并将其输出
> 4. 将剩余的字节添加到中间缓冲层去
> 5. 回到 2，直到 stream 关闭
 
[ObjC 有个示例](https://github.com/objcio/issue-2-background-file-io)，有兴趣详细看下吧。

## 底层并发 API
这块主要包含 GCD 的各种底层 API，这块其实除了 `dispatch_once` 外，其它的作为了解就行了。

主要有这些 API，如果想了解细节可以看 Apple 的文档或这篇文章：[ObjC 中国-底层并发 API](https://objccn.io/issue-2-3/)。

```objc
// 延后执行
double delayInSeconds = 2.0;
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
   [self bar];
});
   
// 队列 
NSString *label = [NSString stringWithFormat:@"%@.isolation.%p", [self class], self];
self.isolationQueue = dispatch_queue_create([label UTF8String], 0);
self.isolationQueue = dispatch_queue_create([label UTF8String], DISPATCH_QUEUE_CONCURRENT);
    
- (NSUInteger)countForKey:(NSString *)key;
{
    __block NSUInteger count;
    dispatch_sync(self.isolationQueue, ^(){
        NSNumber *n = self.counts[key];
        count = [n unsignedIntegerValue];
    });
    return count;
}

- (void)setCount:(NSUInteger)count forKey:(NSString *)key
{
    key = [key copy];
    dispatch_barrier_async(self.isolationQueue, ^(){
        if (count == 0) {
            [self.counts removeObjectForKey:key];
        } else {
            self.counts[key] = @(count);
        }
    });
}

// 迭代执行
dispatch_apply(height, dispatch_get_global_queue(0, 0), ^(size_t y) {
    for (size_t x = 0; x < width; x += 2) {
        // Do something with x and y here
    }
});

// group
dispatch_group_t group = dispatch_group_create();

dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
dispatch_group_async(group, queue, ^(){
    // Do something that takes a while
    [self doSomeFoo];
    dispatch_group_async(group, dispatch_get_main_queue(), ^(){
        self.foo = 42;
    });
});
dispatch_group_async(group, queue, ^(){
    // Do something else that takes a while
    [self doSomeBar];
    dispatch_group_async(group, dispatch_get_main_queue(), ^(){
        self.bar = 1;
    });
});

// This block will run once everything above is done:
dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
    NSLog(@"foo: %d", self.foo);
    NSLog(@"bar: %d", self.bar);
});

// 事件源
NSRunningApplication *mail = [NSRunningApplication 
  runningApplicationsWithBundleIdentifier:@"com.apple.mail"];
if (mail == nil) {
    return;
}
pid_t const pid = mail.processIdentifier;
self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_PROC, pid, 
  DISPATCH_PROC_EXIT, DISPATCH_TARGET_QUEUE_DEFAULT);
dispatch_source_set_event_handler(self.source, ^(){
    NSLog(@"Mail quit.");
});
dispatch_resume(self.source);

// 定时器
dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 
  0, 0, DISPATCH_TARGET_QUEUE_DEFAULT);
dispatch_source_set_event_handler(source, ^(){
    NSLog(@"Time flies.");
});
dispatch_time_t start
dispatch_source_set_timer(source, DISPATCH_TIME_NOW, 5ull * NSEC_PER_SEC, 
  100ull * NSEC_PER_MSEC);
self.source = source;
dispatch_resume(self.source);

// I/O
dispatch_data_t a; // Assume this hold some valid data
dispatch_data_t b; // Assume this hold some valid data
dispatch_data_t c = dispatch_data_create_concat(a, b);

dispatch_data_apply(c, ^bool(dispatch_data_t region, size_t offset, const void *buffer, size_t size) {
    fprintf(stderr, "region with offset %zu, size %zu\n", offset, size);
    return true;
});

// 基准测试
size_t const objectCount = 1000;
uint64_t n = dispatch_benchmark(10000, ^{
    @autoreleasepool {
        id obj = @42;
        NSMutableArray *array = [NSMutableArray array];
        for (size_t i = 0; i < objectCount; ++i) {
            [array addObject:obj];
        }
    }
});
NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);

```

## 线程安全类的设计

主要看一下 Objective-C 中的 property 实现，其它的自行看原文。

>   下文引用自 [ObjC 中国](https://objccn.io/issue-2-4/)。

### 原子属性 (Atomic Properties)

你曾经好奇过 Apple 是怎么处理 atomic 的设置/读取属性的么？至今为止，你可能听说过自旋锁 (spinlocks)，信标 (semaphores)，锁 (locks)，`@synchronized` 等，Apple 用的是什么呢？因为 [Objctive-C 的 runtime](http://www.opensource.apple.com/source/objc4/) 是开源的，所以我们可以一探究竟。

一个非原子的 setter 看起来是这个样子的：

```
- (void)setUserName:(NSString *)userName {
      if (userName != _userName) {
          [userName retain];
          [_userName release];
          _userName = userName;
      }
}
```

这是一个手动 `retain/release` 的版本，ARC 生成的代码和这个看起来也是类似的。当我们看这段代码时，显而易见要是 setUserName: 被并发调用的话会造成麻烦。我们可能会释放 `_userName` 两次，这回使内存错误，并且导致难以发现的 bug。

对于任何没有手动实现的属性，编译器都会生成一个 `objc_setProperty_non_gc(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, signed char shouldCopy)` 的调用。在我们的例子中，这个调用的参数是这样的：

```
objc_setProperty_non_gc(self, _cmd, 
  (ptrdiff_t)(&_userName) - (ptrdiff_t)(self), userName, NO, NO);
```

`ptrdiff_t` 可能会吓到你，但是实际上这就是一个简单的指针算术，因为其实 Objective-C 的类仅仅只是 C 结构体而已。

`objc_setProperty` 调用的是如下方法：

```objc
static inline void reallySetProperty(id self, SEL _cmd, id newValue, 
  ptrdiff_t offset, bool atomic, bool copy, bool mutableCopy) 
{
    id oldValue;
    id *slot = (id*) ((char*)self + offset);

    if (copy) {
        newValue = [newValue copyWithZone:NULL];
    } else if (mutableCopy) {
        newValue = [newValue mutableCopyWithZone:NULL];
    } else {
        if (*slot == newValue) return;
        newValue = objc_retain(newValue);
    }

    if (!atomic) {
        oldValue = *slot;
        *slot = newValue;
    } else {
        spin_lock_t *slotlock = &PropertyLocks[GOODHASH(slot)];
        _spin_lock(slotlock);
        oldValue = *slot;
        *slot = newValue;        
        _spin_unlock(slotlock);
    }

    objc_release(oldValue);
}
```

除开方法名字很有趣以外，其实方法实际做的事情非常直接，它使用了在 PropertyLocks 中的 128 个自旋锁中的 1 个来给操作上锁。这是一种务实和快速的方式，最糟糕的情况下，如果遇到了哈希碰撞，那么 setter 需要等待另一个和它无关的 setter 完成之后再进行工作。

虽然这些方法没有定义在任何公开的头文件中，但我们还是可用手动调用他们。我不是说这是一个好的做法，但是知道这个还是蛮有趣的，而且如果你想要同时实现原子属性和自定义的 setter 的话，这个技巧就非常有用了。

>   结束引用

## Refs
-   [ObjC 中国-并发编程](https://objccn.io/issue-2-1/)
-   [ObjC 中国-常见的后台实践](https://objccn.io/issue-2-2/)
-   [ObjC 中国-底层并发 API](https://objccn.io/issue-2-3/)
-   [ObjC 中国-线程安全类的设计](https://objccn.io/issue-2-4/)
-   [Session 211 -- Building Concurrent User Interfaces on iOS](https://developer.apple.com/videos/wwdc/2012/)
-   [自旋锁](http://baike.baidu.com/item/%E8%87%AA%E6%97%8B%E9%94%81)

