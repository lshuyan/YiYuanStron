//
//  UIImage+FitSize.h
//  AutoLearning
//
//  Created by 胡岩 on 16/2/16.
//  Copyright © 2016年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FitSize)

///  处理像素对齐的问题
- (UIImage *)al_fitSize:(CGSize)size;
- (UIImage *)al_imageWithCornerRadius:(CGFloat)radius size:(CGSize)size;
- (UIImage *)al_fitSize:(CGSize)size
              readState:(UIImage *)stateImage
          internalImage:(UIImage *)internalImage
              stateRect:(CGRect)stateRect
           internalRect:(CGRect)internalRect;
- (UIImage *)al_fitSize:(CGSize)size playImage:(UIImage *)playImage playRect:(CGRect)playRect;

/**
 *  通过颜色和尺寸生成图片
 *
 *  @param color 颜色
 *
 *  @return 图片对象
 */

+ (UIImage *) imageWithColor: (UIColor *) color;
@end
