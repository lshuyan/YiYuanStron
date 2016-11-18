//
//  UIImage+FitSize.m
//  AutoLearning
//
//  Created by 胡岩 on 16/2/16.
//  Copyright © 2016年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import "UIImage+FitSize.h"

@implementation UIImage (FitSize)

- (UIImage *)al_fitSize:(CGSize)size {
    if (self.size.width != size.width || self.size.height != size.height) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
        CGRect imageRect = (CGRect){0, 0, size};
        [self drawInRect:imageRect];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    return self;
}

- (UIImage *)al_imageWithCornerRadius:(CGFloat)radius size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:(CGRect){0, 0, size}
                                                         cornerRadius:radius].CGPath);
    [self drawInRect:(CGRect){0, 0, size}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)al_fitSize:(CGSize)size
              readState:(UIImage *)stateImage
          internalImage:(UIImage *)internalImage
              stateRect:(CGRect)stateRect
           internalRect:(CGRect)internalRect {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    CGRect imageRect = (CGRect){0, 0, size};
    [self drawInRect:imageRect];
    if (stateImage) {
        [stateImage drawInRect:stateRect];
    }
    if (internalImage) {
        [internalImage drawInRect:internalRect];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)al_fitSize:(CGSize)size playImage:(UIImage *)playImage playRect:(CGRect)playRect {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    CGRect imageRect = (CGRect){0, 0, size};
    [self drawInRect:imageRect];
    if (playImage) {
        [playImage drawInRect:playRect];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *) imageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

@end
