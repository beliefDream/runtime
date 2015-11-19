//
//  Singleton.m
//  runtimeDemo
//
//  Created by zhs on 15/11/18.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
- (Singleton *)defaultSingleton {

/*
    static Singleton * singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Singleton alloc] init];
    });
    return singleton;
*/
    
    static Singleton * singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Singleton alloc] init];
    });
    return singleton;
}

/*
 5555
 1.	Objective-C有私有方法么？私有变量呢？如多没有的话，有没有什么代替的方法？
 objective-c 里面有私有方法, 但是没有绝对的私有方法, 有私有变量.
 @private来修饰私有变量
 
 2.	#import、#include和@class有什么区别
 #include c语言中引入一个头文件，但是可能出现交叉编译, OC里面已经没有这个方式引入头文件了, 统一使用#import
 #import在OC中引入自己创建的头文件#import””或者系统框架#import<>。#import不会出现交叉编译
 @class对一个类进行声明，告诉编译器有这个类，但是类的定义什么的都不知道.
 3.	谈谈你对MVC的理解？为什么要用MVC？在Cocoa中MVC是怎么实现的？你还熟悉其他的OC设计模式或别的设计模式吗？
 MVC是Model-VIew-Controller，就是模型－视图－控制器, MVC把软件系统分为三个部分：Model，View，Controller。在cocoa中，你的程序中的每一个object（对象）都将明显地仅属于这三部分中的一个，而完全不属于另外两个。MVC可以帮助确保帮助实现程序最大程度的可重用性。各MVC元素彼此独立运作，通过分开这些元素，可以构建可维护，可独立更新的程序组建, 提高代码的重用性.model数据模型，view是对这些数据的显示，viewcontroller就是把model拿到view中显示，起到model和view之间桥梁的作用。
 单例模式，delegate设计模式，target-action设计模式
 4.	如监测系统键盘的弹出
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector( ) name:UIKeyboardWillShowNotification object:nil];
 与系统自带的一些控件进行交互的时候，我们一般还是用通知中心，因为系统已经帮我们生成了固定的name来监听这些控件上的事件。
 可以看看IQKeyboardManager这个第三方库.
 
 5.	举出5个以上你所熟悉的ios  sdk库有哪些和第三方库有哪些？
 Foundation，CoreGraphics，UIKit,MapKit,CoreLocation,CFNetWork,MessageUI,ImageIO,CoreData，AFNetWorking,MKNetWorkKit,ASIHttpRequest,FMDB,ZXing,ZBar,SDWebImage
 6.	如何将产品进行多语言发布？
 程序的国际化
 具体怎样做，参考这篇博客：http://94it.net/a/jingxuanboke/2014/1225/432936.html
 7.	如何将敏感字变成**
 字符串替换stringByReplacingOccurrencesOfString:  withString:
 8.	objc中的减号与加号代表什么？
 +静态方法，也叫类方法，-实例方法, 当然也是运算符..
 9.	单例目的是什么，并写出一个？
 当一个类只能有一个实例的时候需要使用单例,也就是说这个类只有一个对象, 这个对象在程序运行期不释放, 可以用来记录数据,进行传值。创建参照第2个文件.
 10.	说说响应链
 当事件发生的时候，响应链首先被发送给第一个响应者(往往是事件发生的视图，也就是用户触摸屏幕的地方)。事件将沿着响应者链一直向下传递，直到被接受并作出处理。一般来说，第一响应这是个视图对象或者其子类，当其被触摸后事件就交由它处理，如果他不处理，事件就会被传递给视图控制器对象UIViewController（如果存在），然后是它的父视图对象（superview），以此类推直到顶层视图。接下来会沿着顶层视图（top view）到窗口(UIwindow 对象) 再到程序的（UIApplication对象），如果整个过程都没有响应这个事件，则该事件被丢弃，一般情况下，在响应链中只要有对象处理事件，事件就会被传递.
 
 */
@end
