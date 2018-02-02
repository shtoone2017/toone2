//
//  YS_WebViewController.m
//  toone
//
//  Created by 景晓峰 on 2018/2/2.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_WebViewController.h"

@interface YS_WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation YS_WebViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlStr;
    if (_type == YS_WebTypeBS)
    {
        urlStr = @"http://192.168.1.166:8080/rscs_test/TotalServlet?KEY=GRIDS&roadId=f9a816c15f7aa4ca015f7cbf18aa004d";
    }
    else if(_type == YS_WebTypeYSD)
    {
        urlStr = @"http://192.168.1.166:8080/rscs_test/TotalServlet?KEY=YASHIDU&roadId=f9a816c15f7aa4ca015f7cbf18aa004d";
    }
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"loading..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
