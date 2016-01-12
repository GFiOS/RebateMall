//
//  FYRefreshTableView.m
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#import "FYRefreshTableView.h"

#import <QuartzCore/QuartzCore.h>
#import "Reachability.h"

#define NoLoadingCondition ((_footerView.state != kPRStateHitTheEnd)&&(_footerView.state!=kPRStateNetTimeOut)&&(_footerView.state!=kPRStateNetNotConnect))

@interface FYRefreshTableView ()

/**
 *  适应ios7的透明导航栏
 */
@property(nonatomic,assign)CGFloat fitNavTranOffset;

/**
 * 底部偏移空白 默认0
 */
@property(nonatomic,assign)CGFloat bottomTableOffset;


- (void)scrollToNextPage;
@end

@implementation FYRefreshTableView

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
    //    [_headerView release];
    //    [_footerView release];
    //    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        
        self.canRefresh=YES;
        self.canGetMore=YES;
        self.isClearHead=NO;
        self.isClearFoot=NO;
        
        _fitNavTranOffset = kPROffsetY;
        CGRect rect = CGRectMake(0, 0 - frame.size.height, frame.size.width, frame.size.height);
        
        
        _headerView = [[FYRefreshHeadView alloc] initWithFrame:rect atTop:YES];
        
        [self addSubview:_headerView];
        
        rect = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
        
        _footerView = [[ FYRefreshFootView alloc] initWithFrame:rect atTop:NO];
        
        [self addSubview:_footerView];
        
        _bottomTableOffset = 0.;
        
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<FYRefreshViewDelegate>)aPullingDelegate style:(UITableViewStyle)style {
    self = [self initWithFrame:frame style:style];
    if (self) {
        self.pullingDelegate = aPullingDelegate;
        
        [self hideFootAndHeadView];
    }
    return self;
}

- (void)setReachedTheEnd:(BOOL)reachedTheEnd{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd){
        _footerView.state = kPRStateHitTheEnd;
    } else {
        _footerView.state = kPRStateNormal;
    }
}

//网络超时
-(void)setNetTimeOut:(BOOL)netTimeOut
{
    _netTimeOut=netTimeOut;
    if (_netTimeOut) {
        _footerView.state = kPRStateNetTimeOut;
    }else
    {
        _footerView.state = kPRStateNormal;
    }
}
//网络没有连接
-(void)setNetNotConnect:(BOOL)netNotConnect
{
    _netNotConnect=netNotConnect;
    if (_netNotConnect) {
        
        _footerView.state = kPRStateNetNotConnect;
        
    }else{
        
        _footerView.state = kPRStateNormal;
        
    }
    
}

- (void)setHeaderOnly:(BOOL)headerOnly{
    _headerOnly = headerOnly;
    _footerView.hidden = _headerOnly;
}


#pragma mark - Scroll methods

- (void)scrollToNextPage {
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;
    
    //    [UIView animateWithDuration:.4 animations:^{
    //        self.contentOffset = CGPointMake(0, y);
    //    }];
    //    NSIndexPath *ip = [NSIndexPath indexPathForRow:_bottomRow inSection:0];
    //    [self scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //
    [UIView animateWithDuration:.7f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.contentOffset = CGPointMake(0, y);
                     }
                     completion:^(BOOL bl){
                     }];
}

