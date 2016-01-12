//
//  UIBarButtonItem+ImageName.h
//  RebateMall
//
//  Created by 安帅 on 15/12/14.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ImageName)

+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
@end
