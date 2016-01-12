//
//  NSString+CategoryFY.m
//  UMLifeAesthetes
//
//  Created by FYWCQ on 15/12/8.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "NSString+CategoryFY.h"

@implementation NSString (CategoryFY)


#pragma mark ----
+(NSString *)stringFromArray_nn:(NSArray *)array
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

-(id)JSON
{
    NSData *  data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id  dic = nil;
    NSError *error = nil;
    
    if (data) {
        if ([data length] > 0) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@" 解析json错误 %@",[error description]);
            }
        }
    }
    return dic;
}


@end
