//
//  RootTabBarViewController.m
//  RebateMall
//
//  Created by 安帅 on 15/12/11.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "RootTabBarViewController.h"
// 首页home
#import "HomeController.h"
// 分类classification
#import "ClassificationController.h"
// 购物车shopping cart
#import "ShoppingCartController.h"
// 个人中心personal center
#import "PersonalCenterController.h"
#import "UIImage+Category.h"
#import "TabBarButton.h"

@interface RootTabBarViewController ()
@property(strong,nonatomic)NSArray  *images;
@property(strong,nonatomic)UIButton  *currentButton;
@end

@implementation RootTabBarViewController{
    NSMutableArray *_tabBarButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化模块
    self.images = @[@"home",@"fenlei",@"cart",@"center"];
    
    _tabBarButtons = [NSMutableArray array];
    
    /*--------------------使用反射方法，无需导入头文件---------------*/
//    NSArray *vcNameArray = @[@"HomeController",@"ClassificationController",@"ShoppingCartController",@"PersonalCenterController"];
//    
//    NSArray *vcTitleArray = @[@"首页",@"分类",@"购物车",@"个人中心"];
//    
//    for (int i = 0; i < vcNameArray.count; i++) {
//        UIViewController *vc = [self initInstanceWithClassName:vcNameArray[i]];
//        
//        vc.title = vcTitleArray[i];
//        
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
//        
//        //加入分栏控制器
//        [self addChildViewController:navigationController];
//    }
//    
//    [self loadTabBar];
    
    /*------------------------使用系统方法-----------------------*/
    HomeController *homeVC = [[HomeController alloc]init];
    [self addChildController:homeVC title:@"首页"];
    
    ClassificationController *classificationVC = [[ClassificationController alloc]init];
    [self addChildController:classificationVC title:@"分类"];
    
   ShoppingCartController *shoppingCartVC = [[ShoppingCartController alloc]init];
    [self addChildController:shoppingCartVC title:@"购物车"];
    
    PersonalCenterController *personalCenterVC = [[PersonalCenterController alloc]init];
    [self addChildController:personalCenterVC title:@"我的中心"];
    [self loadTabBar];
}

// 通过类名创建类
- (id)initInstanceWithClassName:(NSString *)className{
    // 将控制器类的名字字符串转化成类型
    Class class = NSClassFromString(className);
    // 通过类型创建对象
    return [[class alloc]init];
}

/**
 *  分栏控制器
 *  @param viewController    子视图控制器
 *  @param title             标题
 */
- (void)addChildController:(UIViewController *)viewController title:(NSString *)title
{
    viewController.navigationItem.title = title;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    [self addChildViewController:navigationController];
}


/**
 *  自定义tabBar
 *
 *  @param viewController    子视图控制器
 *  @param imagePath         图片地址
 *  @param tabBarName        分栏中视图的名称
 *  @param selectedImagePath 选中以后的图片
 */
- (void)loadTabBar{
    
    NSInteger childControllerNum = self.viewControllers.count;
    CGRect frame = self.tabBar.frame;
    // 减去1像素的分割线的宽度
    CGFloat segmentaionLineW = childControllerNum - 1;
    CGFloat width = (kScreenW - segmentaionLineW)/childControllerNum;
    CGFloat height = frame.size.height;
    
    UIView *view = [[UIView alloc]init];
    view.frame = frame;
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    for (NSInteger i = 0 ; i < childControllerNum ; i++) {
        
        /**
         * 添加按钮
         */
        TabBarButton *button = [[TabBarButton alloc]init];
        CGFloat x = i*width + i;// 加上分割线的宽度
        button.frame = CGRectMake(x, 0, width, height);
        
        UIImage *imageNormal = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",self.images[i]]];
        UIImage *imageSelect = [UIImage imageNamed:[NSString stringWithFormat:@"%@_select",self.images[i]]];
        
        [button setImage:imageNormal forState:UIControlStateNormal];
        [button setImage:imageSelect forState:UIControlStateSelected];
        
        // 默认选中第一个
        if(i == 0) button.selected = YES;
        button.tag = i;
        [button addTarget:self action:@selector(changeSelected:) forControlEvents:UIControlEventTouchDown];
        [_tabBarButtons addObject:button];
        [view addSubview:button];
        
        /**
         * 添加华丽的分割线
         * 分割线的个数比分栏条目的总数少一个
         */
        if(i == (childControllerNum - 1))continue; // 最后一个不需要添加分割线
        x = width*i + (width + i);
        UIImageView *segmentionLineView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, 1,height)];
        segmentionLineView.image = [UIImage imageNamed:@"segmention_line"]; 
        [view addSubview:segmentionLineView];
    }
}

- (void)changeSelected:(UIButton *)button{
    UIButton *firstBtn = _tabBarButtons[0];
    if (firstBtn.selected) {
        firstBtn.selected = NO;
    }
    
    button.selected = YES;
    self.currentButton.selected = NO;
    self.currentButton = button;
    self.selectedIndex = button.tag;
}

@end
