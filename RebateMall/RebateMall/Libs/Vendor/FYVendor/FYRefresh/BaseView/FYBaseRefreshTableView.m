//
//  FYBaseRefreshTableView.m
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#import "FYBaseRefreshTableView.h"

@interface FYBaseRefreshTableView ()

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

@implementation FYBaseRefreshTableView

-(void)dealloc
{
    self.baseDataArray = nil;
    
    self.baseTableView.delegate = nil;
    
    self.baseTableView.delegate = nil;
    
    self.baseTableView = nil;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _lastRefreshTime = 0;// 只有在刷新成功后才进行赋值
        
        _currentTime = CFAbsoluteTimeGetCurrent();
        
        _baseDataArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor clearColor];
        
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
        
        [self initSubViews_FY];
        
    }
    return self;
}
-(void)initSubViews_FY
{
    _baseTableView = [[FYRefreshTableView alloc] initWithFrame:self.bounds pullingDelegate:self style:UITableViewStylePlain];
    
    _baseTableView.backgroundColor = [UIColor clearColor];
    
    //    _baseTableView ->_footerView.emptyDataText = @"没有找到符合条件的酒店！";
    
    if ([_baseTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        _baseTableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([_baseTableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        _baseTableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    
    _baseTableView.delegate = self;
    
    _baseTableView.dataSource = self;
    
    _baseTableView.tableFooterView = [[UIView alloc] init];
    
    //    _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉横线
    
    [_baseTableView clearFoorView];// 初始化 不允许加载
    
    [self addSubview: _baseTableView];
    
}

#pragma mark 数据请求相关


-(void)startRequest
{
    [self refreshTableListData];
}

-(void)refreshTableListData
{
    self.refreshing = YES;
    
    [_baseTableView launchRefreshing];
}

-(void)refreshTableListDataNoPull
{
    self.isReFreshing = YES;
    [self showLoadingViewWithMessage:@"加载中"];
    [self requestData];
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


#pragma mark tableView 代理方法
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _baseDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    
    
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
