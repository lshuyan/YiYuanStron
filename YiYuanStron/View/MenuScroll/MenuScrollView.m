//
//  MenuScrollView.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/10.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MenuScrollView.h"

@interface MenuScrollView () <UIScrollViewDelegate>

@property(nonatomic, copy) VoidBlock_id          block;
@property(nonatomic, copy) NSArray                 *arrSrcModel; //源model
@property(nonatomic, copy) NSMutableArray     *arrTargerItme; //使用的arr
@property(nonatomic, copy) NSMutableArray     *arrpaddingViews; // 用于约束填充

@property(nonatomic, strong) UIView                  *linView;
@property(nonatomic, strong) UIView                  *paddingView; // 用于约束填充
@property(nonatomic, strong) UIScrollView         *mainScrollView;
@property(nonatomic, strong) UIButton                *selectButton; //选中的Bution

@property(nonatomic, assign) BOOL                    isFull;//是否满屏   蛮重要

///常量
@property(nonatomic, assign) CGFloat                fontSize;
@property(nonatomic, assign) CGFloat                fontSelectSize;
@property(nonatomic, strong) UIColor                 *fontColour;
@property(nonatomic, strong) UIColor                 *fontSelectColour;

@property(nonatomic, assign) CGFloat                 wight;
@property(nonatomic, assign) CGFloat                 sideSpace;

@end

@implementation MenuScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fontSize = 15;
        self.fontSelectSize = 18;
        self.fontColour = [UIColor blackColor];
        self.fontSelectColour = [UIColor redColor];
        
        self.wight = kSCREEN_WIGHT;
        self.sideSpace  = 10;
        [self initUI];
    }
    return self;
}

- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block
{
    //里面有操作可变数组 , 保险起见在主线程走
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.block = block;
        self.arrSrcModel = arr;
    });
}

- (void)initUI
{
    [self addSubview:self.mainScrollView];
}

- (void)setArrSrcModel:(NSArray *)arrSrcModel
{
    _arrSrcModel = [arrSrcModel copy];
    if (_arrSrcModel == nil) {
        _arrSrcModel = [[NSArray alloc] init];
    }
    [self createMenuItem];
    [self makeItmes];
    
}

#pragma mark  ----------- 逻辑
- (void)removeAllConstraints
{
    [self.mainScrollView removeFromSuperview];
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    for (int i = 0; i < self.arrTargerItme.count; i++) {
        UIButton *itme = self.arrTargerItme[i];
        [itme removeFromSuperview];
    }
    for (int i = 0; i < self.arrpaddingViews.count; i++) {
        UIView *itme = self.arrpaddingViews[i];
        [itme removeFromSuperview];
    }
    
}

- (void)addAllSubViews
{
    for (int i = 0; i < self.arrTargerItme.count; i++) {
        UIButton *itme = self.arrTargerItme[i];
        [self.mainScrollView addSubview:itme];
    }
    for (int i = 0; i < self.arrpaddingViews.count; i++) {
        UIView *itme = self.arrpaddingViews[i];
        [self.mainScrollView addSubview:itme];
    }
}

- (void)removeAllSubViews
{
    [self.arrTargerItme removeAllObjects];
    [self.arrpaddingViews removeAllObjects];
    [self.paddingView removeFromSuperview];
}

//添加itme
- (void)createMenuItem
{
    self.isFull = YES;
    [self removeAllConstraints];
    [self removeAllSubViews];
    @weakify(self)
    for (NSInteger i = 0 ; i< self.arrSrcModel.count  ; i++) {
        UIButton *itme = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *view = [self createPaddingView];
        [self.arrTargerItme addObject:itme];
        [self.arrpaddingViews addObject:view];
        [self.mainScrollView addSubview:itme];
        [self.mainScrollView addSubview:view];
        
        MenuItmeModel *model = self.arrSrcModel[i];
        [itme setTitle:model.title forState:0];
        [itme.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        [itme setTitleColor:self.fontColour forState:0];
        [itme setTitleColor:self.fontSelectColour forState:UIControlStateSelected];
        if (i == 0) {
            self.selectButton = itme;
        }
        
        [[itme rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton  *itme) {
            //回到主线程
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self_weak_.block(model);  //回调
                self_weak_.selectButton = itme;//设置字体
                [self_weak_ moveSelectionItme:itme];
            });
        }];
    }
    UIView *view = [self createPaddingView];
    [self.arrpaddingViews addObject:view];
    [self.mainScrollView addSubview:view];
}

