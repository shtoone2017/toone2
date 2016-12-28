//
//  WelcomeViewController.m
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)click:(UIButton *)sender;

@end

@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerWidth.constant = Screen_w*3;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        _pageControl.currentPage = 0;
    }
    if (scrollView.contentOffset.x == Screen_w) {
        _pageControl.currentPage = 1;
    }
    if (scrollView.contentOffset.x == Screen_w*2) {
        _pageControl.currentPage = 2;
    }
}
- (IBAction)click:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UserDefaultsSetting  * setting = [UserDefaultsSetting shareSetting] ;
        setting.enterApplication = YES;
        [setting saveToSandbox];
    });

    
    id vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [[UIApplication sharedApplication].keyWindow.layer addTransitionWithType:@"fromLeft"];
}
@end
