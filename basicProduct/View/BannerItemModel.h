//
//  BannerItemModel.h
//  basicProduct
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BannerItemModel : JSONModel

//@property (nonatomic, assign)   NSInteger                 url;
@property (nonatomic, copy)     NSString                    *bannerImg;

@end
