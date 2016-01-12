//
//  HomeZhuanChangTableCell.m
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "HomeZhuanChangTableCell.h"
#import "Masonry.h"
#import "Tools.h"

@interface HomeZhuanChangTableCell()

// 返利团
@property (weak, nonatomic) IBOutlet UIImageView *fanliView;
// 手机专享
@property (weak, nonatomic) IBOutlet UIImageView *zhunxiangView;
// 降价排行
@property (weak, nonatomic) IBOutlet UIImageView *paihangView;

@end

@implementation HomeZhuanChangTableCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
