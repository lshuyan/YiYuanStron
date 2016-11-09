//
//  UIView+Animations.m
//  AutoLearning
//
//  Created by 胡岩 on 15/12/15.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import "UIView+Animations.h"

//static void *strKey = &strKey;

@implementation UIView (Animations)

//-(void)setStr:(NSString *)str
//{
//    objc_setAssociatedObject(self, & strKey, str, OBJC_ASSOCIATION_COPY);
//}
//
//-(NSString *)str
//{
//    return objc_getAssociatedObject(self, &strKey);
//}

- (void)startHeartAnimation {
    UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.15f delay:0 options:op animations:^{
        [self.layer setValue:@(0.80) forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
            [self.layer setValue:@(1.3) forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:op animations:^{
                [self.layer setValue:@(1) forKeyPath:@"transform.scale"];
            } completion:NULL];
        }];
    }];
}

- (void)startTransitionAnimation {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}

- (void)startBouncesAnimation
{
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    frameAnimation.duration = 0.35;
    frameAnimation.values = @[
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                              ];
    [self.layer addAnimation:frameAnimation forKey:nil];
}

@end