- (void)tableViewDidScroll:(UIScrollView *)scrollView {
    
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    
    
    [self checkNetToChangeState];
    
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
    
    float yMargin = offset.y + size.height - contentSize.height;
    
    if (offset.y < -_fitNavTranOffset) {   //header totally appeard
        [self showHeadView];
        
        _headerView.state = kPRStatePulling;
        // -124                               -64
    } else if (offset.y > -_fitNavTranOffset && offset.y < -(_fitNavTranOffset - kPROffsetY)){ //header part appeared
        _headerView.state = kPRStateNormal;
        [self showHeadView];
        
    } else if ( yMargin > kPROffsetY + _bottomTableOffset){  //footer totally appeared
        
        //        NSLog(@" === %f",yMargin);
        
        
        if (NoLoadingCondition) {
            _footerView.state = kPRStatePulling;
            
        }
        [self showFootView];
    } else if ( yMargin <= kPROffsetY + _bottomTableOffset && yMargin > 0) {//footer part appeared
        if (NoLoadingCondition) {
            _footerView.state = kPRStateNormal;
        }
        [self showFootView];
    }
    if (offset.y == -(_fitNavTranOffset - kPROffsetY) || offset.y == self.contentSize.height - self.frame.size.height + _bottomTableOffset)
    {
        [self hideFootAndHeadView];
    }
    
    if (offset.y > -(_fitNavTranOffset - kPROffsetY) && _headerView.state != kPRStatePulling)
    {
        [self hideHeadView];
    }else if(offset.y < -(_fitNavTranOffset - kPROffsetY))
    {
        [self showHeadView];
    }
    
}

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView {
    
    
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading) {
        return;
    }
    
    
    if (_headerView.state == kPRStatePulling&&self.canRefresh) {
        //    if (offset.y < -_fitNavTranOffset) {
        _isFooterInAction = NO;
        _headerView.state = kPRStateLoading;
        
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset, 0, _bottomTableOffset, 0);
        } completion:^(BOOL finished) {
            
        }];
        
        
        
        
        //        [UIView animateWithDuration:.38 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset, 0, _bottomTableOffset, 0);
        //        } completion:^(BOOL finished) {
        //
        //        }];
        
        
        //        [UIView animateWithDuration:kPRAnimationDuration animations:^{
        //
        //            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset, 0, _bottomTableOffset, 0);
        //
        //
        //
        //        }];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(FYRefreshViewDidStartRefreshing:)]) {
            [_pullingDelegate FYRefreshViewDidStartRefreshing:self];
        }
    } else if (_footerView.state == kPRStatePulling&&self.canGetMore) {
        //    } else  if (offset.y + size.height - contentSize.height > _fitNavTranOffset){
        if (self.reachedTheEnd || self.headerOnly) {
            return;
        }
        _isFooterInAction = YES;
        _footerView.state = kPRStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset - kPROffsetY, 0, kPROffsetY + _bottomTableOffset, 0);
        }];
        
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(FYRefreshViewDidStartLoading:)]) {
            [_pullingDelegate FYRefreshViewDidStartLoading:self];
        }
    }
}

- (void)tableViewDidFinishedLoading {
    double delayInSeconds = self.footerView.loading ? 0.3 : 0.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self tableViewDidFinishedLoadingWithMessage:nil];
    });
}

- (void)flashMessage:(NSString *)msg{
    //Show message
    __block CGRect rect = CGRectMake(0, self.contentOffset.y - 20, self.bounds.size.width, 20);
    
    if (_msgLabel == nil) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.frame = rect;
        _msgLabel.font = [UIFont systemFontOfSize:14.f];
        _msgLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //_msgLabel.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        _msgLabel.backgroundColor = [UIColor whiteColor];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_msgLabel];
    }
    _msgLabel.text = msg;
    
    rect.origin.y += 20;
    [UIView animateWithDuration:.4f animations:^{
        _msgLabel.frame = rect;
    } completion:^(BOOL finished){
        rect.origin.y -= 20;
        [UIView animateWithDuration:.4f delay:1.2f options:UIViewAnimationOptionCurveLinear animations:^{
            _msgLabel.frame = rect;
        } completion:^(BOOL finished){
            [_msgLabel removeFromSuperview];
            _msgLabel = nil;
        }];
    }];
}

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg{
    
    if (!self.isClearFoot) {
        self.canGetMore=YES;
    }
    
    if (!self.isClearHead) {
        self.canRefresh=YES;
    }
    
    //    if (_headerView.state == kPRStateLoading) {
    if (_headerView.loading) {
        _headerView.loading = NO;
        [_headerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(FYRefreshViewRefreshingFinishedDate)]) {
            date = [_pullingDelegate FYRefreshViewRefreshingFinishedDate];
        }
        [_headerView updateRefreshDate:date];
        [UIView animateWithDuration:kPRAnimationDuration*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset - kPROffsetY, 0, _bottomTableOffset, 0);
        } completion:^(BOOL bl){
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
            [self hideFootAndHeadView];
            
            
        }];
    }
    //    if (_footerView.state == kPRStateLoading) {
    else if (_footerView.loading) {
        _footerView.loading = NO;
        [_footerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if (_pullingDelegate && [_pullingDelegate respondsToSelector:@selector(FYRefreshViewLoadingFinishedDate)]) {
            date = [_pullingDelegate FYRefreshViewLoadingFinishedDate];
        }
        [_footerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^{
            self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset - kPROffsetY, 0, _bottomTableOffset, 0);
            [self hideFootAndHeadView];
        } completion:^(BOOL finished){
            
            if (msg != nil && ![msg isEqualToString:@""]) {
                [self flashMessage:msg];
            }
            
        }];
    }else
    {
        [UIView animateWithDuration:kPRAnimationDuration*2 animations:^{
            [self hideFootAndHeadView];
        }];
    }
    
    
}

