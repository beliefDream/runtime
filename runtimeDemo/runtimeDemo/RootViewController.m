//
//  RootViewController.m
//  runtimeDemo
//
//  Created by zhs on 15/11/18.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import "RootViewController.h"
#import "Person.h"
#import <objc/message.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "PersonCell.h"
#import <Masonry.h>

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation RootViewController
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1、从资源读取 , 这个方法的图片是从缓存里面获取的, 先在缓存里面查看是不是有这个图片, 没有的话将图片添加进缓存再使用. 有的话直接使用缓存里面的. 如果这张图片用的次数比较多的话, 建议使用这种方式. 缺点是效率低下.",
                      @"UIImage *image = [UIImage imageNamed:@”1.png”];",
                      @"2 .从手机本地读取, 比较第一种方式, 这个事直接加载图片的. 所以建议在图片使用率低的图片时 使用这个方法.",
                      //读取本地图片非resource
                      @"NSString *aPath3=[NSString stringWithFormat:",
                      @"[UIImage imageWithContentsOfFile:aPath3]",
                      @"1、从资源读取 , 这个方法的图片是从缓存里面获取的, 先在缓存里面查看是不是有这个图片, 没有的话将图片添加进缓存再使用. 有的话直接使用缓存里面的. 如果这张图片用的次数比较多的话, 建议使用这种方式. 缺点是效率低下.",
                      @"UIImage *image = [UIImage imageNamed:@”1.png”];",
                      @"2 .从手机本地读取, 比较第一种方式, 这个事直接加载图片的. 所以建议在图片使用率低的图片时 使用这个方法.",
                      //读取本地图片非resource
                      @"NSString *aPath3=[NSString stringWithFormat:",
                      @"[UIImage imageWithContentsOfFile:aPath3]",nil];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self useRuntime];
    
//    [self useNSThread];
    
//    [self useGCD];
    
//    [self useOperateQueue];
    
    UILabel * label = [UILabel new];
    label.numberOfLines = 0;
    label.text = [self.dataArray objectAtIndex:1];
    [self.view addSubview:label];
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 320, 400)
                                                           style:UITableViewStyleGrouped];
//    UITableView * tableView = [UITableView new];
    [tableView registerClass:[PersonCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(10);
        make.left.right.equalTo(label);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
//    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.fd_enforceFrameLayout = NO;
    cell.inforStr = [self.dataArray objectAtIndex:indexPath.row];
    NSLog(@"... %@", NSStringFromCGRect(cell.label.frame));
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"cell"
                                    cacheByIndexPath:indexPath
                                       configuration:^(PersonCell * cell) {
//                                           cell.fd_enforceFrameLayout = NO;
                                           cell.inforStr = [self.dataArray objectAtIndex:indexPath.row];
                                       }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark useRuntime 
- (void)useRuntime {
    Person * person = [[Person alloc] init];
    objc_msgSend(person, @selector(run));
    objc_msgSend([person class], @selector(classRun));
    
    //打印实例变量列表
    unsigned int ivarCount = 0;
    Ivar * ivarList = class_copyIvarList([Person class], &ivarCount);
    NSLog(@"count: = %d", ivarCount);
    for (int i = 0; i< ivarCount; i++) {
        Ivar ivar = ivarList[i];
        const char * name = ivar_getName(ivar);
        NSLog(@" name %s",name);
    }
    
    
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList([Person class], &methodCount);
    for (int i = 0 ; i < methodCount; i++) {
        Method method= methodList[i];
        SEL methodSel = method_getName(method);
        NSString * methodName = NSStringFromSelector(methodSel);
        NSLog(@"method Name %@", methodName);
    }
}

#pragma mark 多线程的简单使用  NSThread
- (void)useNSThread {
/*
    //NSThread 使用第一种方式，创建NSThread 对象后，需要手动开启线程
    NSThread * thread = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(threadOperation)
                                                  object:nil];
    [thread start];
*/
    
    //NSThread  使用第二种方式， 不需要手动开启线程
    [NSThread detachNewThreadSelector:@selector(threadOperation)
                             toTarget:self
                           withObject:nil];
}

- (void)threadOperation {
    NSLog(@"threadOperation");
}


#pragma mark    GCD

/**
 *  GCD  苹果主推的一种多线程技术，
 *  1  是一套纯c 的代码， 抽象程度高，执行效率也高
 *  2  GCD 的某些方法里面考虑到了线程安全的问题
 */
- (void)useGCD {
    //获取串行队列
    dispatch_queue_t serialQueue = dispatch_get_main_queue();
    dispatch_async(serialQueue, ^{
        NSLog(@"serialQueue 串行队列");
    });
    
    //获取并行队列
    dispatch_queue_t concorentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concorentQueue, ^{
        NSLog(@" 并行队列");
    });
    
    dispatch_sync(concorentQueue, ^{
        NSLog(@"同步");
    });
    
    /*
     //会造成线程死锁
    dispatch_sync(serialQueue, ^{
        NSLog(@"yes");
    });
     */
    
    //自己手动创建，串行，并行队列
    dispatch_queue_t createSerialQueue = dispatch_queue_create("customSerialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t createCorentQueue = dispatch_queue_create("customCorentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(createCorentQueue, ^{
        NSLog(@"1");
    });
    dispatch_async(createCorentQueue, ^{
        NSLog(@"2");
    });
    //这是个障碍
    dispatch_barrier_async(createCorentQueue, ^{
        NSLog(@" 这是个障碍");
    });

    dispatch_async(createCorentQueue, ^{
        NSLog(@"3");
    });
    dispatch_async(createCorentQueue, ^{
        NSLog(@"4");
    });
    /*
    dispatch_sync(createSerialQueue, ^{
        NSLog(@"5");
    });*/
    
    
    //这是一个延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"6 延迟操作");
    });
}

