//
//  NSString+CategoryFY.h
//  UMLifeAesthetes
//
//  Created by FYWCQ on 15/12/8.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CategoryFY)


/**
 * 字典变字符串
 */
+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary;

/**
 * 数组变字符串
 */
+(NSString *)stringFromArray_nn:(NSArray *)array;

/**
 * 字符串 转 Json
 */
-(id )JSON;


@end
