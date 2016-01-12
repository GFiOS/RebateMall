//
//  FYRefreshHeader.h
//  FYRefresh
//
//  Created by Medalands on 15/11/1.
//  Copyright © 2015年 medalands. All rights reserved.
//

#define kPROffsetY 60.f

#define kPRArrowWidth 20.f
#define kPRBGColor [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]
#define kTextColor [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0]

#define kPRLabelHeight 20.f
#define kPRMargin 5.f
#define kPRArrowHeight 40.f

#define kPRAnimationDuration .18f


typedef enum {
    kPRStateNormal = 0,
    kPRStatePulling = 1,
    kPRStateLoading = 2,
    kPRStateHitTheEnd = 3,
    kPRStateNetTimeOut=4,
    kPRStateNetNotConnect=5
} PRState;


@protocol FYRefreshViewDelegate <NSObject>

@required
- (void)FYRefreshViewDidStartRefreshing:(UIScrollView *)tableView;

@optional
//Implement this method if headerOnly is false
- (void)FYRefreshViewDidStartLoading:(UIScrollView *)tableView;
//Implement the follows to set date you want,Or Ignore them to use current date
- (NSDate *)FYRefreshViewRefreshingFinishedDate;
- (NSDate *)FYRefreshViewLoadingFinishedDate;

@end