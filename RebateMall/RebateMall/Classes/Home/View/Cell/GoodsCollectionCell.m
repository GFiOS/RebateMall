//
//  GoodsCollectionCell.m
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "GoodsCollectionCell.h"
//  使用Masonry 三方库进行适配
#import "Masonry.h"
#import "GoodsModel.h"
#import "Tools.h"

@interface GoodsCollectionCell()
// 图片
@property(strong,nonatomic)UIImageView  *iconImageView;
// 主标题
@property(strong,nonatomic)UILabel  *titleLableView;
// 描述信息
@property(strong,nonatomic)UILabel  *detailLableView;
// 优惠信息
@property(strong,nonatomic)UILabel  *discountLableView;
// 价格信息
@property(strong,nonatomic)UILabel  *priceLableView;
// 分割线
@property(strong,nonatomic)UIView *segmentLineView;
@end

@implementation GoodsCollectionCell
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
    
    // 图片
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.layer.cornerRadius = kXFrom5(2.0);
    self.iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    // 主标题
    self.titleLableView = [[UILabel alloc]init];
    self.titleLableView.textColor = [Tools colorWithHexString:kCellTitleColorString];
    self.titleLableView.font = [UIFont systemFontOfSize:kXFrom5(13)];
    [self.contentView addSubview:self.titleLableView];
    
    // 描述信息
    self.detailLableView = [[UILabel alloc]init];
    self.detailLableView.textColor = [Tools colorWithHexString:kCellDetailTitleColorString];
    self.detailLableView.font = [UIFont systemFontOfSize:kXFrom5(12)];
    [self.contentView addSubview:self.detailLableView];
    
    // 优惠信息
    self.discountLableView = [[UILabel alloc]init];
    self.discountLableView.textColor = [Tools colorWithHexString:kCellTitleColorString];
    self.discountLableView.font = [UIFont systemFontOfSize:kXFrom5(10)];
    [self.contentView addSubview:self.discountLableView];
    
    // 分割线
    self.segmentLineView = [[UIView alloc]init];
    self.segmentLineView.backgroundColor = [Tools colorWithHexString:kSectionHeaderTitleColorString];
    [self.contentView addSubview:self.segmentLineView];
    
    // 价格信息
    self.priceLableView  = [[UILabel alloc]init];
    self.priceLableView.textColor = [Tools colorWithHexString:kPriceColorString];
    self.priceLableView.font = [UIFont systemFontOfSize:kXFrom5(14)];
    [self.contentView addSubview:self.priceLableView];
    
    self.backgroundColor = [Tools colorWithHexString:kCellColorString];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 图片
    [self.iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self);
        make.height.equalTo(self.height).multipliedBy(0.59);//202/340
    }];
    
    // 主标题
    [self.titleLableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kXFrom5(10));
        make.top.equalTo(self.iconImageView.bottom).equalTo(kYFrom5(4));
        make.width.equalTo(self).offset(-kXFrom5(20));
        make.height.equalTo(kYFrom5(13));
    }];

    // 描述信息
    [self.detailLableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.titleLableView);
        make.top.equalTo(self.titleLableView.bottom).offset(kYFrom5(3));
        make.height.equalTo(kYFrom5(12));
    }];
    
    // 分割线
    [self.segmentLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kXFrom5(2));
        make.right.equalTo(self).offset(-kXFrom5(8));
        make.height.equalTo(1);
        make.top.equalTo(self.detailLableView.bottom).offset(kYFrom5(4));
    }];

    // 优惠信息
    [self.discountLableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentLineView.bottom).offset(kXFrom5(2));
        make.left.equalTo(self.titleLableView);
        make.height.equalTo(kYFrom5(10));
    }];

    // 价格信息
    [self.priceLableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentLineView.bottom).offset(kXFrom5(2));
        make.right.equalTo(self.right).offset(kXFrom5(-16));
        make.height.equalTo(kYFrom5(14));
    }];
}

- (void)bindDataWithModel:(GoodsModel *)model{
    
    NSString *iconPath = model.icon;
    self.iconImageView.image = [UIImage imageNamed:iconPath];
    
    self.titleLableView.text = model.title;
    
    self.detailLableView.text = model.detail;
    
    self.discountLableView.text = model.discount;
    
    self.priceLableView.text = [NSString stringWithFormat:@"¥%@",model.price];
}
@end
