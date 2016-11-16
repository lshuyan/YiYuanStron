//
//  BannerScrollView.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "BannerScrollView.h"
#import "UIColor+Extern.h"

#pragma  mark ----------------------- item---------------------------

@interface BannerItem : UIView

//+ (instancetype)

@end

@interface BannerItem ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) BannerItemModel *model;
@property (nonatomic, copy) VoidBlock_id block;

- (void)makeForModel:(BannerItemModel *)model block:(VoidBlock_id)block;
@end

@implementation BannerItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)makeForModel:(BannerItemModel *)model block:(VoidBlock_id)block
{
    //里面有操作可变数组 , 保险起见在主线程走
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.block = block;
        self.model = model;
        self.button.backgroundColor = [UIColor colorWithHexString:self.model.bannerImg];
    });
    
}

- (void)initUI
{
    [self addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.imageView.contentMode = UIViewContentModeScaleAspectFill;
        @weakify(self)
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            self_weak_.block(self_weak_.model);
            return [RACSignal empty];
        }];
    }
    return _button;
}

@end

#pragma  mark ----------------------- BannerScrollView---------------------------

@interface BannerScrollView () <UIScrollViewDelegate>

@property(nonatomic, copy) VoidBlock_id          block;
@property(nonatomic, copy) NSArray                 *arrSrcModel; //源model
@property(nonatomic, copy) NSMutableArray     *arrTargerModel; //使用的arr
@property(nonatomic, copy) NSMutableArray     *arrTargerItme; //使用的arr
@property (nonatomic, strong)NSTimer               *timer;

@property(nonatomic, strong) UIPageControl      *pageControl;
@property(nonatomic, strong) UIScrollView         *mainScrollView;
@end

@implementation BannerScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block
{
    self.block = block;
    self.arrSrcModel = arr;
}

- (void)initUI
{
    [self addSubview:self.mainScrollView];
    [self addSubview:self.pageControl];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(@0);
    }];
}

- (void)setArrSrcModel:(NSArray *)arrSrcModel
{
    _arrSrcModel = [arrSrcModel copy];
    if (_arrSrcModel == nil) {
        _arrSrcModel = [[NSArray alloc] init];
    }
    [self createBannerItem];
    [self makeItmes];
    [self makePageControl];
    [self makeTime]; //开启定时
    
    [self.mainScrollView layoutIfNeeded];
    if (_arrSrcModel.count == 1) {
        self.mainScrollView.scrollEnabled = NO;
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        self.pageControl.hidden = YES;
    }else{
        self.mainScrollView.scrollEnabled = YES;
        self.pageControl.hidden = NO;
        [self.mainScrollView setContentOffset:CGPointMake(kSCREEN_WIGHT, 0) animated:NO];
    }
}

#pragma mark  ----------- 逻辑

//添加itme
- (void)createBannerItem
{
    //模拟无限循环
    // 假如有   A B C  页面
    //实际  C A B C A  这样放置.
    
    [self.arrTargerModel removeAllObjects];
    if (self.arrSrcModel.count == 1) {
        [self.arrTargerModel addObjectsFromArray:self.arrSrcModel];
    }else if (self.arrSrcModel.count > 1) {
        [self.arrTargerModel addObject:self.arrSrcModel.lastObject];
        [self.arrTargerModel addObjectsFromArray:self.arrSrcModel];
        [self.arrTargerModel addObject:self.arrSrcModel.firstObject];
    }else {
        BannerItemModel *model = [[BannerItemModel alloc] init];
        //这里需要一个显示没有信息的图片.
        model.bannerImg = @"";
    }
    for (BannerItem *itme in self.arrTargerItme) {
        [itme removeFromSuperview];
    }
    [self.arrTargerItme removeAllObjects];
    
    for (NSInteger i = 0 ; i< self.arrTargerModel.count ; i++) {
        BannerItem *itme = [[BannerItem alloc] init];
        [self.arrTargerItme addObject:itme];
        [self.mainScrollView addSubview:itme];
        [itme mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.equalTo(self);
            make.width.equalTo(@(kSCREEN_WIGHT));
            make.left.equalTo(self.mainScrollView.mas_left).offset(i*kSCREEN_WIGHT);
            if (i == (self.arrTargerModel.count -1)) {
                make.right.equalTo(self.mainScrollView.mas_right);
            }
        }];
    }
    
}

- (void)makeItmes
{
    for (int i = 0; i < self.arrTargerModel.count; i++) {
        BannerItem *itme = self.arrTargerItme[i];
        BannerItemModel *model = self.arrTargerModel[i];
        [itme makeForModel:model block:self.block];
    }
}

- (void)makePageControl
{
    self.pageControl.numberOfPages = self.arrSrcModel.count;
}

- (void)makeScrollView
{
    self.mainScrollView.contentOffset = CGPointMake(kSCREEN_WIGHT, 0);
}

- (void)makeTime
{
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(nextBanner) userInfo:nil repeats:YES];
//    [self.timer fire];
}

- (void)nextBanner
{
    NSInteger x = (NSInteger)(self.mainScrollView.contentOffset.x)%(NSInteger)(kSCREEN_WIGHT) + self.mainScrollView.contentOffset.x;
    [self.mainScrollView setContentOffset:CGPointMake(x + kSCREEN_WIGHT, 0) animated:YES];
}

#pragma mark ------------- 代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat maxWight = scrollView.contentSize.width;
    if (maxWight<kSCREEN_WIGHT*3) {
        return;
    }
    NSInteger page = (NSInteger)( offsetX/kSCREEN_WIGHT + 0.5);
    if (page == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages -1;
    } else if (page == self.pageControl.numberOfPages+1)
    {
        self.pageControl.currentPage = 0;
    }else {
        self.pageControl.currentPage = page-1;
    }
//    NSLog(@"%f  |||  %ld", offsetX, page);

    if (offsetX <= 0) {
        [scrollView setContentOffset:CGPointMake((maxWight - kSCREEN_WIGHT*2), 0) animated:NO];
    } else if (offsetX >= maxWight - kSCREEN_WIGHT) {
        [scrollView setContentOffset:CGPointMake(kSCREEN_WIGHT, 0) animated:NO];
    }

}

#pragma mark ------------- get set

- (NSMutableArray *)arrTargerModel
{
    if (!_arrTargerModel) {
        _arrTargerModel = [[NSMutableArray alloc] initWithCapacity:self.arrSrcModel.count +2];
    }
    return _arrTargerModel;
}

- (NSMutableArray *)arrTargerItme
{
    if (!_arrTargerItme) {
        _arrTargerItme = [[NSMutableArray alloc] initWithCapacity:self.arrSrcModel.count +2];
    }
    return _arrTargerItme;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return  _mainScrollView;
}

#pragma mark ------------- 重写

/// 事件传递
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self pointInside:point withEvent:event]) {
        //重新开启
        [self makeTime];
    }
    return [super hitTest:point withEvent:event];
}

@end
