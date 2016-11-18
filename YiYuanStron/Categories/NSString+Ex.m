//
//  NSString+Ex.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/18.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "NSString+Ex.h"

@implementation NSString_Ex

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
