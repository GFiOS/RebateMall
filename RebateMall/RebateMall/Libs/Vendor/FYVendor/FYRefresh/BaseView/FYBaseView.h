//
//  FYBaseView.h
//  UMLifeAesthetes
//
//  Created by umanto on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYBaseView : UIView

-(void)showLoadingViewWithMessage:(NSString*)message;
-(void)stopLoadingViewWithMessage:(NSString*)message;
@end
