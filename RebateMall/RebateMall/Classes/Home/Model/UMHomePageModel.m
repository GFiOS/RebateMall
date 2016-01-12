//
//  UMHomePageModel.m
//  UMLifeAesthetes
//
//  Created by umanto on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UMHomePageModel.h"

@implementation UMHomePageModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.description_s = [dic objectForKey:@"description"];
    }
    return self;
}
@end
