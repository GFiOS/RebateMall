//
//  AppShareModel.h
//  小荐风景
//
//  Created by Medalands on 15/9/2.
//  Copyright (c) 2015年 silence. All rights reserved.
//
/**
 *  单例类
 */
#import <Foundation/Foundation.h>

@interface AppModel : NSObject

/**
 * 登陆以后返回的值(其他接口需要用到)
 */
@property(copy , nonatomic)NSString *uid;
@property(copy , nonatomic)NSString *sid;
/**
 * 第二页专题页跳转专题分类页传值
 */
@property(copy , nonatomic)NSString *article_cat_id;
/**
 * 专题跳转的时候把分类专题的名称传过去
 */
@property(copy , nonatomic)NSString *cat_name;
/**
 * webView  传值article_id
 */
@property(copy , nonatomic)NSString *article_id;
/**
 * 商品详情中要用到的商品id
 */
@property(copy , nonatomic)NSString *goods_id;
//用户的性别
@property(copy , nonatomic)NSString *sex;
/**
 *单品分类id
 */
@property(copy , nonatomic)NSString *idStringCalss;
/**
 * 判断是外链商品还是自营商品
 */
@property(copy , nonatomic)NSString *goods_remark;
/**
 * 外链商品详情页中的webView
 */
//@property(assign , nonatomic)CGFloat webViewHeight;

//新加地址单例传值部分
/**
 * 收货人名称
 */
@property(copy , nonatomic)NSString *addressName;
/**
 * 收货人电话
 */
@property(copy , nonatomic)NSString *addTel;
/**
 * 收货人邮箱
 */
@property(copy , nonatomic)NSString *addEmail;
/**
 * 收货人邮编
 */
@property(copy , nonatomic)NSString *addZipCode;
/**
 * 收货人所在地区
 */
@property(copy , nonatomic)NSString *addCity;
/**
 * 收货人详细地址
 */
@property(copy , nonatomic)NSString *address;
//收获人地址id
@property(copy , nonatomic)NSString *address_id;
/**
 * 购物车列表商品id
 */
@property(copy , nonatomic)NSString *red_id_delete;
/**
 * 搜索的关键字
 */
@property(copy , nonatomic)NSString *keywords;
/**
 * 选择地址请求数据时的参数id
 */
@property(copy , nonatomic)NSString *chooseId;

#pragma mark - 国家省份城市县区的id
@property(copy , nonatomic)NSString *countriesId;
@property(copy , nonatomic)NSString *provinId;
@property(copy , nonatomic)NSString *cityId;
@property(copy , nonatomic)NSString *countyId;




+ (instancetype)shareAppModel;
@end
