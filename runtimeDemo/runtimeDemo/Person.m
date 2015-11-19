//
//  Person.m
//  runtimeDemo
//
//  Created by zhs on 15/11/18.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)run {
    NSLog(@"- run");
}
+ (void)classRun {
    NSLog(@"+ run");
}


/*
 444
 1.	简述你对UIView、UIWindow和CALayer的理解
 UIView继承于UIResponder, UIResponder继承于NSObject,UIView可以响应用户事件。CALayer继承于NSObject，所以CALayer不能响应事件。
 UIView构建界面,UIView侧重于对内容的管理，CALayer侧重于对内容的绘制。
 UIView是用来显示内容的，可以处理用户事件；CALayer是用来绘制内容的，对内容进行动画处理，依赖与UIView来进行显示，不能处理用户事件。
 2.	写一个完整的代理，包括声明，实现
 略
 3.	分析json、xml的区别？json、xml解析方式的底层是如何处理的？
 XML是标准通用标记语言 (SGML)的子集，非常适合 Web 传输。XML 提供统一的方法来描述和交换独立于应用程序或供应商的结构化数据。
	JSON(JavaScriptObject Notation)一种轻量级的数据交换格式，具有良好的可读
	和便于快速编写的特性。可在不同平台之间进行数据交换。JSON采用兼容性很
	高的、完全独立 于语言文本格式，同时也具备类似于C语言的习惯(包括C,
	C++, C#, Java, JavaScript, Perl,Python等)体系的行为。这些特性使JSON成为理想
	的数据交换语言。
 4.	ViewController 的 didReceiveMemoryWarning 是在什么时候被调用的？默认的操作是什么?
 didReceiveMemoryWarning在出现内存警告的时候执行该方法，在该方法里面释放掉暂时没使用的可重用的对象。这个方法不能手动调用.
 
 5.	面向对象的三大特征，并作简单的介绍
 封装、继承、多态。封装：是把客观事物封装成抽象的类，隐藏内部的实现，对外部提供接口。继承：可以使用现有类的所有功能，并且在无需重新编写原来的类的情况下对这些功能进行扩展。多态：不同的对象以自己的方式响应相同的的消息的能力叫做多态，或者说父类指针指向子类对象<如UITableView的，cellForRow方法，返回值类型是UITbaleViewCell，但是你返回的cell可以是你自定义的cell,在比如多个类里面都有同一个方法>
 6.	重写一个NSStrng类型的，retain方式声明name属性的setter和getter方法
 7.	简述NotificationCenter、KVC、KVO、Delegate？并说明它们之间的区别？
 Notification：观察者模式，观察者模式一般用于一对多, 发出消息者并不在意有没有\有多少个接收者, 只管发出消息. 观察者模式的效率低于代理模式.
 KVC键值编码，可以直接通过字符串的名字（key）或者路径来间接访问属性的机制，而不是通过调用getter和setter方法访问。
 KVO：观测指定对象的属性，当指定对象属性的setter方法被调用之后会通知相应的观察者。
 delegate:一对一，delegate遵循某个协议并实现协议声明的方法。
 8.	What is lazy loading?
 懒加载，又称为延迟加载。通常用法，你有一个UITextField类 型的property，简单定义为userNameTextField，但是你不在初始化方法里为其alloc/init，它就只是一个指针，不会占用内 存。在访问器里判断此property的指针是否为空，若为空，就alloc/init，这时才真正生成这个对象除非这个对象被使用，否则它永远不会真正 生成，也就不会占用内存。
 9.	什么是Protocol？什么是代理？写一个委托的interface？委托的property声明用什么属性？为什么？
 协议提供了一组方法，但是并不负责实现，如果一个类遵循了某个协议，并且实现了协议里面的方法，那么我们称这个类就是遵循了某个协议的代理。属性的声明使用assign，防止出现循环引用的问题。
 10.	分别描述类别（categories）和延展（extensions）是什么？以及两者的区别？继承和类别在实现中有何区别？为什么Category只能为对象添加方法，却不能添加成员变量？
 category类目：在不知道源码的情况下为一个类扩展方法，extension：为一个类声明私有方法和变量。
 继承是创建了一个新的类，而类别只是对类的一个扩展，还是之前的类。
 类目的作用就是为已知的类添加方法。
 
 */
@end
