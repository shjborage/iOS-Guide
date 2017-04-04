# 一个 iOS 工程的技术全景

## topics
### 规范
#### [代码规范](https://github.com/shjborage/CodingStyle)
目前只有 Objective-C 和提交代码的规范，Swift 的代码规范目前只有 fork 的英文版，后续将其翻译成中文版。
#### 编程守则
里面包含了「最佳实践」和「不要踩的坑」

#### 页面布局规范
独立 app 使用 storyboard，同时使用 AutoLayout 及 [Size Class](https://useyourloaf.com/blog/size-classes/)；  
SDK 开发，使用纯代码开发，保证接入成本低。


#### SCM
首选 git，如果公司内部支持 github 或者 gitlab 的话，那是极好的。  
类似的还有：[Bitbucket](https://bitbucket.org)，相对 github 来说好处是可以免费使用 private repo。

##### Code Review
在 SCM 选择的基础上做 CR，如果是 github 或 gitlab 那就省事了，因为已经内置 CR。如果是使用 svn 或者无 CR 的 SCM 体系的话，[gerrit](https://www.gerritcodereview.com/) 是一个不错的选择。

##### 开发模式
主干开发、分支开发、flow（git-flow）等

##### 持续集成
[Travis CI](https://travis-ci.org/) 或类型的服务应该是一个不错的选择。但之前主要是在开源项目里使用，内部项目的话要调研一下。  
建议再考虑一下 [Jenkins](https://jenkins.io/)，玩法比较丰富，可以做的事也比较多。

### 项目管理工具
各种项目管理工具都可以，Team 都能接受，方便使用即可。现在连 github 都有了 *Project* 模块，也可以用起来。

#### 需求管理系统
比如 github 的 *Project*，可以分阶段来管理需求（story）。

#### Bug 管理系统
比如 github 的 *issue*。

### framework
不得不提静态库与 framework, 可以将部分功能抽象成『库』，共享给社区或其它项目使用。当然我们也会使用很多开源的『库』，这里提一下两个常用的三方库管理工具 `CocoaPods` 与 `Cathage`。

> 引一段 [onevcat](https://onevcat.com) 的介绍

在使用框架的时候，用一些包管理和依赖管理工具可以简化使用流程。其中现在使用最广泛的应该是 [CocoaPods](http://cocoapods.org](http://cocoapods.org)。

CocoaPods 是一个已经有五年历史的 ruby 程序，可以帮助获取和管理依赖框架。

CocoaPods 的主要原理是框架的提供者通过编写合适的 PodSpec 文件来提供框架的基本信息，包括仓库地址，需要编译的文件，依赖等 用户使用 Podfile 文件指定想要使用的框架，CocoaPods 会创建一个新的工程来管理这些框架和它们的依赖，并把所有这些框架编译到成一个静态的 libPod.a。然后新建一个 workspace 包含你原来的项目和这个新的框架项目，最后在原来的项目中使用这个 libPods.a

这是一种“侵入式”的集成方式，它会修改你的项目配置和结构。

本来 CocoaPods 已经准备在前年发布 1.0 版本，但是 Swift 和动态框架的横空出世打乱了这个计划。因为必须提供对这两者的支持。不过最近 1.0.0 的 beta 已经公布，相信这个历时五年的项目将在最近很快迎来正式发布。

从 0.36.0 开始，可以通过在 Podfile 中添加 `use_frameworks!` 来编译 CocoaTouch Framework，也就是动态框架。

因为现在 Swift 的代码只能被编译为动态框架，所以如果你使用的依赖中包含 Swift 代码，又想使用 CocoaPods 来管理的话，必须选择开启这个选项。

`use_frameworks!` 会把项目的依赖全部改为 framework。也就是说这是一个 none or all 的更改。你无法指定某几个框架编译为动态，某几个编译为静态。我们可以这么理解：假设 Pod A 是动态框架，Pod B 是静态，Pod A 依赖 Pod B。要是 app 也依赖 Pod B：那么要么 Pod A 在 link 的时候找不到 Pod B 的符号，要么 A 和 app 都包含 B，都是无解的情况。

使用 CocoaPods 很简单，用 Podfile 来描述你需要使用和依赖哪些框架，然后执行 pod install 就可以了。下面是一个典型的 Podfile 的结构。

```
# Podfile
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  pod 'AFNetworking', '~> 2.6'
  pod 'ORStackView', '~> 3.0'
  pod 'SwiftyJSON', '~> 2.3'
end

$ pod install
```

Carthage 是另外的一个选择，它是在 Cocoa Touch Framework 和 Swift 发布后出现的专门针对 Framework 进行的包管理工具。

Carthage 相比 CocoaPods，采用的是完全不同的一条道路。Carthage 只支持动态框架，它仅负责将项目 clone 到本地并将对应的 Cocoa Framework target 进行构建。之后你需要自行将构建好的 framework 添加到项目中。和 CocoaPods 需要提交和维护框架信息不同，Carthage 是去中心化的 它直接从 git 仓库获取项目，而不需要依靠 podspec 类似的文件来管理。

使用上来说，Carthage 和 CocoaPods 类似之处在于也通过一个文件 `Cartfile` 来指定依赖关系。

```
# Cartfile
github "ReactiveCocoa/ReactiveCocoa"
github "onevcat/Kingfisher" ~> 1.8
github "https://enterprise.local/hello/repo.git"

$ carthage update
```

在使用 Framework 的时候，我们需要将用到的框架 Embedded Binary 的方式链接到希望的 App target 中。

随着上个月 Swift 开源，有了新的可能的选项，那就是 Swift Package Manager。这可能是未来的包管理方式，但是现在暂时不支持 iOS 和 tvOS （也就是说 UIKit 并不支持）。

Package Manager 实际上做的事情和 Carthage 相似，不过是通过 llbuild （low level build system）的跨平台编译工具将 Swift 编译为 .a 静态库。

这个项目很新，从去年 11 月才开始。不过因为是 Apple 官方支持，所以今后很可能会集成到 Xcode 工具链中，成为项目的标配，非常值得期待。但是现在暂时还无法用于应用开发。

>  结束引用

### 日志系统
### 统计埋点
#### Crash 收集
### App 架构
#### 页面跳转机制
#### 在线配置

### Checklist
#### 提测 Check
#### 上线前 Check
