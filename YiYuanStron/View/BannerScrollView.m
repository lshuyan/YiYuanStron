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
        self.block = block;
        self.model = model;
        self.button.backgroundColor = [UIColor colorWithHexString:self.model.bannerImg];

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
           NSLog(@"%@ ",  self_weak_.model.bannerImg);
            
            return [RACSignal empty];
        }];
    }
    return _button;
}

@end

#pragma  mark ----------------------- scroll---------------------------

@interface BannerScrollView () <UIScrollViewDelegate>

@property(nonatomic, copy) VoidBlock_id          block;
@property(nonatomic, copy) NSArray                 *arrSrcModel; //源model
@property(nonatomic, copy) NSMutableArray     *arrTargerModel; //使用的arr
@property(nonatomic, copy) NSMutableArray     *arrTargerItme; //使用的arr

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

- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block
{
    self.block = block;
    self.arrSrcModel = arr;
}

- (void)initUI
{
    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.mainScrollView];
    [self addSubview:self.pageControl];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    self.mainScrollView.backgroundColor  = [ UIColor greenColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(@0);
//        make.height.equalTo()
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
    
    if (self.arrTargerModel.count > self.arrTargerItme.count) {
        NSInteger count = self.arrTargerModel.count - self.arrTargerItme.count;
        for (NSInteger i = self.arrTargerItme.count ; i< count ; i++) {
            BannerItem *itme = [[BannerItem alloc] init];
            [self.arrTargerItme addObject:itme];
            [self.mainScrollView addSubview:itme];
            itme.backgroundColor = [UIColor orangeColor];
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
    NSLog(@"%f  |||  %ld", offsetX, page);

    if (offsetX <= 0
//        kSCREEN_WIGHT*.5
        ) {
        [scrollView setContentOffset:CGPointMake((maxWight - kSCREEN_WIGHT*2), 0) animated:NO];
    } else if (offsetX >= maxWight - kSCREEN_WIGHT
//               maxWight - kSCREEN_WIGHT*1.5
               ) {
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
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return  _mainScrollView;
}

@end
