//
//  TabBarButton.m
//  RebateMall
//
//  Created by 安帅 on 15/12/14.
//  Copyright (c) 2015年 silence. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

// 这里重写button的高亮方法，为了不让按钮显示高亮状态，所以不要调用父类的方法
- (void)setHidden:(BOOL)hidden{}
@end
