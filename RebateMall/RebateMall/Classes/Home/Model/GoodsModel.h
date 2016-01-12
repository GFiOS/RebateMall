//
//  GoodsModel.h
//  RebateMall
//
//  Created by 安帅 on 15/12/16.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel
// 图片
@property(copy,nonatomic)NSString  *icon;
// 主标题
@property(copy,nonatomic)NSString  *title;
// 描述信息
@property(copy,nonatomic)NSString  *detail;
// 优惠信息
@property(copy,nonatomic)NSString  *discount;
// 价格信息
@property(copy,nonatomic)NSString  *price;

@end
