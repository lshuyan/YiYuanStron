//
//  hyWebView.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/15.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NJKWebViewProgress.h"

@protocol hyWebViewDelegate;

@interface hyWebView : UIView <NJKWebViewProgressDelegate, UIWebViewDelegate>
{
    NJKWebViewProgress *_progressProxy;
    UIImageView *_imageViewSnapshot;
    UIView *_viewProgress;
}

@property (nonatomic, weak) IBOutlet id<hyWebViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIWebView *webView;

/**
 *  当前窗口的标题，供外部外部显示使用
 */
@property (nonatomic, strong, readonly) NSString *titleOfShow;
/**
 *  当前网页的真实标题，可能没有标题
 */
@property (nonatomic, strong, readonly) NSString *title;
/**
 *  但前网页的链接
 */
@property (nonatomic, strong, readonly) NSString *link;
/**
 *  调用 load 时 link 参数，称为原始链接
 */
@property (nonatomic, strong, readonly) NSString *linkOrigin;

@property (nonatomic, assign, readonly) BOOL isShowCoverLogo;
@property (nonatomic, assign, readonly) BOOL isShowCoverView;

@property (nonatomic, assign) BOOL show;

@property (nonatomic, strong) id userInfo;

/**
 *  是否显示 进度条，默认 YES
 */
@property (nonatomic, assign) BOOL shouldShowProgress;
@property (nonatomic, assign, readonly) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL canBack;
@property (nonatomic, assign, readonly) BOOL canForward;
@property (nonatomic, assign, readonly) BOOL isLoading;

/**
 *  进度条颜色
 */
@property (nonatomic, strong) UIColor *progressColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL shouldInterceptRequest;

/**
 *  快照，检查是否有快照，快照需要外部来调用
 */
//@property (nonatomic, assign, getter = hasSnapshot) BOOL snapshot;

/**
 *  字体比例(字体大小)
 */
//@property (nonatomic, assign) CGFloat fontScale;

/**
 *  无图模式
 */
//@property (nonatomic, assign) BOOL noImageMode;

// ------------------- 页内查找相关 begin-------------
/**
 *  页内查找模式，页内查找模式的时候，网页不允许操作：前进，后退，刷新，加载网页，点击打开链接
 */
@property (nonatomic, assign, readonly) BOOL isFindInPageMode;
@property (nonatomic, assign, readonly) NSInteger numberOfKeyword;
@property (nonatomic, assign, readonly) NSInteger indexOfKeyrowd;
// ------------------- 页内查找相关 begin-------------

/**
 *  加载网页链接地址
 *
 *  @param link 链接地址
 */
- (void)load:(NSString *)link;

/**
 *  重新加载 网页 （*** 这是函数超重要）
 *  1、判断是否 有快照
 *      有：网页强制加载原来的链接地址
 *      无：判断是否是标准 href (带有 http:// 或 https:// 的 _link)
 */
- (void)reload;

/**
 *  停止加载
 */
- (void)stop;

/**
 *  后退
 */
- (void)goBack;

/**
 *  前进
 */
- (void)goForward;

/**
 *  显示加载封面
 *
 *  @param viewCover 封面视图
 *  @param viewLogo logo视图
 */
- (void)showLoadingCover:(UIView *)viewCover viewLogo:(UIView *)viewLogo;
- (void)startCoverLogoAnimation;
- (void)hideLoadingCover;

// ------------------- 页内查找相关 begin-------------
/**
 *  开始页内查找模式
 */
- (void)beginFindInPage;

/**
 *  结束页内查找
 */
- (void)endFindInPage;

/**
 *  查找关键字
 *
 *  @param keyword 关键字
 *
 *  @return NSInteger 查找到的总数量
 */
- (NSInteger)findInPageWithKeyword:(NSString *)keyword;

/**
 *  滚动到 第几个关键字
 *
 *  @param index 索引
 */
- (void)scrollToKeywordIndex:(NSInteger)index;
- (void)scrollToPrevKeyword;
- (void)scrollToNextKeyword;
// ------------------- 页内查找相关 end --------------

@end

@protocol hyWebViewDelegate <NSObject, UIScrollViewDelegate>

@optional
/**
 *  请求打开链接
 *
 *  @param webPage hyWebView
 *  @param link        链接地址
 *  @param UrlOpenStyle 链接打开方式
 */
//- (void)webPage:(hyWebView *)webPage reqLink:(NSString *)link UrlOpenStyle:(UrlOpenStyle)UrlOpenStyle;

/**
 *  开始加载, 外部接受此事件后 要显示 停止按钮
 *
 *  @param webPage hyWebView
 */
- (void)webPageDidStartLoad:(hyWebView *)webPage;

/**
 *  结束加载, 外部接受此事件后 要显示 刷新按钮
 *
 *  @param webPage hyWebView
 */
- (void)webPageDidEndLoad:(hyWebView *)webPage;

/**
 *  标题已更新
 *
 *  @param webPage hyWebView
 *  @param title       网页标题
 */
- (void)webPage:(hyWebView *)webPage didUpdateTitle:(NSString *)title;

/**
 *  网页链接
 *
 *  @param webPage hyWebView
 *  @param link        网页链接
 */
- (void)webPage:(hyWebView *)webPage didUpdateLink:(NSString *)link;

/**
 *  松手回到首页
 *
 *  @param webPage hyWebView
 */
- (void)webPageWillEndDragBackHome:(hyWebView *)webPage;

@end

