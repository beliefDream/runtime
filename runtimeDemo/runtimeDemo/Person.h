//
//  Person.h
//  runtimeDemo
//
//  Created by zhs on 15/11/18.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString * _name;
    NSString * _weight;
}
- (void)run;
+ (void)classRun ;
@end