- (void)launchRefreshing {
    
    //    [self setContentOffset:CGPointMake(0,- 60) animated:NO];
    [self showHeadView];
    
    
    //    NSLog(@"========%f",-_fitNavTranOffset-1);
    
    
    //    [self setContentOffset:CGPointMake(0, -_fitNavTranOffset-1) animated:YES];
    
    [UIView animateWithDuration:kPRAnimationDuration animations:^{
        
        
        self.contentOffset = CGPointMake(0, -_fitNavTranOffset-1);
    } completion:^(BOOL bl){
        
        [self tableViewDidEndDragging:self];
    }];
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    CGRect frame = _footerView.frame;
    CGSize contentSize = self.contentSize;
    frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height -(_fitNavTranOffset - kPROffsetY) : contentSize.height;
    _footerView.frame = frame;
    if (self.autoScrollToNextPage && _isFooterInAction) {
        [self scrollToNextPage];
        _isFooterInAction = NO;
    } else if (_isFooterInAction) {
        CGPoint offset = self.contentOffset;
        offset.y += 0.f;
        self.contentOffset = offset;
    }
}


-(void)clearheaderView{
    
    _headerView.frame=CGRectZero;
    
    _headerView.hidden=YES;
    
    self.isClearHead=YES;
    
    self.canRefresh=NO;
}

-(void)clearFoorView{
    
    //    _footerView.frame = CGRectZero;
    
    _footerView.hidden = YES;
    
    self.canGetMore = NO;
    
    self.isClearFoot = YES;
}
-(void)canShowFootView
{
    //    _footerView.frame = CGRectZero;
    
    _footerView.hidden = NO;
    
    self.canGetMore = YES;
    
    self.isClearFoot = NO;
}

-(void)setFitNavigationTransparent:(BOOL)fitNavigationTransparent
{
    if (fitNavigationTransparent) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            
            _fitNavTranOffset = 64.0 + kPROffsetY;
        }
    }
    _fitNavigationTransparent = fitNavigationTransparent;
}

-(void)hideFootAndHeadView
{
    _footerView.hidden = YES;
    
    _headerView.hidden = YES;
}

-(void)hideHeadView
{
    _headerView.hidden = YES;
}

-(void)hideFootView
{
    _footerView.hidden = YES;
    
}


-(void)showFootAndHeadView
{
    [self showHeadView];
    
    [self showFootView];
}


-(void)showFootView
{
    if (!_isClearFoot )
    {
        _footerView.hidden = NO;
    }
}

-(void)showHeadView
{
    if (!_isClearHead )
    {
        _headerView.hidden = NO;
    }
}

-(void)checkNetToChangeState
{
    
    
    if ((_footerView.state!=kPRStateNetTimeOut)&&(_footerView.state!=kPRStateNetNotConnect)) {
        
        return;
        
    }
    
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]==NotReachable &&[[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]==NotReachable){
        
        return;
        
    }else
    {
        if (((_footerView.state==kPRStateNetTimeOut)||(_footerView.state==kPRStateNetNotConnect))) {
            _footerView.state = kPRStateNormal;
        }
        
        
        if (_footerView.state ==kPRStateNetTimeOut) {
            
            NSLog(@"超时");
        }
        
        if (_footerView.state ==kPRStateNetNotConnect) {
            
            NSLog(@"没有链接");
        }
    }
}


// 设置tableview的便宜量 如果ios7 没有自动设置
-(void)setContentInsetManual
{
    self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset - kPROffsetY, 0, _bottomTableOffset, 0);
    
}

// 设置tableview的底部便宜量
-(void)setContentBottomEdgeOffset
{
    _bottomTableOffset = 100;
    
    self.contentInset = UIEdgeInsetsMake(_fitNavTranOffset - kPROffsetY, 0, _bottomTableOffset, 0);
    
}




@end
