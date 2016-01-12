//
//  FYBaseRefreshCollectionView.m
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#import "FYBaseRefreshCollectionView.h"



@interface FYBaseRefreshCollectionView ()

/**
 * YES 刷新  ，NO 加载  用于请求数据方法的判断
 */
@property(nonatomic,assign) BOOL refreshing;

/**
 * 上一次 请求的 页数
 */
@property(nonatomic,assign)NSUInteger lastRequestPage;

/**
 * 上次刷新的时间
 */
@property(nonatomic,assign)CFAbsoluteTime lastRefreshTime;//

/**
 * 当前时间
 */
@property(nonatomic,assign)CFAbsoluteTime currentTime;



@end

@implementation FYBaseRefreshCollectionView

-(void)dealloc
{
    self.baseDataArray = nil;
    
    self.baseTableView.delegate = nil;
    
    self.baseTableView.delegate = nil;
    
    self.baseTableView = nil;
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initData_FY];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initData_FY];
}






-(void)initData_FY
{
    _lastRefreshTime = 0;// 只有在刷新成功后才进行赋值
    
    _currentTime = CFAbsoluteTimeGetCurrent();
    
    _baseDataArray = [[NSMutableArray alloc] init];
    
    _firstPage =  1;
    
    _betweenRefreshTimes = 20 * 60;
    
    
    __weak typeof(self)weakS = self;
    
    [self setRequestFailBlock:^{
        weakS.dataPage = weakS.lastRequestPage;
        [weakS.baseTableView tableViewDidFinishedLoading];
    }];
    
    [self setRequestSuccessBlock:^(NSMutableArray * array) {
        
        if (weakS.isReFreshing)
        {
            weakS.lastRefreshTime = CFAbsoluteTimeGetCurrent(); //更新刷新时间
            
            weakS.baseDataArray = array;
            
            if (array.count == 0)
            {
                [weakS.baseTableView clearFoorView];
            }else
            {
                [weakS.baseTableView canShowFootView];
            }
            //              [weakS.baseTableView tableViewDidFinishedLoading];
        }else
        {
            if (array.count >0 )
            {
                [weakS.baseDataArray addObjectsFromArray:array];
            }
            
            if (array.count < _numberOfEachPage || array.count == 0)
            {
                //没有更多数据
                weakS.baseTableView.reachedTheEnd = YES;
            }
        }
        
        [weakS.baseTableView reloadData];
        
        [weakS.baseTableView tableViewDidFinishedLoading];
        [weakS stopLoadingViewWithMessage:nil];
    }];
    
}


-(void)initSubViews_FY
{
    _baseTableView = [[FYRefreshCollectionView alloc] initWithFrame:self.bounds pullingDelegate:self collectionViewLayout:_collectionViewLayout];
    
    _baseTableView.alwaysBounceVertical = YES;
    
    _baseTableView.backgroundColor = [UIColor clearColor];
    
    //    _baseTableView ->_footerView.emptyDataText = @"没有找到符合条件的酒店！";
    
    if ([_baseTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        //        _baseTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    _baseTableView.backgroundColor = [UIColor whiteColor];
    
    _baseTableView.delegate = self;
    
    _baseTableView.dataSource = self;
    
    
    //    _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉横线
    
    [_baseTableView clearFoorView];// 初始化 不允许加载
    
    [self addSubview: _baseTableView];
    
}

-(void)startRequest
{
    [self refreshTableListData];
}

-(void)refreshTableListData
{
    self.refreshing = YES;
    
    [_baseTableView launchRefreshing];
}

//-(void)refreshTableListDataIfNeed
//{
//    _currentTime = CFAbsoluteTimeGetCurrent();
//    
//    if (_currentTime - _lastRefreshTime  > _betweenRefreshTimes)
//    {
//        [self refreshTableListData];
//    }
//}
-(void)refreshTableListDataIfNeed
{
    
    if (self.baseDataArray.count == 0)
    {
        [self refreshTableListData];
    }
}

-(void)requestData
{
    //    self.requestDataArray = [[NSMutableArray alloc]init];
    
    _lastRequestPage = _dataPage;
    
    if (self.refreshing)
    {
        _dataPage = _firstPage;
    }
    else
    {
        _dataPage++;
    }
    
    if (_requestDataBlock)
    {
        _requestDataBlock();
    }
}


#pragma mark UICollectionView 代理方法
#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _baseDataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
//    {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}


#pragma mark - UICollectionView DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}


#pragma mark 刷新 加载 代理方法
#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_baseTableView])
    {
        [_baseTableView tableViewDidScroll:scrollView];
    }
}
// 停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([scrollView isEqual:_baseTableView]) {
        
        [_baseTableView tableViewDidEndDragging:scrollView];
    }
}

//刷新
- (void)FYRefreshViewDidStartRefreshing:(UIScrollView *)tableView{
    if (_baseTableView.canRefresh)
    {
        
        //    _lastRefreshTime = CFAbsoluteTimeGetCurrent();//上次刷新的时间
        
        self.refreshing = YES;
        
        _baseTableView.canRefresh = NO;
        
        __weak typeof(self)weakS = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakS requestData];
        });
    }
    
}
//加载
- (void)FYRefreshViewDidStartLoading:(UIScrollView *)tableView{
    
    if (_baseTableView.canGetMore) {
        
        self.refreshing = NO;
        
        self.isReFreshing = NO;
        
        _baseTableView.canGetMore=NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            __weak typeof(self)weakS = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakS requestData];
            });
            
            
        });
    }
}
// 日期
- (NSDate *)FYRefreshViewRefreshingFinishedDate{
    
    return [NSDate date];
    
}
//   ing 失败掉的 方法
-(void)failRequest:(NSError *) error{
    
    if (self.dataPage > _firstPage) // 加载 下一页失败 页数 -1
    {
        self.dataPage --;
    }
    
    [_baseTableView tableViewDidFinishedLoading];
    
    [self.baseTableView reloadData];
    
    //    kCFURLErrorCannotFindHost = -1003, // 找不到服务器
    //    kCFURLErrorCannotConnectToHost = -1004, // 链接不上服务器
    //   kCFURLErrorNotConnectedToInternet = -1009 // 网络断开
    //kCFURLErrorCancelled = -999 取消下载  （operation cancel）
    
    //    if(error.code == -1009)
    //    {
    //        // 网络断开链接
    //    }else if (error.code == -1003 || error.code == - 1004)
    //    {
    //        // 服务器异常
    //    }else if (error.code == -1001)
    //    {
    //        // 网络超时
    //    }else if (error.code == 3848)// 这种情况 是在 开发时 用的 上线时 这种情况不用处理 可以归为网络异常 或别的 上线之后 出现情况 找写接口的那口子  让他改
    //    {
    //        // 转换json 格式错误
    //    }else
    //    {
    //        //
    //        NSLog(@" 未处理 %ld error.code",(long)error.code);
    //    }
    //
    //    // 实际开发 时可能处理的情况 都是几种合在一起的 比如网易新闻  请求失败 都是 网络不给力 一种处理方式
    
}

-(void)setRefreshing:(BOOL)refreshing
{
    
    if (refreshing) {
        self.isReFreshing = YES;
    }
    _refreshing = refreshing;
}

-(void)setCollectionViewLayout:(UICollectionViewLayout *)collectionViewLayout
{
    if (collectionViewLayout)
    {
        _collectionViewLayout = collectionViewLayout;
        
        [self initSubViews_FY];
    }
}

-(void)refreshTableListDataNoPull
{
    self.isReFreshing = YES;
    [self showLoadingViewWithMessage:@"加载中"];
    [self requestData];
}

@end
