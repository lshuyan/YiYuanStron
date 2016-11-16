//
//  WebViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/15.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<hyWebViewDelegate>

@end

@implementation WebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.webView = [[hyWebView alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    self.webView.delegate = self;
    [self.webView load:@"http://www.baidu.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark ------------- delegate
- (void)webPageWillEndDragBackHome:(hyWebView *)webPage
{
    [self backToViewController];
}




@end
