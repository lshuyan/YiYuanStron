//
//  UIColor+Extern.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/8.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(Extern)

+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end