#pragma mark  NSOperationQueue 的使用
- (void)useOperateQueue {
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = -1;
    
    NSBlockOperation * blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block operate 1");
    }];

    NSBlockOperation * blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block operate 2");
    }];

    NSInvocationOperation * invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                                       selector:@selector(invocationOperate)
                                                                                         object:nil];
    BOOL isFinish = invocationOperation.isFinished;
//    [invocationOperation cancel];

    [invocationOperation addDependency:blockOperation1];
    [invocationOperation addDependency:blockOperation2];
    
    //将任务加到队列中， 队列中并发执行任务
    [queue addOperation:blockOperation1];
    [queue addOperation:blockOperation2];
    [queue addOperation:invocationOperation];
}

- (void)invocationOperate {
    @autoreleasepool {
        NSLog(@"子线程1 ");
        /*
        [self performSelectorOnMainThread:@selector(backMainThreadAction)
                               withObject:self
                            waitUntilDone:YES];*/
    }

}
- (void)backMainThreadAction {

}

/*
  3333
 1.	描述应用程序的启动顺序。
 1、程序入口main函数创建UIApplication实例和UIApplication代理实例
 2、在UIApplication代理实例中重写启动方法，设置第一ViewController
 3、在第一ViewController中添加控件，实现对应的程序界面。
 
 为什么很多内置类如UITableViewControl的delegate属性都是assign而不是retain？请举例说明。
 防止循环引用，
 Student * str=[];
 Teacher *teacher=[[Teacher alloc] init];
 Student * student=[[Student alloc] init];
 teacher.delegate=student;
 student.delegate= teacher;
 在teacher中dealloc会release当前的Delegate，就会触发student对象release，继而也会导致student执行dealloc，在student中也会release自己的delegate，产生循环了。
 2.	使用UITableView时候必须要实现的几种方法？
 2个。
 -(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section; 这个方法返回每个分区的行数
 -(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath)indexPath;这个方法返回我们调用的每一个单元格
 3.	写一个便利构造器。
 + (id)studentWithName:(NSString *)newName andAge:(int)newAge
 {
 Student *stu = [[Student alloc] initWithName:newName andAge:newAge];
 return [stu autorelease];
 }
 4.	UIImage初始化一张图片有几种方法？简述各自的优缺点。
 1、从资源读取 , 这个方法的图片是从缓存里面获取的, 先在缓存里面查看是不是有这个图片, 没有的话将图片添加进缓存再使用. 有的话直接使用缓存里面的. 如果这张图片用的次数比较多的话, 建议使用这种方式. 缺点是效率低下.
 UIImage *image = [UIImage imageNamed:@”1.png”];
 2 .从手机本地读取, 比较第一种方式, 这个事直接加载图片的. 所以建议在图片使用率低的图片时 使用这个方法.
 //读取本地图片非resource
 NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),@"test"];
 [UIImage imageWithContentsOfFile:aPath3]
 5.	回答person的retainCount值，并解释为什么
 Person * per = [[Person alloc] init];
 self.person = per;
 person属性如果为assign的话retainCount为1，如果为retain的话retainCount为2
 6.	这段代码有什么问题吗:
 @implementation Person
 - (void)setAge:(int)newAge {
 self.age = newAge;
 }
 @end
 死循环
 7.	这段代码有什么问题,如何修改
 for (int i = 0; i < someLargeNumber; i++) {
 NSString *string = @”Abc”;
 string = [string lowercaseString];
 string = [string stringByAppendingString:@"xyz"];
 NSLog(@“%@”, string);
 }
 如果数字很大的话会造成内存一直增加（因为一直通过便利构造器方法创建autorelease对象），直到循环结束才减少，在循环内加一个自动释放池，更改后代码如下：
 for (int i = 0; i < someLargeNumber; i++) {
 NSString *string = @”Abc”;
 @autoreleasepool {
	string = [string lowercaseString];
	string = [string stringByAppendingString:@"xyz"];
	NSLog(@“%@”, string);
 
 }
 }
 
 8.	截取字符串”20 | http://www.baidu.com”中，”|”字符前面和后面的数据，分别输出它们。
 NSString *string = @” 20 | http://www.baidu.com”;
 [string componentsSeparatedByString:@”|”];
 
 9.	用obj-c写一个冒泡排序
 NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"3",@"1",@"10",@"5",@"2",@"7",@"12",@"4",@"8"]];
 for (int i = 0; i < array.count -1; i ++) {
 for (int j = 0; j < array.count  - 1 - i; j++) {
 if ([[array objectAtIndex:j] integerValue] > [[array objectAtIndex:j + 1] integerValue]) {
 [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
 }
 }
 }
 NSLog(@"%@", array);
 
 
 
  
 
 
 

66666
 
 1、请写出代码,用blocks来取代上例中的protocol,并比较两种方法的优势。实际应用部分？请写出代码，用blocks取代协议或回调方法
 声明：
 #import <Foundation/Foundation.h>
 typedef void(^TestBlock)(NSString *string);
 @interface LO_Person : NSObject
 + (void)showStringFromBlcok:(TestBlock)justBlock;
 @end
 实现：
 #import "LO_Person.h"
 
 @implementation LO_Person
 
 + (void)showStringFromBlcok:(TestBlock)justBlock
 {
 NSString *str = @"测试blcok";
 justBlock(str);
 }
 @end
 调用：
 [LO_Person showStringFromBlcok:^(NSString *string) {
 NSLog(@"-- %@",string);
 }];
 
 1.	你做iphone开发时候，有哪些传值方式，view和Controller之间是如何传值的？
 属性、delegate、block, 通知, 单例.
 2.	给定的一个字符串，判断字符串中是否还有png，有就删除它？
 [string stringByReplacingOccurrencesOfString:@"png" withString: @""]
 3.	对于语句NSString* testObject = [[NSData alloc] init];testObject 在编译时和运行时分别是什么类型的对象？
 编译的时候是NSString类型，运行的时候是NSData类型
 4.	OC中是所有对象间的交互是如何实现的？
 消息发送机制
 5.	目标-动作机制
 目标是动作消息的接收者。动作是控件发送给目标的消息，或者从目标的角度看，它是目标为了响应动作而实现的方法。常用的UIButton添加方法
 6.	for(int index = 0; index < largenumber; index ++){
 NSString *tempStr = @”tempStr”;
 NSLog(tempStr);
 NSNumber *tempNumber = [NSNumber numberWithInt:2];
 NSLog(tempNumber);
 }
 这段代码有什么问题.？会不会造成内存泄露（多线程）？在内存紧张的设备上做大循环时自动释放池是写在循环内好还是循环外好？为什么？
 参照第三个文档
 7.	描述上拉加载、下拉刷新的实现机制？
 一般上拉加载和下拉刷新是使用在请求网络数据的时候, 根据下拉或者上拉的距离来判断是否进行网络请求, 当请求结束以后, 将收回上拉或者下拉的提示框.
 8.	什么是沙盒（sandbox）？沙盒包含哪些文件，描述每个文件的使用场景。如何获取这些文件的路径？如何获取应用程序包中文件的路径？
 iOS应用程序只能在为该改程序创建的文件系统中读取文件，不可以去其它地方访问，此区域被成为沙盒，所以所有的非代码文件都要保存在此，例如图像，图标，声音，映像，属性列表，文本文件等。
 默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp。
 Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 Library：存储程序的默认设置或其它状态信息；
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 tmp：提供一个即时创建临时文件的地方。
 iTunes在与iPhone同步时，备份所有的Documents和Library文件。iPhone在重启时，会丢弃所有的tmp文件。
 9.	介绍一下XMPP？有什么优缺点吗？
 XMPP：基于XML的点对点的即时通讯协议。
 XMPP 协议是公开的，XMPP 协议具有良好的扩展性，安全性
 缺点是丢包率比较高
 10.	谈谈对性能优化的看法，如何做？
 从用户体验出发：1、程序logging不要太长、2、相同数据不做重复获取、3、昂贵资源要重用（cell、sqlite、data），4、良好的编程习惯和程序设计：选择正确的集合对象和算法来进行编程、选择适合的数据存储格式（plist、SQLite）、优化SQLite查询语句5、数据资源方面的优化（缓存和异步加载）6. 永远不要一直请求M7协处理器几率的数据, 会造成设备发热.
 解决方案：
 •	能够发现问题
 •	利用log或工具分析问题原因
 •	假设问题原因
 •	改进代码和设计
 http://blog.csdn.net/yangxt/article/details/8173412
 
 
 7777
 1.	应用程序如何省电？
 1:及时关闭定位.2不要频繁的请求网络,作本地存储.让用户主动的更新数据(上下拉刷新).3:提升程序的算法,优化代码,提高代码的质量.4:蓝牙, 需要才连接,用完及时断开.5:界面的渲染,(游戏中)尽量提升效率,减少渲染次数.
 2.	写一个递归方法：计算N的阶乘，然后将计算结果进行存储。以便应用退出后下次启动课直接获取该值。
 double fun(int n)
	{
	if(n==0||n==1)
 return 1;
	else
 return n*fun(n-1);
 }
 3.	NSArray和NSMutableArray的区别，多线程操作哪个更安全？
 NSArray不可变数组，NSMutableArray可变数组，NSArray更安全，多线程操作的时候记得加锁。GCD线程是安全的.
 4.	当前有一个数组，里面有若干重复的数据，如何去除重复的数据？（会几个写几个）
 最简单的方式，把数组里面的元素放到集合里面。
 也可以对数组进行排序，排序之后把数组里相同的元素删除掉
 放进字典里面, 把数组里面的元素当做key.
 5.	isKindOfClass、isMemberOfClass作用分别是什么？
 -(BOOL) isKindOfClass: classObj判断是否是这个类或者是这个类子类的实例
 -(BOOL) isMemberOfClass: classObj 判断是否是这个类的实例
 6.	请写出以下代码的执行结果
 NSString  * name = [ [ NSString alloc] init ];
 name = @”Habb”;
 [ name  release]；
 第一行：[ [ NSString alloc] init ]在堆区开辟一块内存，name指向堆区的这快内存，第二行：name指向常量区，这个时候堆区的内存没有释放也没有指针指向，会造成内存泄露
 7.	请分别写出SEL、id的意思？
 SEL选择器, id泛对象类型,id 不是类型，只是在编译的时候不指定它的类型，把类型的确定放到程序运行过程中。
 8.	iPhone上，不能被应用程序直接调用的系统程序是什么？
 时钟、视频、指南针、天气、计算器、备忘录、提醒事件、股市
 http://blog.sina.com.cn/s/blog_7dc11a2e01016qve.html
 http://blog.csdn.net/yhawaii/article/details/7587355
 9、以.mm为拓展名的文件里，可以包含的代码有哪些？c和obj-c如何混用
 obj-c的编译器处理后缀为m的文件时，可以识别obj-c和c的代码， 处理mm文件可以识别obj-c,c,c++代码，但cpp文件必须只能用c/c++代码，而且cpp文件include的头文件中，也不能出现obj- c的代码，因为cpp只是cpp
 2) 在mm文件中混用cpp直接使用即可，所以obj-c混cpp不是问题
 3）在cpp中混用obj- c其实就是使用obj-c编写的模块是我们想要的。
 如果模块以类实现，那么要按照cpp class的标准写类的定义，头文件中不能出现obj-c的东西，包括#import cocoa的。实现文件中，即类的实现代码中可以使用obj-c的东西，可以import,只是后缀是mm。
 如果模块以函数实现，那么头文件要按 c的格式声明函数，实现文件中，c++函数内部可以用obj-c，但后缀还是mm或m
 10、说说如何进行后台运行程序？
 1、检查设备是否支持多任务
 - (BOOL) isMultitaskingSupported{
 
 BOOL result = NO;
 if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
 {
 result = [[UIDevice currentDevice] isMultitaskingSupported];
 }
 return result;
 }
 2、applicationDidEnterBackground和applicationWillEnterForeground（UIApplicationDidEnterBackgroundNotification和UIApplicationWillEnterForegroundNotification）
 3、声明你需要的后台任务（在Info.plist中添加Required background modes键值：audio、location）
 11、sizeof和strlen的区别和联系
 sizeof是运算符，strlen是函数
 char str[20]="0123456789";
 int a=strlen(str); //a=10; >>>> strlen 计算字符串的长度，以结束符 0x00 为字符串结束。
 int b=sizeof(str); //而b=20; >>>> sizeof 计算的则是分配的数组 str[20] 所占的内存空间的大小，不受里面存储的内容改变。
 12、sprintf,strcpy,memcpy的功能？使用上要有哪些要注意的地方
 char*strcpy(char *dest, const char *src);
 其对字符串进行操作，完成从源字符串到目的字符串的拷贝,当源字符串的大小大于目的字符串的最大存储空间后，执行该操作会出现段错误。
 int sprintf(char*str, const char *format, ...)
 函数操作的源对象不限于字符串：源对象可以是字符串、也可以是任意基本类型的数据。主要是实现将其他数据类型转换为字符串
 void *memcpy(void*dest, const void *src, size_t n)
 实现内存的拷贝，实现将一块内存拷贝到另一块内存。该函数对源对象与目的对象没有类型现在，只是对内存的拷贝
 9.	自己写函数，实现strlen功能
 判断的时候注意“\0”
 10.	写一个代码片段输入一个字符串“- ”,输出一个NSDate类型的对象，打印该对象输出2013-03-22 15：28：32
 NSDateFormatter  @“yyyy-MM-dd HH:mm:ss”参考：http://www.cnblogs.com/Cristen/p/3599922.html
 11.	找错误
 a：void test1()
 {
 　char string[10];
 　char* str1 = "0123456789";
 　strcpy( string, str1 );//注意strcpy特点
 }
 b:void GetMemory( char **p, int num )
 {
 　*p = (char *) malloc( num );//分配了内存空间，但是没有释放 ， 释放空间用free关键字
 }
 void Test( void )
 {
 　char *str = NULL;
 　GetMemory( &str, 100 );
 　strcpy( str, "hello" );
 　printf( str );
 }
 12.	用变量a写出以下定义
 a、一个整型数   int a;
 b、一个指向整型数的指针 int *a;
 c、一个指向指针的指针，它指向的指针是指向一个整型数  int **a;
 d、一个有10个整型数的数组  int a[10];
 e、一个有10个指针的数组，该指针是指向一个整型数的  int *a[10];
 f、一个指向有10个整型数数组的指针  int (*a)[10];
 g、一个指向函数的指针，该函数有一个整型参数，并返回一个整型数 int(*a)(int);
 
 
 
 
 */




@end

