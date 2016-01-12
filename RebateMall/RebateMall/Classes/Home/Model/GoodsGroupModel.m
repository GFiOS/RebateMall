//
//  GoodsGroupModel.m
//  RebateMall
//
//  Created by 安帅 on 15/12/16.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "GoodsGroupModel.h"
#import "GoodsModel.h"

@implementation GoodsGroupModel
- (NSArray *)goods
{
    if (_goods == nil)
    {
        _goods  = [[NSArray alloc]init];
//        // 图片
//        @property(copy,nonatomic)NSString  *icon;
//        // 主标题
//        @property(copy,nonatomic)NSString  *title;
//        // 描述信息
//        @property(copy,nonatomic)NSString  *detail;
//        // 优惠信息
//        @property(copy,nonatomic)NSString  *discount;
//        // 价格信息
//        @property(copy,nonatomic)NSString  *price;
        
        NSMutableArray *tempArr = [NSMutableArray array];
        // 假数据
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"_0000" forKey:@"icon"];
        [dic setObject:@"潮流男装" forKey:@"title"];
        [dic setObject:@"卡玛新品发布 2015新款" forKey:@"detail"];
        [dic setObject:@"首单立返30元" forKey:@"discount"];
        [dic setObject:@"153" forKey:@"price"];
        
        for (int i = 0; i < 10; i++) {
            GoodsModel *model = [[GoodsModel alloc]initWithDictionay:dic];
            [tempArr addObject:model];
        }
        _goods = tempArr;
    }
    
    return _goods;
}
@end
