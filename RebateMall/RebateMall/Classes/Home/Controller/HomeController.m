//
//  HomeController.m
//  RebateMall
//
//  Created by 安帅 on 15/12/11.
//  Copyright (c) 2015年 silence. All rights reserved.
//


#import "HomeController.h"
#import "UIBarButtonItem+ImageName.h"

// 头视图
#import "HomeHeaderView.h"

// 推荐商品
#import "GoodsCollectionView.h"
#import "GoodsCollectionCell.h"
#import "Tools.h"
#import "GoodsGroupModel.h"
#import "GoodsModel.h"

@interface HomeController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

// 搜索条
@property(strong , nonatomic)UITextField *searchClassTF;


@property(strong,nonatomic)UICollectionView  *collectionView;

@property(strong,nonatomic)NSArray  *goodsDataArray;

@end

@implementation HomeController
static NSString *cellName = @"GoodsCollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];

    [self initView];
}

- (void)initData{
    GoodsGroupModel *model = [[GoodsGroupModel alloc]init];
    self.goodsDataArray = model.goods;
}

- (void)initView{
    
    // 设置导航栏buttonItems数组
    [self setNavigationButtonItems];
    
    //  网络加载提示
    [self initTextFieldView];
    
    // 内容视图
//    GoodsCollectionView *goodsView = [[GoodsCollectionView alloc]init];
    
    // 创建LayOut
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置网格大小
    CGFloat margin = kXFrom5(8);
    CGFloat width =  kXFrom5(296*.5);//(kScreenW - 3*margin)/2;
    CGFloat height = width * (340/296); // 根据比例算出高度
    layout.itemSize = CGSizeMake(width,height);//kYFrom5(170.0)
    
    // 设置内间距   top, left, bottom, right;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    layout.minimumLineSpacing = margin;//纵向Cell最小间距
    layout.minimumInteritemSpacing = margin; //横向Cell最小间距
    
    // 设置头视图
    layout.headerReferenceSize = CGSizeMake(kScreenW, kYFrom5((266+180+274+308)/2));  //设置head大小
    
    CGRect frame = CGRectMake(0, 0, kScreenW, kScreenH - 64 - 49);
    self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [Tools colorWithHexString:kCollectionViewColorString];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:cellName];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    GoodsModel *model = self.goodsDataArray[indexPath.item];
    [cell bindDataWithModel:model];
    
    return cell;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


/**
 * 设置导航栏buttonItems数组
 */
- (void)setNavigationButtonItems{
    NSMutableArray *buttonItems = [NSMutableArray array];
    
    // 设置左侧按钮
    UIImageView *logoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_logo"]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logoView];
    
    // 日历
    [buttonItems addObject:[UIBarButtonItem barButtonItemWithImageName:@"date" target:self action:@selector(pushDateVC:)]];
    
    // 消息
    [buttonItems addObject:[UIBarButtonItem barButtonItemWithImageName:@"message" target:self action:@selector(pushMessageVC:)]];
    
    [self addRightNavigationButtonItems:buttonItems];
}



//视图控件
- (void)initTextFieldView
{
    self.searchClassTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kXFrom5(kScreenW - kXFrom5(70)), kXFrom5(16))];
    
    self.searchClassTF.backgroundColor = [UIColor whiteColor];
    self.searchClassTF.delegate = self;
    
    self.searchClassTF.font = [UIFont systemFontOfSize:kXFrom5(13.)];
    
    self.searchClassTF.layer.borderWidth =0.5f;
    self.searchClassTF.layer.cornerRadius = 5.0;
    self.searchClassTF.layer.borderColor = [kRGB(112., 197., 193.) CGColor];
    self.searchClassTF.textAlignment = NSTextAlignmentLeft;
    self.searchClassTF.placeholder = @"请输入商品类型";
    self.searchClassTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.navigationItem.titleView = self.searchClassTF;
}

- (void)pushDateVC:(UIButton *)button{
    NSLog(@"------------------日历");
}

- (void)pushMessageVC:(UIButton *)button{
    NSLog(@"------------------消息");
}


//收键盘方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    //放弃第一消息响应者
    [self.searchClassTF resignFirstResponder];
}

@end
