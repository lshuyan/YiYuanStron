//
//  EnumTypes.h
//  AutoLearning
//
//  Created by 胡岩 on 15/10/20.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. l rights reserved.
//

#ifndef EnumTypes_h
#define EnumTypes_h

#pragma mark - 支付

typedef NS_ENUM(NSInteger, PayType) {
    PayTypeiPay                 = 1,                                   //支付包
    PayTypeWechatPay              = 2,                                //微信
    PayTypeAppIDPay               = 4,                                //应用内支付
};

typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeNone                   = 0,                                //未登录
    LoginTypeNorm                 = 1,                                //注册登录
    LoginTypeQQ                     = 2,                                //QQ登录
    LoginTypeWeiXin                 = 3                                 //微信登录
};
typedef NS_ENUM(NSInteger, VipType) {
    VipTypeNone = 3,
    VipTypeVip = 1,
    VipTypeVipExpired = 2
};

///-----
///Block
///-----

typedef void (^VoidBlock)();
typedef BOOL (^BoolBlock)();
typedef int  (^IntBlock) ();
typedef id   (^IDBlock)  ();

typedef void (^VoidBlock_int)(int);
typedef void (^VoidBlock_bool)(BOOL);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)(int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);

#endif /* EnumTypes_h */


