//
//  UMHomePageModel.h
//  UMLifeAesthetes
//
//  Created by umanto on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UMHomePageModel : BaseModel
/**
 * 商品图片
 */
@property (nonatomic ,copy) NSString *cat_file_url;
@property (nonatomic ,copy) NSString *add_time;
@property (nonatomic ,copy) NSString *article_id;
@property (nonatomic ,copy) NSString *article_type;
@property (nonatomic ,copy) NSString *author;
@property (nonatomic ,copy) NSString *author_email;
@property (nonatomic ,copy) NSString *cat_id;
@property (nonatomic ,copy) NSString *cat_link;
@property (nonatomic ,copy) NSString *cat_name;
@property (nonatomic ,copy) NSString *click_count;
@property (nonatomic ,copy) NSString *collect_num;
@property (nonatomic ,copy) NSString *content;
/**
 * 描述
 */
@property (nonatomic ,copy) NSString *description_s;
@property (nonatomic ,copy) NSString *file_url;
@property (nonatomic ,copy) NSString *is_open;
@property (nonatomic ,copy) NSString *keywords;
@property (nonatomic ,copy) NSString *link;
@property (nonatomic ,copy) NSString *open_type;
@property (nonatomic ,copy) NSString *title;

@property (nonatomic ,strong) NSArray *goods;



@end
