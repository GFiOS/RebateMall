//
//  HomePageScrollViewCell.m
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//
#import "HomePageScrollView.h"
#import "HomePageScrollViewModel.h"

#import "UIImageView+WebCache.h"

@implementation HomePageScrollView
{
    NSMutableArray *_dataArray;
}

/**
 * 创建头部滚动视图
 */
- (void)createScrollView
{
    if (self.mainScorllView)
    {
        [self.mainScorllView removeFromSuperview];
    }
    
    // 循环 滚动 显示的View 数组
    NSMutableArray *viewsArray = [@[] mutableCopy];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    for (int i = 0; i < _dataArray.count; ++i)
    {
        HomePageScrollViewModel* model =[_dataArray objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width, height)];
        
//        目前是开发阶段，先用本地图片
        imageView.image = [UIImage imageNamed:model.url];
        
//        等开发之后再用网络图片
//        [imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:nil];
        
        [viewsArray addObject:imageView];
    }
    
    self.mainScorllView = [[AutoSlideScrollView alloc] initWithFrame:CGRectMake(0, 0,width, height) animationDuration:3];
    
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex)
    {
        return viewsArray[pageIndex];
    };
    
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        DebugLog(@"点击了第%ld个",pageIndex);
    };
    
    [self addSubview:self.mainScorllView];
}

-(void)bindDataArray:(NSMutableArray *)dataArray
{
    if ([dataArray isEqual:_dataArray] == NO && dataArray)
    {
        _dataArray = dataArray;
        
        [self createScrollView];
    }
}


@end
