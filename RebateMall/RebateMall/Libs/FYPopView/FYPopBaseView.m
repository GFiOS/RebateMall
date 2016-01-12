//
//  FYPopBaseView.m
//  
//
//  Created by FYWCQ on 15/11/6.
//
//

#import "FYPopBaseView.h"

@implementation FYPopBaseView

-(id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    
    if (self){
        
        CGFloat widthSort =[UIScreen mainScreen].bounds.size.width;
        
        CGFloat heightSort =[UIScreen mainScreen].bounds.size.height;
        
        
        self.frame = CGRectMake(0, 0, widthSort, heightSort);
        
        [self setBackgroundColor:[UIColor colorWithRed:0. green:0. blue:0. alpha:.8]];
        
        self.hidden = YES;
        
        [[[UIApplication sharedApplication].delegate window] addSubview:self];
        
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    return self;
}


-(void)initChildrenViewWithFrame:(CGRect)frame
{
    _originFrame = frame;
    
    
    _hiddenFrame = CGRectMake(_originFrame.origin.x, _originFrame.origin.y + _originFrame.size.height, _originFrame.size.width, _originFrame.size.height);
    
    _childredView = [[UIView alloc] initWithFrame:_hiddenFrame];
    
    _childredView .backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_childredView ];
}



-(void)show
{
    if (self.hidden == NO)
    {
        return;
    }
    [[[UIApplication sharedApplication].delegate window] addSubview:self];

    self.hidden = NO;
    
    self.userInteractionEnabled = YES;
    
    if (_childredView)
    {
        
        _childredView.alpha = 0.;
        
        if (_originFrame.origin.y != _childredView.frame.origin.y)
        {
            __weak typeof(self)weakSelf  = self;
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _childredView.alpha = 1.;
                weakSelf.childredView.frame = _originFrame;
                
            } completion:^(BOOL finished) {
            }];
            
        }else
        {
            [UIView animateWithDuration:0.1 animations:^{
                
                self.alpha = 1.;
                
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
        }
    }
}

-(void)hide
{
    self.userInteractionEnabled = NO;
    
    if (_childredView)
    {
        if (_hiddenFrame.origin.y != _childredView.frame.origin.y)
        {
            __weak typeof(self)weakSelf  = self;
            
            [UIView animateWithDuration:0.3 animations:^{
                
                _childredView.alpha = 0.;
                
                weakSelf.childredView.frame = _hiddenFrame;
                
            } completion:^(BOOL finished) {
//                [AppModel shareAppModel].chooseId = nil;

                weakSelf.hidden = YES;
                
            }];
        }
        
    }else
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            self.alpha = 0.;
            
        } completion:^(BOOL finished) {
            
        }];
 
    }
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    _originFrame = CGRectMake(0, self.frame.size.height - self.childredView.frame.size.height, self.frame.size.width, self.childredView.frame.size.height);
    
    _hiddenFrame = CGRectMake(_originFrame.origin.x, _originFrame.origin.y + _originFrame.size.height, _originFrame.size.width, _originFrame.size.height);
    
    self.childredView.frame = _hiddenFrame;
 
}

@end
