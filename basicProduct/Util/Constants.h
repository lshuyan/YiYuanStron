//
//  APIConst.h
//  AutoLearning
//
//  Created by 胡岩 on 15/8/28.
//  Copyright (c) 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#pragma mark - Other

static NSString * const AppStoreLink    = @"i";

#if DEBUG

#define APIShareDomain @"http:/m/"
#define WebURLFeedback @"http://m="

static NSString *APIBaseDomain          = @"http:///";
static NSString *APIBaseGroup           = @"http://%@";
static NSString *APIBaseShare           = APIShareDomain;

#else

#define APIShareDomain @"htt/"
#define WebURLFeedback @"httId="

static NSString *APIBaseDomain          = @"httm/v3/";
static NSString *APIBaseGroup           = @"http@";
static NSString *APIBaseShare           = APIShareDomain;


#endif


