//
//  hyWebView.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/15.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "hyWebView.h"
//#import "UnpreventableUILongPressGestureRecognizer.h"
//#import "BlockUI.h"
#import "UIWebViewAdditions.h"
#import "UIImage+Ex.h"

#import "MDRadialProgressView.h"

#define kProgressWidthForZero 10
#define kDragWidth 80.0f

#define kTextLeftContinue @"继续后拉后退"
#define kTextLeftRelease @"松开后退"

#define kTextLeftContinueBackHome @"继续右拉返回"
#define kTextLeftReleaseBackHome @"松开返回"

#define kTextRightContinue @"继续左拉前进"
#define kTextRightRelease @"松开前进"
#define kTextRightCannotForward @"不能前进了"

typedef NS_ENUM(NSInteger, CustomPanDirection) {
    CustomPanDirectionUnknow,
    CustomPanDirectionLeft,
    CustomPanDirectionRight,
    CustomPanDirectionTop,
    CustomPanDirectionBottom
};

@interface CustomPanGesture : UIPanGestureRecognizer

@property (nonatomic, assign) CustomPanDirection customPanDirection;

@end

@implementation CustomPanGesture

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
    if (CustomPanDirectionUnknow!=self.customPanDirection || 2==self.minimumNumberOfTouches) {
        // 拦截手势传递
        return NO;
    }
    else {
        // 放行手势传递
        return YES;
    }
}

@end

// -----------------------------------------------------

@interface hyWebView () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    // 下拉
    MDRadialProgressView *_progressRefresh;
    // 左右拉
    UIView *_viewDragL;
    UIImageView *_imageViewDragL;
    UILabel *_labelDragL;
    
    UIView *_viewDragR;
    UIImageView *_imageViewDragR;
    UILabel *_labelDragR;
    
    NSTimer *_timer;
    NSInteger _timeTicket;
    
    // cover
    UIView *_viewCover;
    UIView *_viewLogo;
}

/**
 *  初始化设置
 */
- (void)setup;


- (void)updateProgress:(CGFloat)progress;
- (void)resizeProgresView:(CGFloat)progress;

- (void)resetTimer;
- (void)timerWorking;
- (void)stopTimer;

@end

@implementation hyWebView

@synthesize titleOfShow = _titleOfShow;
@synthesize title = _title;
@synthesize link = _link;
@synthesize isLoading = _isLoading;
@synthesize isShowCoverLogo = _isShowCoverLogo;
@synthesize isShowCoverView = _isShowCoverView;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)dealloc
{
    [self stopTimer];
    _progressProxy.webViewProxyDelegate = nil;
    _webView.delegate = nil;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self resizeProgresView:_progress];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - property
- (NSString *)titleOfShow
{
//    if (!_snapshot) {
        _titleOfShow = _title;
        if (0==_titleOfShow.length) {
//            if (_isLoading) {
                _titleOfShow = @"正在加载";
//            }
//            else {
//                _titleOfShow = @"新窗口";
//            }
        }
//    }
    return _titleOfShow;
}

- (NSString *)title
{
    if ([_link isEqualToString:_webView.link]) {
        _title = [_webView title];
    }
    else {
        if (_isLoading) {
        }
        else {
            _title = [_webView title];
        }
    }
    return _title;
}

- (NSString *)link
{
    return _link;
}

- (BOOL)isShowCoverLogo
{
    return _viewLogo?YES:NO;
}

- (BOOL)isShowCoverView
{
    return _viewCover?YES:NO;
}

- (void)setShouldShowProgress:(BOOL)shouldShowProgress
{
    _shouldShowProgress = shouldShowProgress;
    if (_shouldShowProgress) {
        if (0.0==_progress) {
            [UIView animateWithDuration:0.1 animations:^{
                _viewProgress.alpha = 1.0;
            }];
        }
        
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            [self resizeProgresView:_progress];
        } completion:nil];
    }
    else {
        [UIView animateWithDuration:0.1 animations:^{
            _viewProgress.alpha = 0;
        }];
    }
}

- (BOOL)canBack
{
    return _webView.canGoBack;
}

- (BOOL)canForward
{
    return _webView.canGoForward;
}

- (BOOL)isLoading
{
    return _isLoading;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    _viewProgress.backgroundColor = progressColor;
    if (_viewProgress.superview) {
        NSInteger index = [_viewProgress.superview.subviews indexOfObject:_viewProgress];
        [_viewProgress removeFromSuperview];
        [self insertSubview:_viewProgress atIndex:index];
    }
}

