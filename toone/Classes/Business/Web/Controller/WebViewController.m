//
//  WebViewController.m
//  toone
//
//  Created by 上海同望 on 2017/6/2.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIView *doneView;


@end
@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadWKView];
}

-(void)loadUI {
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
}
-(void)searchButtonClick:(UIButton*)sender {
    [super pan];
}

#pragma mark - webView
-(void)loadWKView{
    self.wkView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSString *urlString;
    NSString *name = [UserDefaultsSetting shareSetting].name;
    NSString *ssid = [UserDefaultsSetting shareSetting].ssid;
    if ([UserDefaultsSetting shareSetting].UUIDStr) {
        urlString = [NSString stringWithFormat:@"http://pingcebhz.r93535.com/DMSAPP/UI/index.aspx?token=%@&loginname=%@",ssid,name];
    }
    [self.wkView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    self.wkView.navigationDelegate = self;
    [self.view addSubview:self.wkView];
//    [[UIApplication sharedApplication].keyWindow addSubview:self.wkView];
    //侧滑返回上级
    [self.wkView setAllowsBackForwardNavigationGestures:true];
    [self.wkView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
// 记得取消监听
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.wkView removeObserver:self forKeyPath:@"estimatedProgress"];
    FuncLog;
}

- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 2)];
        self.progressView.tintColor = [UIColor greenColor];
        //        self.progressView.backgroundColor = [UIColor blackColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:self.progressView];
    }
    return _progressView;
}
#pragma mark - WKUIDelegate
//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
//跳转到其他的服务器
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

@end
