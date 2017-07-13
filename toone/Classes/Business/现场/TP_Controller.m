
//
//  TP_Controller.m
//  toone
//
//  Created by sg on 2017/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_Controller.h"
#import "TP_DW_Controller.h"
#import "MyNavigationController.h"
#import "LqNodeViewController.h"
#import "TP_CL_Controller.h"
#import "TP_TP_Controller.h"
#import "TP_NY_Controller.h"
#import "SW_ZZJG_Controller.h"
@interface TP_Controller ()
- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet BBFlashCtntLabel *departName_Label;
@property (weak, nonatomic) IBOutlet UIView *clView;//出料

@property (nonatomic,strong)  SW_ZZJG_Data * condition;
@end

@implementation TP_Controller
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((MyNavigationController*)self.navigationController).myColor = BLUECOLOR;
    _clView.hidden = YES;
//    
//    NSString * zjjg = FormatString(@"组织机构 : ", [UserDefaultsSetting shareSetting].departName);
//    self.departName_Label.text = FormatString(zjjg, @"\t\t\t\t\t\t\t\t\t\t");
//    self.departName_Label.textColor = [UIColor whiteColor];
//    self.departName_Label.font = [UIFont systemFontOfSize:12.0];
//    self.departName_Label.speed = BBFlashCtntSpeedSlow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.departName_Label.backgroundColor = BLUECOLOR;
//    UIButton * btn = [UIButton img_20WithName:@"ic_format_list_numbered_white_24dp"];
//    btn.tag  = 2;
//    [btn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    
}
-(void)searchButtonClick:(UIButton*)sender{
    LqNodeViewController  * c=[[LqNodeViewController alloc] init] ;
    [self.navigationController pushViewController:c animated:YES];
    NSNumber *number = [NSNumber numberWithInt:2];
    [UserDefaultsSetting shareSetting].funtype = number;
}


- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
            case 1:{
                //进入摊铺界面
                [self.navigationController pushViewController:[TP_TP_Controller new] animated:YES];
                break;
            
            case 2:{
                //进入碾压界面

                   [self.navigationController pushViewController:[TP_NY_Controller new] animated:YES];
                break;
            }
            case 3:{
                //进入出料界面
//                [self.navigationController pushViewController:[TP_CL_Controller new] animated:YES];
                
                break;
            }
            case 4:{
                //进入设备定位

                
                [self.navigationController pushViewController:[TP_DW_Controller new] animated:YES];
                
                break;
            }
        }
    }
}
@end