#pragma mark - private methods
- (void)setup
{
    _isFindInPageMode = NO;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _progressProxy.progressDelegate = self;
    _progressProxy.webViewProxyDelegate = self;
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.86];
    
    _webView = [[UIWebView alloc] initWithFrame:self.bounds];
    _webView.delegate = _progressProxy;
    _webView.scalesPageToFit = YES;
    _webView.opaque = YES;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _webView.clipsToBounds = NO;
    
    [_webView.scrollView.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }];
    
    // TOTO: 扩展用，下拉 刷新，左 拉后腿，右 拉前进
    _webView.scrollView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.delegate = self;
    _webView.scrollView.alwaysBounceHorizontal = YES;
    _webView.scrollView.alwaysBounceVertical = YES;
    _webView.scrollView.clipsToBounds = NO;
    
    CGRect rc = CGRectZero;
    rc.size.height = 1.5;
    rc.size.width = 10;
    _viewProgress = [[UIView alloc] initWithFrame:rc];
    _viewProgress.backgroundColor = [UIColor blueColor];
    _viewProgress.alpha = 0;
    
    [self addSubview:_webView];
    [self addSubview:_viewProgress];
    
    _progress = 1;
    _isLoading = NO;
    _shouldShowProgress = YES;
    _shouldInterceptRequest = NO;
    
    
    // ------------ 下拉刷新
    rc.size.width =
    rc.size.height = 30;
    rc.origin.x = self.width*0.5-rc.size.width*0.5;
    rc.origin.y = 0;
    _progressRefresh = [[MDRadialProgressView alloc] initWithFrame:rc];
    _progressRefresh.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    _progressRefresh.progressTotal = 100;
    _progressRefresh.progressCounter = 1;
    _progressRefresh.startingSlice = 1;
    _progressRefresh.clockwise = YES;
    _progressRefresh.theme.thickness =_progressRefresh.bounds.size.width-0;
    _progressRefresh.theme.completedColor = [UIColor brownColor];
    _progressRefresh.theme.sliceDividerThickness = 0;
    _progressRefresh.theme.dropLabelShadow = NO;
    
    [self insertSubview:_progressRefresh atIndex:0];
    
    // ---------- 左右拉
    {
        _viewDragL = [[UIView alloc] initWithFrame:self.bounds];
        
        _imageViewDragL = [[UIImageView alloc] initWithFrame:_viewDragL.bounds];
        _imageViewDragL.image = [[UIImage imageNamed:@"shadow_left.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        _imageViewDragL.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [_viewDragL addSubview:_imageViewDragL];
        
        _labelDragL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _labelDragL.numberOfLines = 1;
        _labelDragL.textColor = [UIColor grayColor];
        _labelDragL.text = kTextLeftContinue;
        _labelDragL.backgroundColor = [UIColor clearColor];
        _labelDragL.center = CGPointMake(_viewDragL.width/2, _viewDragL.height/2);
        _labelDragL.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [_viewDragL addSubview:_labelDragL];
        
        _labelDragL.font = [UIFont boldSystemFontOfSize:14];
        
        [self insertSubview:_viewDragL atIndex:0];
        
        _viewDragL.hidden = YES;
        _labelDragL.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    
    {
        _viewDragR = [[UIView alloc] initWithFrame:self.bounds];
        
        _imageViewDragR = [[UIImageView alloc] initWithFrame:_viewDragR.bounds];
        _imageViewDragR.image = [[UIImage imageNamed:@"shadow_right.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        _imageViewDragR.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [_viewDragR addSubview:_imageViewDragR];
        
        _labelDragR = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _labelDragR.numberOfLines = 1;
        _labelDragR.textColor = [UIColor grayColor];
        _labelDragR.text = kTextRightContinue;
        _labelDragR.backgroundColor = [UIColor clearColor];
        _labelDragR.center = CGPointMake(_viewDragR.width/2, _viewDragR.height/2);
        _labelDragR.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [_viewDragR addSubview:_labelDragR];
        
        _labelDragR.font = [UIFont boldSystemFontOfSize:14];
        
        [self insertSubview:_viewDragR atIndex:0];
        
        _viewDragR.hidden = YES;
        _labelDragR.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

- (void)updateProgress:(CGFloat)progress
{
    if (progress == 0.0) {
        /**
         *  动画 显示，即时调整 frame
         */
        _isLoading = YES;
        if([_delegate respondsToSelector:@selector(webPageDidStartLoad:)])
            [_delegate webPageDidStartLoad:self];
        
        if (_shouldShowProgress) {
            [self resizeProgresView:progress];
            [UIView animateWithDuration:0.1 animations:^{
                _viewProgress.alpha = 1.0;
            }];
        }
        
        // TODO: 重置计时器，超时后 强制终止
        [self resetTimer];
    }
    else {
        /**
         *  动画调整 frame
         */
        if (_shouldShowProgress) {
            [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
                [self resizeProgresView:progress];
            } completion:nil];
        }
    }
    
    if (progress == 1.0) {
        [self stopTimer];
        /**
         *  动画 隐藏
         */
        _isLoading = NO;
        
        if([_delegate respondsToSelector:@selector(webPageDidEndLoad:)])
            [_delegate webPageDidEndLoad:self];
        
        [UIView animateWithDuration:0.25 animations:^{
            if (_viewProgress) {
                _viewProgress.alpha = 0.0;
            }
        }];

        [self hideLoadingCover];
    }
    
    // 设置标题和链接
    if ([_delegate respondsToSelector:@selector(webPage:didUpdateTitle:)])
        [_delegate webPage:self didUpdateTitle:[self title]];
    
    if ([_delegate respondsToSelector:@selector(webPage:didUpdateLink:)])
        [_delegate webPage:self didUpdateLink:[self link]];
    
    _progress = progress;
}

- (void)resizeProgresView:(CGFloat)progress
{
    CGRect rc = _viewProgress.frame;
    rc.size.width = kProgressWidthForZero+progress*(self.bounds.size.width-kProgressWidthForZero);
    _viewProgress.frame = rc;
}

- (void)resetTimer
{
    if (_timer) {
        _timeTicket = 0;
    }
    else {
        _timeTicket = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerWorking) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timerWorking
{
    _timeTicket++;
    if (_timeTicket>=MIN(30, _webView.request.timeoutInterval)) {
        [self stopTimer];
        [self stop];
    }
}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _timeTicket = 0;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isFindInPageMode) return;
    
    if ([_delegate respondsToSelector:@selector(scrollView)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
    CGPoint pt = [scrollView.panGestureRecognizer translationInView:scrollView];
    if (pt.x==0) {
        // y轴方向移动
        if (scrollView.contentOffset.y<0) {
            _progressRefresh.hidden = NO;
            CGFloat y = fabs(scrollView.contentOffset.y);
            CGFloat yMore = y-_progressRefresh.progressTotal;
            CGAffineTransform tfScale = CGAffineTransformIdentity;
            if (yMore>0) {
                CGFloat scale = MIN(1+yMore/_progressRefresh.progressTotal, 2);
                _progressRefresh.progressCounter = _progressRefresh.progressTotal;
                tfScale = CGAffineTransformMakeScale(scale, scale);
            }
            else
            {
                _progressRefresh.progressCounter = MAX(y, 0);
            }
            
            CGAffineTransform tfTrans = CGAffineTransformMakeTranslation(0, MAX(0, (y-_progressRefresh.height)*0.5));
            _progressRefresh.transform = CGAffineTransformConcat(tfScale, tfTrans);
        }
        else {
            _progressRefresh.hidden = YES;
        }
    }
    else {
        _progressRefresh.hidden = YES;
        if (pt.y==0) {
            // x轴方向移动
            CGFloat right = scrollView.contentOffset.x+scrollView.width-scrollView.contentSize.width;
            CGFloat left = -scrollView.contentOffset.x;
            
            _viewDragL.hidden = YES;
            _viewDragR.hidden = YES;
            if (left>0) {
                
                if (_webView.canGoBack) {
                    // 这是要后退的节奏
                    
                    _viewDragL.hidden = NO;
                    CGRect rc = _webView.bounds;
                    rc.size.width = MAX(kDragWidth, left);
                    rc.origin.x = MIN(0, left-kDragWidth);
                    _viewDragL.frame = rc;
                    
                    _labelDragL.text = kTextLeftContinue;
                    if (left>kDragWidth) {
                        _labelDragL.text = kTextLeftRelease;
                    }
                    
                    [_labelDragL sizeToFit];
                }
                else {
                    // 这是要消失的节奏
                    _viewDragL.hidden = NO;
                    CGRect rc = _webView.bounds;
                    rc.size.width = MAX(kDragWidth, left);
                    rc.origin.x = MIN(0, left-kDragWidth);
                    _viewDragL.frame = rc;
                    
                    _labelDragL.text = kTextLeftContinueBackHome;
                    if (left>kDragWidth) {
                        _labelDragL.text = kTextLeftReleaseBackHome;
                    }
                    
                    [_labelDragL sizeToFit];
                }
            }
            if (right>0) {
                if (_webView.canGoForward) {
                    // 这是要前进的节奏
                    
                    _viewDragR.hidden = NO;
                    CGRect rc = _webView.bounds;
                    rc.size.width = MAX(kDragWidth, right);
                    rc.origin.x = self.width-right;
                    rc.origin.y = 0;
                    _viewDragR.frame = rc;
                    
                    _labelDragR.text = kTextRightContinue;
                    if (right>kDragWidth) {
                        _labelDragR.text = kTextRightRelease;
                    }
                    
                    [_labelDragR sizeToFit];
                }
                else {
                    _viewDragR.hidden = NO;
                    
                    CGRect rc = _webView.bounds;
                    rc.size.width = MAX(kDragWidth, right);
                    rc.origin.x = self.width-right;
                    rc.origin.y = 0;
                    _viewDragR.frame = rc;
                    
                    _labelDragR.text = kTextRightCannotForward;
                    
                    [_labelDragR sizeToFit];
                }
            }
        }
        else {
            _viewDragL.hidden = YES;
            _viewDragR.hidden = YES;
        }
    }
    
    //    _viewProgress.transform = CGAffineTransformMakeTranslation(-scrollView.contentOffset.x, MAX(0, -scrollView.contentOffset.y));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_isFindInPageMode) return;
    
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
    
    CGPoint pt = [scrollView.panGestureRecognizer translationInView:scrollView];
    if (pt.x==0) {
        if (_progressRefresh.progressTotal==_progressRefresh.progressCounter) {
            [self reload];
        }
    }
    else if (pt.y==0) {
        
        // x轴方向移动
        CGFloat right = scrollView.contentOffset.x+scrollView.width-scrollView.contentSize.width;
        CGFloat left = -scrollView.contentOffset.x;
        
        if (left>kDragWidth) {
            // 这是要后退的节奏
            if (_webView.canGoBack) {
                // 能后退则后退
                [_webView goBack];
            }
            else {
                //                [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
                [_delegate webPageWillEndDragBackHome:self];
            }
        }
        if (right>kDragWidth) {
            // 这是要前进的节奏
            if (_webView.canGoForward) {
                // 能前进则前进
                [_webView goForward];
            }
            else {
                //                [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _progressRefresh.hidden = YES;
    _viewDragL.hidden = YES;
    _viewDragR.hidden = YES;
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self updateProgress:progress];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (_isFindInPageMode) return NO;
    
    NSString *url = request.URL.absoluteString;
    if ([url hasPrefix:@"http://itunes.apple.com/"]||
        [url hasPrefix:@"https://itunes.apple.com/"]||
        [url hasPrefix:@"itms-apps://itunes.apple.com/"]) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    if (UIWebViewNavigationTypeOther!=navigationType && ([url hasPrefix:@"http://"]||[url hasPrefix:@"https://"])) {
        _link = url;
        if ([_delegate respondsToSelector:@selector(webPage:didUpdateLink:)])
        {
            // 设置标题和链接
            if ([_delegate respondsToSelector:@selector(webPage:didUpdateTitle:)])
                [_delegate webPage:self didUpdateTitle:[self title]];
            
            if ([_delegate respondsToSelector:@selector(webPage:didUpdateLink:)])
                [_delegate webPage:self didUpdateLink:[self link]];
        }
    }

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 自定义长按选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    // 注入 JS（修改打开链接方式）
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"js.bundle/handle.js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    [webView stringByEvaluatingJavaScriptFromString:@"MyIPhoneApp_Init();"];
    
    // 设置有/无图
//    if ([AppSetting shareAppSetting].noImageMode) {
//        [webView stringByEvaluatingJavaScriptFromString:@"JSHandleHideImage();"];
//    }
//    else {
//        [webView stringByEvaluatingJavaScriptFromString:@"JSHandleShowImage();"];
//    }
    
    NSString *link = webView.link;
    if ([link hasPrefix:@"http://"]||[link hasPrefix:@"https://"]) {
        _link = link;
    }
    
    // 设置字体大小
//    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%0.2f%%'", [AppSetting shareAppSetting].fontScale*100];
//    [webView stringByEvaluatingJavaScriptFromString:js];
    
    // 设置标题和链接
    if ([_delegate respondsToSelector:@selector(webPage:didUpdateTitle:)])
        [_delegate webPage:self didUpdateTitle:[self title]];
    
    if ([_delegate respondsToSelector:@selector(webPage:didUpdateLink:)])
        [_delegate webPage:self didUpdateLink:[self link]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    switch (error.code) {
        case NSURLErrorTimedOut:
        case NSURLErrorCannotFindHost:
        case NSURLErrorFileDoesNotExist:
        case NSURLErrorNotConnectedToInternet:
            //        case 101:
            //        case 102:
        case 306:
        {
            // TODO: 这部分有待优化 ***
            NSString *htmlError = [NSString stringWithContentsOfURL:[[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"html.bundle/koto_error.html"] encoding:NSUTF8StringEncoding error:nil];
            htmlError = [htmlError stringByReplacingOccurrencesOfString:@"@{code}" withString:[@(error.code) stringValue]];
            htmlError = [htmlError stringByReplacingOccurrencesOfString:@"@{title}" withString:error.localizedDescription];
            htmlError = [htmlError stringByReplacingOccurrencesOfString:@"@{error}" withString:[error description]];
            [webView loadHTMLString:htmlError baseURL:[[NSBundle mainBundle] bundleURL]];
            [self updateProgress:1];
        }break;
        default:
            break;
    }
}

#pragma mark - public methods

- (void)load:(NSString *)link
{
    if (_isFindInPageMode) return;
    
    _linkOrigin = link;
    _link = link;
    if ([_delegate respondsToSelector:@selector(webPage:didUpdateLink:)])
        [_delegate webPage:self didUpdateLink:[self link]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:link]
                                           cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                       timeoutInterval:30]];
}

/**
 *  重新加载 网页 （*** 这是函数超重要）
 
 判断是否 有快照
 有：网页强制加载原来的链接地址
 无：判断是否是标准 href (带有 http:// 或 https:// 的 _link)
 是：
 否：
 */
- (void)reload
{
    if (_isFindInPageMode) return;
    
    if (_link) {
        if ([_webView title].length==0 || ![_webView.link isEqualToString:_link]) {
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_link]
                                                   cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                               timeoutInterval:30]];
        }
        else {
            [_webView reload];
        }
    }
}

- (void)stop
{
    [_webView stopLoading];
    
    // TODO: 超重要
    [self updateProgress:1];
}

- (void)goBack
{
    [_webView goBack];
}

- (void)goForward
{
    [_webView goForward];
}

/**
 *  显示加载封面
 *
 *  @param viewCover 封面视图
 *  @param viewLogo logo视图
 */
- (void)showLoadingCover:(UIView *)viewCover viewLogo:(UIView *)viewLogo;
{
    if (_viewLogo) {
        [_viewLogo.layer removeAllAnimations];
        [_viewLogo removeFromSuperview];
        _viewLogo = nil;
    }
    
    if (_viewCover) {
        [_viewCover removeFromSuperview];
        _viewCover = nil;
    }
    
    viewCover.frame = self.bounds;
    viewCover.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self insertSubview:viewCover belowSubview:_viewProgress];
    _viewCover = viewCover;
    
    self.userInteractionEnabled = NO;
    if (viewLogo) {
        viewLogo.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        viewLogo.center = CGPointMake(viewCover.width/2, viewCover.height/2);
        [viewCover addSubview:viewLogo];
        _viewLogo = viewLogo;
        
        [self startCoverLogoAnimation];
    }
}

- (void)startCoverLogoAnimation
{
    if (_viewLogo) {
        [_viewLogo.layer removeAllAnimations];
        
        _viewLogo.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        _viewLogo.center = CGPointMake(_viewCover.width/2, _viewCover.height/2);
        [_viewCover addSubview:_viewLogo];
        
        CABasicAnimation *animScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animScale.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
        animScale.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        
        CABasicAnimation *animOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animOpacity.fromValue = @(0.2);
        animOpacity.toValue = @(1);
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = @[animScale, animOpacity];
        
        animGroup.autoreverses = YES;
        animGroup.duration = 0.5;
        animGroup.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.8 :0.1 :0.95 :0.95];
        animGroup.repeatCount = MAXFLOAT;
        [_viewLogo.layer addAnimation:animGroup forKey:@"group"];
    }
}

- (void)hideLoadingCover
{
    // 加载完成，隐藏加载封面
    if (_viewCover) {
        [UIView animateWithDuration:0.5 animations:^{
            _viewCover.alpha = 0;
        } completion:^(BOOL finished) {
            [_viewLogo.layer removeAllAnimations];
            [_viewLogo removeFromSuperview];
            _viewLogo = nil;
            
            [_viewCover removeFromSuperview];
            _viewCover = nil;
            
        }];
        self.userInteractionEnabled = YES;
    }
}

/**
 *  开始页内查找模式
 */
- (void)beginFindInPage
{
    _isFindInPageMode = YES;
    
    NSString *resPath = [[NSBundle mainBundle] resourcePath];
    static NSString *jsQuery = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsQuery = [NSString stringWithContentsOfFile:[resPath stringByAppendingPathComponent:@"js.bundle/js_plugins.js"] encoding:NSUTF8StringEncoding error:nil];
        
        jsQuery = [NSString stringWithFormat:@"var highlightPlugin = document.getElementById('js_plugins'); \
                   if (highlightPlugin == undefined) { \
                   document.body.innerHTML += '<div id=\"js_plugins\"> \
                   <style type=\"text/css\"> \
                   .utaHighlight { background-color:#0000FF; color:#FFFFFF;} \
                   .selectSpan { background-color:#FF0000; color:#FFFFFF; font-weight:bold; font-size:150%%} \
                   </style> \
                   </div>'; \
                   %@ \
                   }", jsQuery];
    });
    
    [_webView stringByEvaluatingJavaScriptFromString:jsQuery];
}

/**
 *  结束页内查找
 */
- (void)endFindInPage
{
    _numberOfKeyword = 0;
    _indexOfKeyrowd = 0;
    _isFindInPageMode = NO;
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"jQuery('body').removeHighlight();"]];
}

