//
//  UMBaseViewController.m
//  UMLifeAesthetes
//
//  Created by umanto on 15/10/31.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"

#import "MBProgressHUD.h"
#import "UIBarButtonItem+ImageName.h"


@interface BaseViewController ()

@property(nonatomic,strong)MBProgressHUD *proHUD;

@end

@implementation BaseViewController{
    NSMutableArray *_rightButtonItems; // 右侧NavigationItems
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //去掉自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.backgroundColor = kRGB(229., 229., 229.);
    
    // 暂时用上面的，等给“日历”，“更多”图标之后在，使用下面的代码
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏左侧ButtonItem（默认是返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"nav_back" target:self action:@selector(popBackAction:)];

    // 初始化右侧buttonItems
    _rightButtonItems = [NSMutableArray array];
    // 设置导航右侧默认按钮及点击事件
    [_rightButtonItems addObject:[UIBarButtonItem barButtonItemWithImageName:@"more" target:self action:@selector(moreAction:)]];

    self.navigationItem.rightBarButtonItems = _rightButtonItems;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 * 在导航栏右侧ButtonItem左边添加ButtonItem
 */
- (void)addButtonItemWithLeftOfDefaultItem:(id)item{
    
    [_rightButtonItems addObject:item];

    self.navigationItem.rightBarButtonItems = _rightButtonItems;
}

/**
 * 设置导航栏上右items数组
 */
- (void)addRightNavigationButtonItems:(NSArray *)buttonItems
{
    self.navigationItem.rightBarButtonItems = buttonItems;
}

#pragma mark - 导航栏按钮点击事件
//返回按钮点击事件
-(void)popBackAction:(UIButton *)button
{
    NSLog(@"返回上一页面");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moreAction:(UIButton *)button{
    NSLog(@"加载更多！！");
}

#pragma mark 加载框

-(void)showLoadingViewWithMessage:(NSString*)message
{
    if (message) {
        self.proHUD.labelText = message;
    }
    [self.proHUD show:YES];
}

-(void)stopLoadingViewWithMessage:(NSString*)message
{
    if (_proHUD == nil)
    {
        return;
    }
    if (message.length) {
        self.proHUD.labelText = message;
        [self.proHUD hide:YES afterDelay:.5];
    }else
    {
        [self.proHUD hide:YES];
    }
}

-(MBProgressHUD *)proHUD
{
    if (_proHUD == nil)
    {
        _proHUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_proHUD];
    }
    [self.view bringSubviewToFront:_proHUD];
    return _proHUD;
}


//各种错误信息提示
-(void)showErrorInfo:(NSError *)error
{
    //错误提示语
    NSString *errorString = nil;
    
    if (error.code == -1009)
    {
        errorString = @"网络断开连接";
    }
    else if (error.code == -1003 || error.code == -1004)
    {
        errorString = @"服务器异常";
    }
    else if (error.code == -1001)
    {
        errorString = @"请求超时,请检查网络后重试!";
    }
    else if (error.code == 3848)
    {
        errorString = @"转换JOSN格式错误";
    }
    else if (error.code == -1016)
    {
        //不需要提示给用户，调试接口时应该解决掉这个问题
        errorString = @"网络不给力";
    }
    else
    {
        errorString = @"网络不给力";
    }
    [self showAlertViewWithMessage:errorString];
}

/**
 * 弹框方法
 */
- (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

@end
