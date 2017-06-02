//
//  WebViewController.h
//  toone
//
//  Created by 上海同望 on 2017/6/2.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import<WebKit/WebKit.h>

@interface WebViewController : MyViewController<UIWebViewDelegate,WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *wkView;
@property (strong, nonatomic) UIProgressView *progressView;


@end