/**
 *  查找关键字
 *
 *  @param keyword 关键字
 *
 *  @return NSInteger 查找到的总数量
 */
- (NSInteger)findInPageWithKeyword:(NSString *)keyword
{
    if (!_isFindInPageMode) return 0;
    
    _numberOfKeyword = 0;
    _indexOfKeyrowd = 0;
    
    // 清除上次的高亮并设置当前关键字高亮
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"jQuery('body').removeHighlight().utaHighlight('%@');", keyword]];
    
    // 获取关键字数量
    NSString *total = [_webView stringByEvaluatingJavaScriptFromString:@"jQuery('.utaHighlight').length"];
    _numberOfKeyword = [total integerValue];
    
    // 默认滚动到第一个关键字
    if (_numberOfKeyword>0) {
        [self scrollToKeywordIndex:0];
    }
    
    return _numberOfKeyword;
}

/**
 *  滚动到 第几个关键字
 *
 *  @param index 索引
 */
- (void)scrollToKeywordIndex:(NSInteger)index
{
    _indexOfKeyrowd = index;
    
    NSString *js = [NSString stringWithFormat:@"scrollToFindIdx(%ld);", (long)_indexOfKeyrowd];
    CGFloat offset = [[_webView stringByEvaluatingJavaScriptFromString:js] floatValue];
    offset = MAX(0, offset+40-_webView.height);
    
    CGFloat contentHeight = _webView.scrollView.contentSize.height;
    offset = MIN(offset, contentHeight-_webView.scrollView.bounds.size.height);
    [_webView.scrollView setContentOffset:CGPointMake(0, offset) animated:YES];
}

- (void)scrollToPrevKeyword
{
    if (!_isFindInPageMode || 0==_indexOfKeyrowd) return;
    
    [self scrollToKeywordIndex:--_indexOfKeyrowd];
}

- (void)scrollToNextKeyword
{
    if (!_isFindInPageMode || (_numberOfKeyword-1)<=_indexOfKeyrowd) return;
    
    [self scrollToKeywordIndex:++_indexOfKeyrowd];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    _DEBUG_LOG(@"%s  %@", __FUNCTION__, [gestureRecognizer class]);
//    return NO;
//}

@end

