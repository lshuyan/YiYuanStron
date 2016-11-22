//
//  APIConst.h
//  AutoLearning
//
//  Created by 胡岩 on 15/8/28.
//  Copyright (c) 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#pragma mark - Other
static NSString * const kAppTitle    = @"易源商城";
static NSString * const kAppTitleImage    = @"home_nav_title";
static NSString * const kAppStoreLink    = @"";

#if DEBUG

#define APIShareDomain @""
#define WebURLFeedback @""

static NSString *APIBaseDomain          = @"";
static NSString *APIBaseGroup           = @"";
static NSString *APIBaseShare           = APIShareDomain;

#else

#define APIShareDomain @""
#define WebURLFeedback @""

static NSString *APIBaseDomain          = @"";
static NSString *APIBaseGroup           = @"";
static NSString *APIBaseShare           = APIShareDomain;


#endif


