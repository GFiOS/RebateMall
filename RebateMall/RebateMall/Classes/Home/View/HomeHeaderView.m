//
//  HomeHeaderView.m
//  RebateMall
//
//  Created by 安帅 on 15/12/16.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "HomeHeaderView.h"
// 轮播图cell（暂时不用）
#import "HomePageScrollViewCell.h"
#import "HomePageScrollViewModel.h"

// 秒杀专场
#import "HomeZhuanChangTableCell.h"
// 主题街
#import "HomeZhuTiTableCell.h"
// 商品
#import "GoodsCollectionCell.h"

// 分段头视图
#import "HomeSectionHeaderView.h"

// 轮播视图
#import "HomePageScrollView.h"


@interface HomeHeaderView()
// 轮播视图数据
@property(strong,nonatomic)NSMutableArray  *pageScrollDataArr;
@end

@implementation HomeHeaderView{
    NSArray *_sectionHeaderDataArray; // 分段头数据
}


// 手写代码时，会调用
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// xib时，会调用
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

// 进行初始化设置（一般设置控件）
- (void)setup{
    
    [self initData];
    
//    self.baseTableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - 64.0 - 49.0);
    
    //禁止上拉加载数据
    self.baseTableView.reachedTheEnd = YES;
    
    __weak typeof(self)weakS = self;
    
    [self setRequestDataBlock:^{
        
        [weakS creatRequest];
    }];
    
    // 头视图
    HomePageScrollView *pageScrollView = [[HomePageScrollView alloc] initWithFrame:CGRectMake(0,  0, kScreenW, kYFrom5(133))];
    
    [pageScrollView bindDataArray:self.pageScrollDataArr];
    
    self.baseTableView.tableHeaderView = pageScrollView;
}


- (void)initData{
    
    /**
     * 轮播图数据
     */
    NSArray *pageScrollArr = @[@"_0000",@"_0001",@"_0002",@"_0003"];
    
    self.pageScrollDataArr = [NSMutableArray array];
    for (NSInteger i = 0;i < pageScrollArr.count; i++) {
        HomePageScrollViewModel *model = [[HomePageScrollViewModel alloc]init];
        model.url = pageScrollArr[i];
        [self.pageScrollDataArr addObject:model];
    }
    
    /**
     * 分段头数据
     */
    _sectionHeaderDataArray = @[
                                @[@"miaosha",@"秒杀专场"],
                                @[@"zhuti",@"主题街"],
                                @"--------- 返利为您推荐 ---------",
                                ];
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kYFrom5(30);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth = 0.0;
    switch (indexPath.section) {
        case 0:
            heigth = kYFrom5(137.0);// 274/2
            break;
            
        case 1:
            heigth = kYFrom5(154.0);// 308/2
            break;
            
        default:
            heigth = kYFrom5(170.0);// 340/2
            break;
    }
    
    return heigth;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeSectionHeaderView *view = [[HomeSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kYFrom5(30))];
    
    [view bindDataWithModel:_sectionHeaderDataArray[section]];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;  // 1秒杀专场， 2主题街，3，推荐
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 秒杀专场
    if(indexPath.section == 0){
        static NSString *cellZhuanChangIdentifier = @"HomeZhuanChangTableCell";
        
        HomeZhuanChangTableCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellZhuanChangIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeZhuanChangTableCell" owner:self options:nil]lastObject];
        }
        //取消选中的效果
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        return cell;
    }
    
    // 主题街
    //     if(indexPath.section == 1){
    static NSString *cellZhuTiIdentifier = @"HomeZhuTiTableCell";
    HomeZhuTiTableCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellZhuTiIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeZhuTiTableCell" owner:self options:nil] lastObject];
    }
    //取消选中的效果
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 请求数据
 */
- (void)creatRequest
{
    self.requestSuccessBlock(nil);
    
    //    //接口
    //    NSString *headerUrl = [NSString stringWithFormat:UMData_url,Home_Rolling];
    //
    //    [MDAFHelp POST:headerUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        NSDictionary *dict = responseObject;
    //        [self headerJiexi:dict];
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        self.requestFailBlock();
    //        //显示接口错误
    //        [self showErrorInfo:error];
    //    }];
    //
    //    //商品接口
    //    NSString *cellUrl = [NSString stringWithFormat:UMData_url,Home_content];
    //
    //    [MDAFHelp POST:cellUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSDictionary *dict = responseObject;
    //        [self cellJiexi:dict];
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        self.requestFailBlock();
    //        //显示接口错误
    //        [self showErrorInfo:error];
    //    }];
}

/**
 * 解析数据
 */
-(void)headerJiexi:(NSDictionary *)dictionary
{
    //    self.dataArray = [NSMutableArray array];
    //
    //    NSDictionary *dic = [dictionary objectForKey:@"data"];
    
    //    NSArray *array = [dic objectForKey:@"player"];
    //    for (NSDictionary *subDic in array)
    //    {
    //        UMHomePageScrollViewModel *model = [[UMHomePageScrollViewModel alloc] init];
    //        NSString *url = [[subDic objectForKey:@"photo"] objectForKey:@"url"];
    //
    //        model.url = url;
    //
    //        [self.dataArray addObject:model];
    //    }
}

//列表请求数据
- (void)cellJiexi:(NSDictionary *)dictionary
{
    //保存数据
    //    NSMutableArray *listArray = [NSMutableArray array];
    //
    //    NSArray *array = [dictionary objectForKey:@"data"];
    //
    //    for (NSDictionary *subDic in array)
    //    {
    //        UMHomePageModel *model = [[UMHomePageModel alloc]initWithDictionay:subDic];
    //        NSString *url = [NSString stringWithFormat:Image_url,model.file_url];
    //        
    //        model.cat_file_url = url;
    //        
    //        [listArray addObject:model];
    //    }
    //    self.requestSuccessBlock(listArray);
}
@end
