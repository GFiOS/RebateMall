//
//  FYBaseCellModel.h
//  
//
//  Created by FYWCQ on 15/11/5.
//
//

#import "FYBaseModel.h"

#import <UIKit/UIKit.h>

@interface FYBaseCellModel : FYBaseModel

@property(nonatomic,strong)Class cellClass;

@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,copy)NSString *cellIdentifier;

//跳转页面
@property(nonatomic,copy)void(^pushVC)(UIViewController*);

@end
