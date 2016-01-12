//
//  HomeSectionHeaderView.m
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "HomeSectionHeaderView.h"
#import "Tools.h"

@implementation HomeSectionHeaderView

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
    self.backgroundColor = [Tools colorWithHexString:kSectionHeaderColorString];
}

- (void)bindDataWithModel:(id)model{
    // 如果只有标题就只显示标题好了（居中显示）
    if ([model isKindOfClass:[NSString class]]) {
        CGFloat x = kXFrom5(29.0); // 58/2
        CGFloat y = 0;
        CGFloat w = CGRectGetWidth(self.frame) - 2*x;
        CGFloat h = CGRectGetHeight(self.frame);
        UILabel *titleLable = [[UILabel alloc]initWithFrame:
        CGRectMake(x,y,w,h)];
        titleLable.text = model;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [Tools colorWithHexString:kSectionHeaderTitleColorString];
        titleLable.font = [UIFont systemFontOfSize:kXFrom5(11.0)];
        [self addSubview:titleLable];
    }
    
    // 如果是数组，就显示图标和标题（垂直居中显示）
    if ([model isKindOfClass:[NSArray class]]) {
        CGFloat x = kXFrom5(10.0);
        CGFloat w = kXFrom5(17.0);
        CGFloat h = w;
        CGFloat y = (CGRectGetHeight(self.frame) - h) *.5;
        
        if (model[0]) {// 图标
            UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(x,y,w,h)];
            iconView.image = [UIImage imageNamed:model[0]];
            [self addSubview:iconView];
        }

        if (model[1]) {// 标题
            x = kXFrom5(34.0);
            w = CGRectGetWidth(self.frame) * 0.5;
            h = CGRectGetHeight(self.frame);
            CGFloat y = (CGRectGetHeight(self.frame) - h) *.5;
            UILabel *titleLableView = [[UILabel alloc]initWithFrame:CGRectMake(x,y,w,h)];
            titleLableView.text = model[1];
            titleLableView.textColor = [Tools colorWithHexString:kPriceColorString];
            titleLableView.font = [UIFont systemFontOfSize:kXFrom5(13.0)];
            titleLableView.textAlignment = NSTextAlignmentLeft;
            [self addSubview:titleLableView];
        }
    }
}



@end
