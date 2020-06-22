//
//  LBXScanLineAnimation.m
//
//
//  Created by lbxia on 15/11/3.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "LBXScanLineAnimation.h"


@interface LBXScanLineAnimation()
{
    int num;
    BOOL down;
    NSTimer * timer;
    
    BOOL isAnimationing;
}

@property (nonatomic,assign) CGRect animationRect;

@end



@implementation LBXScanLineAnimation



- (void)stepAnimation
{
    if (!isAnimationing) {
        return;
    }
    
   
    CGFloat leftx = _animationRect.origin.x;
    CGFloat width = _animationRect.size.width;
    
    self.frame = CGRectMake(leftx, _animationRect.origin.y - 123 * 2, width, 123);
    
    self.alpha = 0.0;
    
    self.hidden = NO;
    
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
         weakSelf.alpha = 1.0;
        
     
        
    } completion:^(BOOL finished)
     {
         
     }];
    
    [UIView animateWithDuration:4 animations:^{
        CGFloat leftx = _animationRect.origin.x;
        CGFloat width = _animationRect.size.width;
        
        
        
        weakSelf.frame = CGRectMake(leftx, _animationRect.origin.y + _animationRect.size.height + 123, width, 123);
        
    } completion:^(BOOL finished)
     {
         self.hidden = YES;
         [weakSelf performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
     }];
}



- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView *)parentView Image:(UIImage*)image
{
    if (isAnimationing) {
        return;
    }
    
    isAnimationing = YES;

    
    self.animationRect = animationRect;
    down = YES;
    num =0;
    
    CGFloat centery = CGRectGetMinY(animationRect) + CGRectGetHeight(animationRect)/2;
    CGFloat leftx = animationRect.origin.x;
    CGFloat width = animationRect.size.width;
    
    self.frame = CGRectMake(leftx, centery+2*num, width, 123);
    self.image = image;
    
    [parentView addSubview:self];
    
    [self startAnimating_UIViewAnimation];
    
//    [self startAnimating_NSTimer];
    
    
}

- (void)startAnimating_UIViewAnimation
{
     [self stepAnimation];
}

- (void)startAnimating_NSTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(scanLineAnimation) userInfo:nil repeats:YES];
}

-(void)scanLineAnimation
{
    CGFloat centery = CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect)/2;
    CGFloat leftx = _animationRect.origin.x;
    CGFloat width = _animationRect.size.width;
    
    if (down)
    {
        num++;
        
        self.frame = CGRectMake(leftx, centery+2*num, width, 123);
        
        if (centery+2*num > (CGRectGetMinY(_animationRect) + CGRectGetHeight(_animationRect) - 5 ) )
        {
            down = NO;
        }
    }
    else {
        num --;
        self.frame = CGRectMake(leftx, centery+2*num, width, 123);
        if (centery+2*num < (CGRectGetMinY(_animationRect) + 5 ) )
        {
            down = YES;
        }
    }
}

- (void)dealloc
{
    [self stopAnimating];
}

- (void)stopAnimating
{
    if (isAnimationing) {
        
        isAnimationing = NO;
        
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        
        [self removeFromSuperview];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
