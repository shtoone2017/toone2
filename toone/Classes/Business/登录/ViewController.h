//
//  ViewController.h
//  Demo-01
//
//  Created by 成研 on 16/11/8.
//  Copyright © 2016年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import<WebKit/WebKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *wkView;
@property (strong, nonatomic) UIProgressView *progressView;


@end

