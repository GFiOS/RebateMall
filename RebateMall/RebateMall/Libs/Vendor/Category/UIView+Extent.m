//
//  UIView+Extent.m
//  BabysDiet
//
//  Created by Leon on 15/9/17.
//  Copyright (c) 2015年 Medalans. All rights reserved.
//

#import "UIView+Extent.h"

@implementation UIView (Extend)


- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
