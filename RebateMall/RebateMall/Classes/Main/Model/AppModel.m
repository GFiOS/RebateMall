//
//  AppShareModel.m
//  小荐风景
//
//  Created by Medalands on 15/9/2.
//  Copyright (c) 2015年 silence. All rights reserved.
//


#import "AppModel.h"

@implementation AppModel

static id _instance = nil;
/**
 *  alloc方法会调用此方法(防止在alloc时，重复创建对象)
 *
 *  @param zone 分配的内存空间
 *
 *  @return 实例对象
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_instance == nil)  // 防止多次创建
    {
        @synchronized(self) // 多线程安全
        {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

+ (instancetype)shareAppModel
{
    if (_instance == nil)  // 防止多次创建
    {
        @synchronized(self) // 多线程安全
        {
            _instance = [[self alloc]init];
        }
    }
    return _instance;
}

/**
 *  copy方法会调用该方法（防止在copy时，创建新的对象）
 *
 *  @param zone
 */
- copyWithZone:(struct _NSZone *)zone
{
    return _instance;
}

@end
