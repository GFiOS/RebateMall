//
//  UMBaseViewController.h
//  UMLifeAesthetes
//
//  Created by umanto on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/**
 * 设置导航栏右侧ButtonItems数组
 */
- (void)addRightNavigationButtonItems:(NSArray *)buttonItems;

/**
 * 在导航栏右侧ButtonItem左边添加ButtonItem
 */
- (void)addButtonItemWithLeftOfDefaultItem:(id)item;

/**
 * 弹出框
 */
- (void)showAlertViewWithMessage:(NSString *)message;

/**
 * 加载框
 */
-(void)showLoadingViewWithMessage:(NSString*)message;

-(void)stopLoadingViewWithMessage:(NSString*)message;
/**
 * 错误信息报告
 */
-(void)showErrorInfo:(NSError *)error;

@end
