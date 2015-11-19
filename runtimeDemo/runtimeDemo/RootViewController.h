//
//  RootViewController.h
//  runtimeDemo
//
//  Created by zhs on 15/11/18.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
/**
 *  1, runtime 的简单使用
 */
- (void)useRuntime ;


/**
 *  2， NSThread  简单使用
 */
- (void)useNSThread ;

/**
 *  3， GCD  简单使用
 */
- (void)useGCD ;

/**
 *  4， NSOperationQueue  简单使用
 */
- (void)useOperateQueue ;


/**
 *  5  使用 UITableView+FDTemplateLayoutCell  第三方 搞定文本适配
 */
@end
