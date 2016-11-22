//
//  MainViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MainViewController.h"

#import "WebViewController.h"//wbe
#import "LoginViewController.h"//登录
#import "RegisterViewController.h"//注册
#import "EditPasswordViewController.h"//修改
#import "UserInfoViewController.h"//个人中心
#import "VipContentViewController.h"//个人中心

#import "BannerScrollView.h"
#import "MenuScrollView.h"

@interface MainViewController ()

@property (nonatomic, strong) BannerScrollView      *bannerScrollView;
@property (nonatomic, strong) MenuScrollView        *menuScrollVIew;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.view.layer.shadowRadius = 3;
////    self.navigationController.view.layer.masksToBounds = NO;
//    self.navigationController.view.layer.shadowOffset = CGSizeMake(-3,0);
//    self.navigationController.view.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.navigationController.view.layer.shadowOpacity = .6;//阴影透明度，默认0
    UIImageView *shadowView = [[UIImageView alloc] init];
    shadowView.image = [[UIImage imageNamed:@"shadow_left.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.navigationController.view addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(shadowView.superview.mas_left);
        make.top.bottom.equalTo(@0);
    }];

    [self addNavItem];
    [self addMenuScorllView];
    [self addBannerScrollView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    [self.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- private

- (void)addNavItem
{
    [self addNavTitilImage:kAppTitleImage];
    
    [self addRightRightItmesForTitles:nil images:@[@"home_nav_option", @"home_nav_search"] block:^(UIButton *itme) {
        if (itme.tag == 0) { //home_nav_option
            
        }else if (itme.tag == 1) //home_nav_search
        {
            
        }
    }];
    for (UIBarButtonItem *itme in self.navigationItem.rightBarButtonItems) {
        if (itme.customView.tag == 1) {
            itme.customView.frame = CGRectMake(0, 0, 45, 44);
        }
        if (itme.customView.tag == 0) {
            itme.customView.frame = CGRectMake(0, 0, 22, 44);
        }
    }
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
        NSArray *arr = @[@"登录", @"注册", @"忘记密码", @"修改密码", @"会员中心", @"个人中心",@"百度"];
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
                    ((RegisterViewController *)controller).isRegister = YES;
                }
                    break;
                case 2://忘记密码
                {
                    controller = [[RegisterViewController alloc] init];
                    [controller addNavBackItme];
                    ((RegisterViewController *)controller).isRegister = NO;
                }
                    break;
                case 3://修改密码
                {
                    controller = [[EditPasswordViewController alloc] init];
                    [controller addNavBackItme];
                }
                    break;
                case 4://会员中心
                {
                    controller = [[VipContentViewController alloc] init];
                    [controller addNavBackItme];
                }
                    break;
                case 5://个人中心
                {
                    controller = [[UserInfoViewController alloc] init];
                    [controller addNavBackItme];
                }
                    break;
                case 6://WEB
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
