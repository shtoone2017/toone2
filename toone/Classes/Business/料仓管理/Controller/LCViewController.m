//
//  LCViewController.m
//  toone
//
//  Created by 上海同望 on 2017/8/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LCViewController.h"

@interface LCViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)searchButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;

@end
@implementation LCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}
-(void)loadUI{
        self.containerView.backgroundColor = BLUECOLOR;
    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
    btn.tag  = 2;
    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn3 = [UIButton img_20WithName:@"sg_person"];
    btn3.tag  = 3;
    [btn3 addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    
}
- (IBAction)searchButtonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            
            break;
        case 3:
            [super pan];
            break;
            
        default:
            break;
    }
}



@end
