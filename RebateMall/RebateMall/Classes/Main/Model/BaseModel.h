//
//  BaseModel.h
//
//  Created by umanto on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDictionay:(NSDictionary *)dic;

+ (instancetype)modelWithDictionay:(NSDictionary *)dic;
@end
