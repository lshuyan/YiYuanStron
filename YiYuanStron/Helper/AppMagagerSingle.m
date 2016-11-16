//
//  appMagagerSingle.m
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "AppMagagerSingle.h"

@interface AppMagagerSingle ()

@end

@implementation AppMagagerSingle


+ (instancetype)shareManager
{
    static AppMagagerSingle *instance;
    static dispatch_once_t onceAppMagagerSingleToken;
    dispatch_once(&onceAppMagagerSingleToken, ^{
        instance = [[AppMagagerSingle alloc] init];
        [instance initMagager];
    });
    return instance;
}

- (void)initMagager
{
    self.screenScaleFor6 = [UIScreen mainScreen].bounds.size.width/375;
    self.mainContollerLeftScale = 0.8;
}

@end
