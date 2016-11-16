//
//  Macros.h
//  AutoLearning
//
//  Created by 胡岩 on 15/9/18.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//颜色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define COLOR_STRING(string) [UIColor colorWithHexString:string]
    //该应用专用主色调
#define COLOR_G [UIColor colorWithHexString:@"9ac153"] //绿
#define COLOR_Y [UIColor colorWithHexString:@"f8b62b"] //黄
#define COLOR_O [UIColor colorWithHexString:@"f39800"] //橘
#define COLOR_B [UIColor colorWithHexString:@"231815"] //黑


//机型
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//机型是否小于6
#define isIphoneLess_6 ([UIScreen mainScreen].bounds.size.height < 667)

//屏幕比例
#define kSCREEN_6 ([AppMagagerSingle shareManager].screenScaleFor6)
#define kSCREEN_WIGHT ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//输出类名 方法名的log
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* Macros_h */