- (void)makeItmes
{
    for (int i = 0; i < self.arrSrcModel.count; i++) {
        UIButton *itme = self.arrTargerItme[i];
        UIView *view = self.arrpaddingViews[i];
        UIView *viewNext = self.arrpaddingViews[i+1];

        // 左右编剧都是self.sideSpace.
        // 这里约束不能定scrollView 的contentSize的宽  因为内容还没有填充
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.height.equalTo(@44);
//            make.width.greaterThanOrEqualTo(@(self.sideSpace)).priorityLow(10);

            make.width.equalTo(viewNext.mas_width).priorityHigh(1000);
            if (i == 0) {
                make.left.equalTo(@0);
            }
        }];
        [itme mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.height.equalTo(@44);
            make.left.equalTo(view.mas_right);
            make.right.equalTo(viewNext.mas_left);
        }];
    }
    
//    UIButton *itme = [self.arrTargerItme lastObject];
    UIView *view = [self.arrpaddingViews lastObject];
    [self.mainScrollView insertSubview:self.paddingView atIndex:0];
    if (!self.isFull) {
        [self.paddingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
            make.width.equalTo(@(self.wight));
        }];
    }else{
        [self.paddingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(@0);
        }];
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.height.equalTo(@44);
        make.right.equalTo(@0);
        make.width.greaterThanOrEqualTo(@(self.sideSpace)).priorityLow(10);
    }];
    if (self.isFull) {
        [self.mainScrollView layoutIfNeeded];
        CGFloat right = view.right ;  // 最后一个菜单的右边
        if (right < self.wight) {
            self.isFull = NO;
            [self addAllSubViews];
            [self makeItmes];
        }
    }
    
}

- (void)moveSelectionItme:(UIButton *)button
{
    CGFloat contentX = button.center.x;
    CGFloat offsetX = 0;
    if (contentX<self.wight*.5) {
        offsetX = 0;
    } else if (contentX>self.mainScrollView.contentSize.width- self.wight*.5)
    {
        offsetX = self.mainScrollView.contentSize.width - self.wight;
    }else
    {
        offsetX = contentX - self.wight*.5;
    }
    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark ------------- set  get

- (NSMutableArray *)arrTargerItme
{
    if (!_arrTargerItme) {
        _arrTargerItme = [[NSMutableArray alloc] initWithCapacity:self.arrSrcModel.count];
    }
    return _arrTargerItme;
}

- (NSMutableArray *)arrpaddingViews
{
    if (!_arrpaddingViews) {
        _arrpaddingViews = [[NSMutableArray alloc] initWithCapacity:self.arrSrcModel.count];
    }
    return _arrpaddingViews;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return  _mainScrollView;
}

- (UIView *)paddingView
{
    if (!_paddingView) {
        // 约束填充用的view
        _paddingView= [self createPaddingView];
    }
    return _paddingView;
}

- (UIView *)createPaddingView
{
    UIView *view= [[UIView alloc] init];
    view.userInteractionEnabled = NO;
    return  view;
}

- (void)setSelectButton:(UIButton *)selectButton
{
    if (_selectButton) {
        _selectButton.selected = NO;
        [_selectButton.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
    }
    _selectButton = selectButton;
    _selectButton.selected = YES;
    [_selectButton.titleLabel setFont:[UIFont systemFontOfSize:self.fontSelectSize]];
}

@end
