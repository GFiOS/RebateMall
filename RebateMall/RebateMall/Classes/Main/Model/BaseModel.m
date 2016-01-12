//
//  BaseModel.m
//
//  Created by umanto on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(instancetype)initWithDictionay:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)modelWithDictionay:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}

// 使用 setValuesForKeysWithDictionary： 这个方法 给属性赋值 会紧接着调用这个方法 key 是字典的key值 value 是key值 在字典里对应的值
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

//  如果字典里的 key 值 没有对应的属性 会调用这个方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    DebugLog(@"Undefined Key %@ in %@",key,[self class]);
    
}

@end
