//
//  FYBaseView.m
//  UMLifeAesthetes
//
//  Created by umanto on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FYBaseView.h"

#import "MBProgressHUD.h"

@interface FYBaseView ()

@property(nonatomic,strong)MBProgressHUD *proHUD;

@end

@implementation FYBaseView


-(void)showLoadingViewWithMessage:(NSString*)message
{
    if (message) {
        self.proHUD.labelText = message;
    }
    [self.proHUD show:YES];
}
-(void)stopLoadingViewWithMessage:(NSString*)message
{
    if (_proHUD == nil)
    {
        return;
    }
    if (message.length)
    {
            self.proHUD.labelText = message;
            [self.proHUD hide:YES afterDelay:.5];
    }
    else
    {
            [self.proHUD hide:YES];
    }
}
-(MBProgressHUD *)proHUD
{
    if (_proHUD == nil)
    {
        _proHUD = [[MBProgressHUD alloc] initWithView:self];
        
        [self addSubview:_proHUD];
    }
    [self bringSubviewToFront:_proHUD];
    return _proHUD;
}

@end
