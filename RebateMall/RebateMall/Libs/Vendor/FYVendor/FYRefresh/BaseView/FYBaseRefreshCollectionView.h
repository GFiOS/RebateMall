//
//  FYBaseRefreshCollectionView.h
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYRefreshCollectionView.h"

#import "FYBaseView.h"

@interface FYBaseRefreshCollectionView : FYBaseView<FYRefreshViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionViewLayout *collectionViewLayout;

/**
 *请求数据的Block
 */
@property(nonatomic,copy)void(^requestDataBlock)();

/**
 * 请求成功
 */
@property(nonatomic,copy)void(^requestSuccessBlock)(NSMutableArray *);
/**
 * 请求失败
 */
@property(nonatomic,copy)void(^requestFailBlock)();

/**
 *  上拉刷新 下拉加载的 UITableView
 */
@property(nonatomic,retain)FYRefreshCollectionView * baseTableView;

/**
 * 列表的数据源
 */
@property(nonatomic,retain)NSMutableArray * baseDataArray;

/**
 * 加载页数
 */
@property(nonatomic,assign)NSInteger dataPage;


/**
 *  每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 时，上拉加载 功能不可用（此时说明已经没有更多数据了）
 
 两种处理方式： 1.禁止上拉功能 ，并隐藏上拉加载动画   [self.baseTableView clearFoorView];
 并且有足够数据时 显示此功能   [self.baseTableView canShowFootView];
 2.禁止上拉功能， 上拉提示语 改成 美誉更多信息  self.baseTableView.reachedTheEnd = YES;
 
 2.每页个数  当新请求页数的数据个数少于 每页个数 或者为 0 ，
 
 */

@property(nonatomic,assign)NSUInteger  numberOfEachPage;


/**
 * YES 刷新  ，NO 加载,用于请求结果的判断
 */
@property(nonatomic,assign) BOOL isReFreshing;

/**
 *首页 的 page值 默认为 1
 */
@property(nonatomic,assign)NSUInteger firstPage;

/**
 * 两次刷新 允许的时间差 小于 则不自动刷新 大于 则自动刷新 默认 20分钟
 */

@property(nonatomic,assign)CFAbsoluteTime betweenRefreshTimes;



/**
 * 请求数据
 */
-(void)requestData;

/**
 *  开始请求
 */
-(void)startRequest;

/**
 * 刷新数据为第一页
 */
-(void)refreshTableListData;

/**
 *  请求失败处理
 */
-(void)failRequest:(NSError *)error;

/**
 * 刷新  条件是 两次刷新之间的事件差
 */
-(void)refreshTableListDataIfNeed;

-(void)refreshTableListDataNoPull;


@end
