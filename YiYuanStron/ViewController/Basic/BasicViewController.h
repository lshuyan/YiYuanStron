//
//  BasicViewController.h
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationController.h"

@interface BasicViewController : UIViewController

@property (nonatomic, strong)MainNavigationController                         *mainNavController;

//设置为导航的rootview;
- (void)setNavigtion;
@end
