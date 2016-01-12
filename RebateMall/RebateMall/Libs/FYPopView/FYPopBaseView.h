//
//  FYPopBaseView.h
//  
//
//  Created by FYWCQ on 15/11/6.
//
//

#import <UIKit/UIKit.h>

@interface FYPopBaseView : UIControl


@property(nonatomic,strong)UIView * childredView;

-(void)show;

-(void)hide;
/**
 * 背景
 */
-(void)initChildrenViewWithFrame:(CGRect)frame;

@property(nonatomic,assign)CGRect hiddenFrame;

@property(nonatomic,assign)CGRect originFrame;

@end
