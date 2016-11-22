//
//  OptionCellModel.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/22.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "OptionModel.h"
typedef NS_ENUM(NSInteger, OptionTableViewCellStyle) {
    OptionTableViewCellStyleDefault,
    OptionTableViewCellStyleValueLong,
};

@protocol OptionModel
@end

@interface OptionCellModel : JSONModel

@property (nonatomic, strong)NSString                                    *title;
@property (nonatomic, copy)NSArray <OptionModel>              *arrModels;
@property (nonatomic, assign)OptionTableViewCellStyle        optionTableViewCellStyle;

@end
