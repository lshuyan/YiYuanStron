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

@property(nonatomic, strong) UIView                  *linView;
@property(nonatomic, strong) UIView                  *paddingView; // 用于约束填充
@property(nonatomic, strong) UIScrollView         *mainScrollView;
@property(nonatomic, strong) UIButton                *selectButton; //选中的Bution

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

//添加itme
- (void)createMenuItem
{
    // 怕约束冲突, 先全部删除约束
    for (int i = 0; i < self.arrTargerItme.count; i++) {
        UIButton *itme = self.arrTargerItme[i];
        [itme removeFromSuperview];
    }
    [self.arrTargerItme removeAllObjects];
    [self.paddingView removeFromSuperview];
    [self.mainScrollView removeFromSuperview];
    [self addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    
    //如果本来有2子菜单,   下次是8个,  就只创建多的6个
    for (NSInteger i = 0 ; i< self.arrSrcModel.count  ; i++) {
        UIButton *itme = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.arrTargerItme addObject:itme];
        [self.mainScrollView addSubview:itme];
    }
}

- (void)makeItmes
{
    BOOL isFullSceen = NO;
    
    @weakify(self)
    for (int i = 0; i < self.arrSrcModel.count; i++) {
        UIButton *itme = self.arrTargerItme[i];
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
        
        // 左右编剧都是self.sideSpace.
        // 这里约束不能定scrollView 的contentSize的宽  因为内容还没有填充
        [itme mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.height.equalTo(@44);
            if (i == 0) {
                make.left.equalTo(@(self.sideSpace));
            } else if (i >0) {
                make.left.equalTo(((UIButton *)self.arrTargerItme[i-1]).mas_right).offset(self.sideSpace);
            }
        }];
        
        if (i == self.arrSrcModel.count - 1) {
            [itme mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-self.sideSpace));
            }];
            // 因为有两种情况
            // 一 .   菜单比较多,  可以填满整个屏幕的宽度,  每个菜单都以自身宽度为宽度
            // 二 .    菜单比较少, 比如只有一个 两个,   就不能以自身宽度了,   要以屏幕宽度居中显示.
            [self.mainScrollView layoutIfNeeded];
            CGFloat right = itme.frame.size.width+ itme.frame.origin.x +self.sideSpace;  // 最后一个菜单的右边
            if (right >= self.wight) { //不满屏的情况
                isFullSceen = YES;
            }else
            {
                [self.mainScrollView insertSubview:self.paddingView atIndex:0];
                [self.paddingView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.bottom.equalTo(@0);
                    make.width.equalTo(@(self.wight));
                }];
            }
        }
    }
    
    // 满屏 每个按钮一样宽
    if (!isFullSceen) {
        for (int i = 1; i < self.arrSrcModel.count; i++) {
            UIButton *button = self.arrTargerItme[i-1];
            UIButton *buttonNext = self.arrTargerItme[i];
            [buttonNext mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(button.mas_width);
            }];
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
        _paddingView= [[UIView alloc] init];
        _paddingView.userInteractionEnabled = NO;
    }
    return _paddingView;
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
