//
//  GoodsCollectionView.m
//  RebateMall
//
//  Created by 安帅 on 15/12/15.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "GoodsCollectionView.h"
#import "GoodsCollectionCell.h"
#import "Tools.h"

@implementation GoodsCollectionView

static NSString *cellName = @"GoodsCollectionCell";
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

-(void)setup
{
    // 创建LayOut
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置网格大小
    CGFloat margin = kXFrom5(8);
    layout.itemSize = CGSizeMake(kXFrom5(101.0),kYFrom5(170.0));
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin); //Cell内边距
    layout.minimumLineSpacing = margin;//纵向Cell最小间距
    layout.minimumInteritemSpacing = margin; //横向Cell最小间距
    self.collectionViewLayout = layout;
    
    //向系统注册Cell
    [self.baseTableView registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:cellName];
    
    self.backgroundColor = [Tools colorWithHexString:kCollectionViewColorString];
    
//    [self addSubview:self.baseTableView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
//    return self.baseDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UMSingleItemModel *model = nil;
//    if (self.baseDataArray.count > indexPath.row)
//    {
//        model = (UMSingleItemModel *)[self.baseDataArray objectAtIndex:indexPath.row ];
//    }
    
    GoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    
    cell.backgroundColor = [Tools colorWithHexString:kCellColorString];
    
//    [cell bindDataModel:model];
    
    return cell;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    //自营商品详情页
//    UMProprietaryGoodsDetailsViewController *proprietaryGoodsDetailsVC = [[UMProprietaryGoodsDetailsViewController alloc] init];
//    proprietaryGoodsDetailsVC.hidesBottomBarWhenPushed = YES;
//    
//    //外链商品详情页
//    UMExternalGoodsController *externalGoodsVC = [[UMExternalGoodsController alloc] init];
//    externalGoodsVC.hidesBottomBarWhenPushed = YES;
//    //判断有没有uid和sid
//    UMLoginViewController *loginVC = [[UMLoginViewController alloc] init];
//    loginVC.hidesBottomBarWhenPushed = YES;
//    
//    //页面跳转
//    
//    UMSingleItemModel *model = nil;
//    if (self.baseDataArray.count > indexPath.row)
//    {
//        model = (UMSingleItemModel *)[self.baseDataArray objectAtIndex:indexPath.row ];
//    }
//    //单例传值把商品ID传过去
//    [AppModel shareAppModel].goods_id = model.goods_id;
//    //判断是自营还是外链商品
//    [AppModel shareAppModel].goods_remark = model.goods_remark;
//    
//    //goods_remark = 0时是自营商品 =1时是外链商品
//    if ([model.goods_remark isEqualToString:@"0"])
//    {
//        if (self.pushGoodsVC)
//        {
//            self.pushGoodsVC(proprietaryGoodsDetailsVC);
//        }
//    }
//    else
//    {
//        if (self.pushGoodsVC)
//        {
//            self.pushGoodsVC(externalGoodsVC);
//        }
//    }
}





@end
