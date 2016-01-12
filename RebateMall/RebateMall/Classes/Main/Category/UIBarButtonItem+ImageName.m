//
//  UIBarButtonItem+ImageName.m
//  RebateMall
//
//  Created by 安帅 on 15/12/14.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "UIBarButtonItem+ImageName.h"

@implementation UIBarButtonItem (ImageName)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action{

    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    buton.frame = CGRectMake(15, 0, 22, 22);
    [buton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [buton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:buton];
    
    return item;
}
@end
