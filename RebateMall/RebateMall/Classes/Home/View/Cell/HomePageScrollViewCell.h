//
//  HomePageScrollViewCell.h
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoSlideScrollView.h"

@interface HomePageScrollViewCell : UITableViewCell

// 头部滚动视图
@property(strong,nonatomic)AutoSlideScrollView  *mainScorllView;

- (void)bindDataArray:(NSArray *)array;
@end
