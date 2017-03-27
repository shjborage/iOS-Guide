# Using the Package Manager

Swift 有自己的包管理器，不像 `Objective-C` 需要类似 `CocoaPods` 这样第三方的包管理器，这也是与时俱进的表现。

## 创建 package

在命令行中执行：`swift package init`，会在当前目录，创建一个 package：

![-w439](http://shjborage-public.qiniudn.com/2017-03-13-14893141996920.jpg)

`Package.swift` 是每一个 package 根目录下**必须**有的一个文件。

## 编译 package
 
在 package 根目录，执行 `swift build`

``` shell
Compile Swift Module 'ExamplePackage' (1 sources)
```

编译过程会在当前目录创建 `.build` 目录，编译过程中的各类文件都在这（部分）：

![-w459](http://shjborage-public.qiniudn.com/2017-03-13-14893149715511.jpg)


## 测试 package

在 package 根目录，执行 `swift test`

```shell
Compile Swift Module 'ExamplePackageTests' (1 sources)
Linking ./.build/debug/ExamplePackagePackageTests.xctest/Contents/MacOS/ExamplePackagePackageTests
Test Suite 'All tests' started at 2017-03-12 18:25:28.613
Test Suite 'ExamplePackagePackageTests.xctest' started at 2017-03-12 18:25:28.615
Test Suite 'ExamplePackageTests' started at 2017-03-12 18:25:28.615
Test Case '-[ExamplePackageTests.ExamplePackageTests testExample]' started.
Test Case '-[ExamplePackageTests.ExamplePackageTests testExample]' passed (0.003 seconds).
Test Suite 'ExamplePackageTests' passed at 2017-03-12 18:25:28.618.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.003 (0.003) seconds
Test Suite 'ExamplePackagePackageTests.xctest' passed at 2017-03-12 18:25:28.619.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.003 (0.004) seconds
Test Suite 'All tests' passed at 2017-03-12 18:25:28.619.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.003 (0.006) seconds
```

## 创建可执行的 package

![-w706](http://shjborage-public.qiniudn.com/2017-03-13-14893147547781.jpg)

`swift package init --type executable`

![-w352](http://shjborage-public.qiniudn.com/2017-03-13-14893148462076.jpg)

 创建完成后，发现其实只是 Sources 中的 swift 文件名变为 `main.swift`。
 
 `swift build` 编译，然后测试一下 `.build/debug/Hello`。
 ![-w527](http://shjborage-public.qiniudn.com/2017-03-13-14893150539637.jpg)


### 多源文件

可在 `Sources` 目录下直接创建，并不需要 `import` 就可直接使用。
详细情况见 [Demo](/Demo/Swift/HelloPackage/)，后面详细研究这块的实现。 [TODO](https://swift.org/package-manager/)


