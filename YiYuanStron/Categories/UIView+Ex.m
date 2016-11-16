//
//  UIView+EX.m
//
//  Created by Glex on 13-7-19.
//  Copyright (c) 2013年 KOTO Inc. All rights reserved.
//

#import "UIView+Ex.h"

#import <objc/runtime.h>

#import "UIColor+Expanded.h"

static const void *UserDataKey = &UserDataKey;

#define TagBgImage 0xFFFFFFF1

@interface UIView ()

@end

@implementation UIView (UIViewEx)

@dynamic userData;

#pragma mark - property
- (id)userData {
    return objc_getAssociatedObject(self, UserDataKey);
}

- (void)setUserData:(id)userData {
    if(userData) objc_setAssociatedObject(self, UserDataKey, userData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    else objc_removeAssociatedObjects(self);
}

- (CGFloat)left { return self.center.x-self.width*0.5; }

- (CGFloat)right { return self.center.x+self.width*0.5; }

- (CGFloat)top { return self.center.y-self.height*0.5; }

- (CGFloat)bottom { return self.center.y+self.height*0.5; }

- (CGFloat)height { return self.bounds.size.height; }

- (CGFloat)width { return self.bounds.size.width; }

- (UIImageView *)bgImageView{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:TagBgImage];
    return imageView;
}

- (void)setBgImageWithStretchImage:(UIImage *)image {
    UIImageView *imageView = self.bgImageView;
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.tag = TagBgImage;
        imageView.clipsToBounds = YES;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:imageView atIndex:0];
    }
    imageView.image = image;
    [self sendSubviewToBack:imageView];
}

- (void)setBgImageWithScaleAspectFillImage:(UIImage *)image {
    UIImageView *imageView = self.bgImageView;
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.clipsToBounds = YES;
        imageView.tag = TagBgImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:imageView atIndex:0];
    }
    imageView.image = image;
    [self sendSubviewToBack:imageView];
}

- (void)didAddSubview:(UIView *)subview
{
    UIImageView *imageView = self.bgImageView;
    if (imageView) {
        [self sendSubviewToBack:imageView];
    }
}

- (void)setBgColorWithImage:(UIImage *)image {
    self.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)setSubViewBgColor
{
    for (UIView *subView in self.subviews) {
        subView.backgroundColor = [UIColor randomDarkColor:0.5];
        [subView setSubViewBgColor];
    }
}

@end

//@implementation UIView (ViewController)
//
//- (UIViewController *)viewController
//{
//    // 下一个响应者
//    id next = [self nextResponder];
//    
//    while (next) {
//        
//        next = [next nextResponder];
//        
//        // 当下一个响应者派生自ViewController
//        if ([next isKindOfClass:[UIViewController class]]) {
//            return next;
//        }
//        
//    }
//    
//    return nil;
//}
//
//@end
