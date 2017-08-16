//
//  GCB_JCB_Controller.m
//  toone
//
//  Created by 上海同望 on 2017/8/16.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCB_Controller.h"

@interface GCB_JCB_Controller ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ContainerWidth;
@property (weak, nonatomic) IBOutlet UIScrollView *title_sc                 ;//标题scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *text_sc                  ;//正文scrollView
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *button2                      ;//进场
@property (weak, nonatomic) IBOutlet UIButton *button3                      ;//

@property (weak, nonatomic) IBOutlet UITableView *tableView2                ;//进场
@property (weak, nonatomic) IBOutlet UITableView *tableView3;


@end
@implementation GCB_JCB_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
}





@end
