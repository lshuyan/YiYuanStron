//
//  MainViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MainViewController.h"
#import "BannerScrollView.h"
#import "MenuScrollView.h"
#import "WebViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) BannerScrollView      *bannerScrollView;
@property (nonatomic, strong) MenuScrollView        *menuScrollVIew;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kAppTitle;
    
    [self addMenuScorllView];
    [self addBannerScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addBannerScrollView
{
    [self.view addSubview:self.bannerScrollView];
    [self.bannerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@44);
        make.height.equalTo(@200);
    }];
}

- (void)addMenuScorllView
{
    [self.view addSubview:self.menuScrollVIew];
    [self.menuScrollVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@44);
    }];
}

#pragma mark -------------  set get

- (BannerScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        _bannerScrollView = [[BannerScrollView alloc] init];
        NSMutableArray *arr =[[NSMutableArray alloc] initWithCapacity:2];
        for (int i = 0; i < 5; i++) {
            BannerItemModel *model = [[BannerItemModel alloc] initWithDictionary:@{@"bannerImg":[NSString stringWithFormat:@"%d%d%d%d%d%d", i*2, i*2, i*2, i*2, i*2, i*2]} error:nil];
            [arr addObject:model];
        }
        [_bannerScrollView makeForItemModels:arr callBackBlock:^(BannerItemModel *model) {
            WebViewController *controller = [[WebViewController alloc] init];
            controller.view.backgroundColor = [UIColor orangeColor];
            [controller addNavBackItme];
//            controller.view.clipsToBounds=YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }];
    }
    return _bannerScrollView;
}

- (MenuScrollView *)menuScrollVIew
{
    if (!_menuScrollVIew) {
        _menuScrollVIew = [[MenuScrollView alloc] init];
//        NSArray *arr = @[@"登录", @"注册", @"会员中心", @"个人中心", @"忘记密码",@"百度",@"dddddddddddddd"];
        NSArray *arr = @[@"登录", @"注册", @"会员中心", @"个人中心", @"忘记密码",@"百度"];
//        NSArray *arr2= @[@"点点滴都滴", @"江诗丹顿", @"江诗顿", @"丹顿"];
//        NSArray *arr2 = @[@"点点滴都滴", @"江诗丹顿"];

        NSMutableArray *arrModel =[[NSMutableArray alloc] initWithCapacity:2];
        for (int i = 0; i < arr.count; i++) {
            MenuItmeModel *model = [[MenuItmeModel alloc] init];
            model.title = arr[i];
            model.itmeId = i;
            [arrModel addObject:model];
        }
        [_menuScrollVIew makeForItemModels:arrModel callBackBlock:^(MenuItmeModel *model) {
            NSLog(@"%@ --------------------",  model.title);
            BasicViewController *controller;
            switch (model.itmeId) {
                case 0: //登录
                {
                    controller = [[LoginViewController alloc] init];
                    [controller addNavLeftItmeForTitle:nil image:nil block:nil];
                }
                    break;
                case 1://注册
                {
                    controller = [[RegisterViewController alloc] init];
                    [controller addNavBackItme];
                }
                    break;
                case 2://会员中心
                    
                    break;
                case 3://个人中心
                    
                    break;
                case 4://忘记密码
                    
                    break;
                case 5://webview
                {
                    controller = [[WebViewController alloc] init];
                    [controller addNavBackItme];
                    [((WebViewController *)controller).webView load:@"www.qq.com"];
                }
                    break;
                    
                default:
                    break;
            }
            if (controller) {
                [self.navigationController pushViewController:controller animated:YES];
            }

            
        }];
        
    }
    return _menuScrollVIew;
}

@end
