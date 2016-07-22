# YYProject 基础工程
简介：这是一个基础工程，包含了model、db、net、tools还有一个baseController。

# 谁使用它
任何iOS开发人员（工程语言是Objective-C）都可以使用它。

#怎么解决编译错误
首先，不要抱怨工程下载完后，为什么还有错误，为什么不能直接运行？毕竟，解决编译错误是一个开发人员应该做的。
下载源代码，下载完之后，工程会报一些编译错误，这是因为我使用了一些第三方的类库。如果你之前知道[CocoaPods](http://www.cocoachina.com/ios/20140107/7663.html)这个东西。那么，在工程中，你可以找到“Podfile副本”文件，将名称改为“Podfile”，然后用控制台进入此目录，输入命令“pod update”就可以下载安装CocoaPods和里面提供所有类库。

#Podfile包含了哪些类库
* [MJRefresh](https://github.com/CoderMJLee/MJRefresh) 上下拉刷新：这个东东是国内一位大神写的，支持scrollView、collectionView、tableView等滚动视图的上下拉刷新，还可以自定义，相当perfect的解决方案。
* [AFNetworking](https://github.com/AFNetworking/AFNetworking) 网络请求：这个想必大家都很熟悉，国外大牛写的网络请求框架。
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD) 提示框：这个是非常经典的提示框。
* [SDWebImage](https://github.com/rs/SDWebImage) 图片管理：图片请求及管理库，相当不错的类库。
* [MJExtension](https://github.com/CoderMJLee/MJExtension) 模型生成：这个类库可以根据网络返回的json串生成对应的属性，减少很多手写代码量。


# 怎么使用 
### model：
* MJExtensionConfig：使用过MJExtension文件的都知道，这个文件是用于转换属性名称。
* YYTestData：测试的一个model，里面加入了NSCoding。

### db：
* YYConstants：包含了一些工程的常量，比如：iPhone机型判断、网络常量、界面UI常量、数据常量以及工程的统一色和缺省图等等。
* YYDataHandle：数据处理类，采用NSUserDefaults保存少量数据。

### net：
* YYAPI：网址字符串都存放在这里。
* YYNetManage：继承于AFHTTPSessionManager，以YYProjectBaseUrl为基础网址，并配置了securityPolicy和acceptableContentTypes。
* YYCommunication：网络与控制器的沟通类，你可以使用定义好的方法进行请求，请求包含get和post，还有图片上传，或者你也可以取消请求。YYCommunicationDelegate包含了网络请求返回数据的回调。

### tools：
* NSString+YYString：可以检测字符串是否为空、可以生成当前时间的字符串以及错误码的详细说明。
* UIImage+YYImage：这个工具类别中，你可以重构图片尺寸，可以单纯地修改图片颜色。
* UIView+YYView：处理视图边框。

### YYBaseViewController：
* 使用时，每个类继承于这个基础类。

### ViewController：
* 每次创建新的视图控制器时，可以直接拷贝该文件中的代码到新的视图控制器中。

# 有哪些值得使用的插件呢？
* [Alcatraz.xcplugin](http://blog.devtang.com/2014/03/05/use-alcatraz-to-manage-xcode-plugins/?utm_source=tuicool&utm_medium=referral)：管理iOS插件的好工具，值得下载。
* [VVDocumenter-Xcode.xcplugin]()：喵神开发的类似Java的注释工具，非常好用。
* [ESJsonFormat.xcplugin](http://www.oschina.net/p/ESJsonFormat-Xcode)：将 JSON 格式化输出为模型的属性。

# 想要修改工程名？
* 双击YYProject.xcworkspace，进入工程中。可以看到最顶层的工程project名字是YYProject，点击YYProject为可编辑状态，改为你想要的名字，比如DDTest。刚改完会弹出“Rename project content items？”点击rename。再点击OK。这时可以看到最顶层的工程project名字换成了DDTest。
* 工程名称虽然换了，但是文件夹的名称还没换。关掉工程，我们进入该工程的文件夹目录，直接修改工程最顶层文件夹名称“YYProject-master”，改为“DDTest”，点击“YYProject.xcworkspace”改为“DDTest.xcworkspace”,改完之后，点击“DDTest.xcworkspace”进入工程。
* 进入工程后发现它喵的，左侧菜单最顶层的“DDTest.xcodeproj”为红色，表示链接失败了。别担心，选中该文件，在右侧Identifier and Type中的Location下面有个小文件夹图标，点击弹出文件选择框，在文件选择框中找到“DDTest.xcodeproj”文件，点击Choose。点完后关闭工程，再重新打开，编译，运行，perfect！


