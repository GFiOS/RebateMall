//
//  FYRefreshTableView.h
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYRefreshHeadView.h"

#import "FYRefreshFootView.h"

@protocol FYRefreshViewDelegate;

@interface FYRefreshTableView : UITableView<UIScrollViewDelegate>
{
    UILabel *_msgLabel;
    BOOL _loading;
    BOOL _isFooterInAction;
    NSInteger _bottomRow;
}

@property(nonatomic,strong)FYRefreshHeadView *headerView;

@property(nonatomic,strong)FYRefreshFootView *footerView;

@property (assign,nonatomic) id <FYRefreshViewDelegate> pullingDelegate;

@property (nonatomic) BOOL autoScrollToNextPage;
/**
 * 加载完毕 没有更多数据
 */
@property (nonatomic) BOOL reachedTheEnd;
/**
 *
 */
@property (nonatomic,getter = isHeaderOnly) BOOL headerOnly;
/**
 * 网络超时
 */
@property(nonatomic,assign)BOOL netTimeOut;
/**
 * 网络没有链接
 */
@property(nonatomic,assign)BOOL netNotConnect;
/**
 * 是否可以刷新
 */
@property(nonatomic,assign)BOOL canRefresh;
/**
 * 是否可以加载
 */
@property(nonatomic,assign)BOOL canGetMore;

/**
 * 没有头视图
 */
@property(nonatomic,assign)BOOL isClearHead;

/**
 * 没有加载视图
 */
@property(nonatomic,assign)BOOL isClearFoot;

@property(nonatomic,assign)BOOL fitNavigationTransparent;

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<FYRefreshViewDelegate>)aPullingDelegate style:(UITableViewStyle)style;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidFinishedLoading;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

- (void)launchRefreshing;

/**
 *去掉头刷新View
 */
-(void)clearheaderView;

/**
 *去掉底部加载View
 */
-(void)clearFoorView;

/**
 * 手动 设置偏移量
 */
-(void)setContentInsetManual;

/**
 * 设置tableview的便宜量 如果ios7 没有自动设置
 */
-(void)setContentBottomEdgeOffset;

/**
 * 可以进行下拉加载
 */
-(void)canShowFootView;

@end


