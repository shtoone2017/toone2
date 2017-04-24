//
//  ExcessiveViewController.m
//  toone
//
//  Created by shtoone on 16/12/20.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ExcessiveViewController.h"
#import "XFSegementView.h"
#import "PrimaryExcessiveTableConller.h"
#import "MiddleExcessiveTableContller.h"
#import "SeniorExcessiveTableConller.h"
#import "TotalTableController.h"
#import "LQ_BHZ_SB_Controller.h"
#import "MyTableViewController.h"

@interface ExcessiveViewController ()<TouchLabelDelegate>

@property (nonatomic, strong) XFSegementView *segementView;
@property (nonatomic, strong) MyTableViewController *tableCont;
@property (nonatomic, copy) NSString *shebStr;
@property (nonatomic, copy)  NSString *urlString;

@end
@implementation ExcessiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    初始化分页
    self.tableCont = [[PrimaryExcessiveTableConller alloc] init];
    if ([self.tableCont isKindOfClass:[PrimaryExcessiveTableConller class]]) {
        
        [self addChildViewController:self.tableCont];
        [self.view addSubview:self.tableCont.view];
    }
    
    [self setSegement];
}

#pragma mark - 设置分页
-(void)setSegement {
    self.segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, 35)];
    self.segementView.backgroundColor = [UIColor snowColor];
    
    self.segementView.titleArray = @[@"初级",@"中级",@"高级",@"总"];
    
    self.segementView.touchDelegate = self;
    
    [self.view addSubview:self.segementView];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_w-40, 0, 40, 40)];
    [searchButton setImage:[UIImage imageNamed:@"black_SX"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(clickSearchBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.segementView addSubview:searchButton];

}

#pragma mark - 查询
-(void)clickSearchBut:(UIButton *)sender {
    sender.enabled = NO;
    //1.
    UIButton * backView = [UIButton buttonWithType:UIButtonTypeSystem];
    backView.frame = CGRectMake(0, 64+36, Screen_w, Screen_h  -64-36);
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    backView.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 150ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
        backView.hidden = NO;
    });
    [self.view addSubview:backView];
    
    //2.
    Exp8View * e = [[Exp8View alloc] init];
    e.frame = CGRectMake(0, 64+36, Screen_w, 254);
    __weak __typeof(self)  weakSelf = self;
    e.expBlock = ^(ExpButtonType type,id obj1,id obj2, int buttonTag){
        if (type == ExpButtonTypeCancel) {
            sender.enabled = YES;
            [backView removeFromSuperview];
        }
        if (type == ExpButtonTypeOk) {//查询
            sender.enabled = YES;
            [backView removeFromSuperview];
            //
            weakSelf.startTime = (NSString*)obj1;
            weakSelf.endTime = (NSString*)obj2;
            //重新切换titleButton ， 搜索页码应该回归第一页码
//            weakSelf.pageNo = @"1";
//            weakSelf.chuzhileixing = @"";
            switch (buttonTag) {
                case 10:
                    weakSelf.urlString = [weakSelf loadUI:@""];
                    break;
                case 20://未处置
                    weakSelf.urlString = [weakSelf loadUI:@"0"];
                        break;
                case 30:
                case 40://已处置
                    weakSelf.urlString = [weakSelf loadUI:@"1"];
                    break;
                case 50:
                    break;
                case 60:
                    break;
                default:
                    weakSelf.urlString = [weakSelf loadUI:@""];
                    break;
            }
            
            
            [weakSelf.tableCont reloadData:weakSelf.urlString];
        }
        if (type == ExpButtonTypeStartTimeButton || type == ExpButtonTypeEndTimeButton) {
            UIButton * btn = (UIButton*)obj1;
            [weakSelf calendarWithTimeString:btn.currentTitle obj:btn];
        }
        
        if (type == ExpButtonTypeChoiceSBButton) {//选择设备
            UIButton * btn = (UIButton*)obj1;
            LQ_BHZ_SB_Controller *sbVc = [[LQ_BHZ_SB_Controller alloc] init];
            [self.navigationController pushViewController:sbVc animated:YES];
            
            sbVc.callBlock = ^(NSString *banhezhanminchen,NSString *gprsbianhao){
                [btn setTitle:banhezhanminchen forState:UIControlStateNormal];
                weakSelf.shebStr = gprsbianhao;
            };

        }
    };
    [self.view addSubview:e];
}



#pragma mark - 分页跳转
- (void)touchLabelWithIndex:(NSInteger)index {
    if (index == 0) { //初级
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[PrimaryExcessiveTableConller alloc] init];
        
        PrimaryExcessiveTableConller *primaryVc =(PrimaryExcessiveTableConller *) self.tableCont;
        
        [self addChildViewController:primaryVc];
        [self.view addSubview:primaryVc.view];
        [self.view addSubview:self.segementView];

    }else if (index == 1) { //中级
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[MiddleExcessiveTableContller alloc] init];
        
        MiddleExcessiveTableContller *middleVc =(MiddleExcessiveTableContller *) self.tableCont;
        
        [self addChildViewController:middleVc];
        [self.view addSubview:middleVc.view];
        [self.view addSubview:self.segementView];
        
    }else if (index == 2) { //高级
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[SeniorExcessiveTableConller alloc] init];
        
        SeniorExcessiveTableConller *seniorVc =(SeniorExcessiveTableConller *) self.tableCont;
        
        [self addChildViewController:seniorVc];
        [self.view addSubview:seniorVc.view];
        [self.view addSubview:self.segementView];
        
    }else if (index == 3) { //总
        [self.tableCont removeFromParentViewController];
        [self.tableCont.view removeFromSuperview];
        
        self.tableCont = [[TotalTableController alloc] init];
        
        TotalTableController *totalVc =(TotalTableController *) self.tableCont;
        
        [self addChildViewController:totalVc];
        [self.view addSubview:totalVc.view];
        [self.view addSubview:self.segementView];
        
    }
    
}

-(NSString *)loadUI:(NSString *)leix {
    __weak __typeof(self)  weakSelf = self;
    NSString * userGroupId = [UserDefaultsSetting shareSetting].departId;
    //判断等级
    if ([weakSelf.tableCont isKindOfClass:[PrimaryExcessiveTableConller class]]) {
        [UserDefaultsSetting shareSetting].dengji = [NSNumber numberWithInt:1];
    }else if ([weakSelf.tableCont isKindOfClass:[MiddleExcessiveTableContller class]]) {
        [UserDefaultsSetting shareSetting].dengji = [NSNumber numberWithInt:2];
    }else if ([weakSelf.tableCont isKindOfClass:[SeniorExcessiveTableConller class]]) {
        [UserDefaultsSetting shareSetting].dengji = [NSNumber numberWithInt:3];
    }else if ([weakSelf.tableCont isKindOfClass:[TotalTableController class]]) {
        [UserDefaultsSetting shareSetting].dengji = [NSNumber numberWithInt:0];
    }
    NSString *shebStr = @"";
    if (weakSelf.shebStr) {
        shebStr = weakSelf.shebStr;
    }
    NSString *pageNo = @"1";
    NSString *startTime = [TimeTools timeStampWithTimeString:weakSelf.startTime];
    NSString *endTime = [TimeTools timeStampWithTimeString:weakSelf.endTime];
    NSString *urlString = [NSString stringWithFormat:LQExcessive,[UserDefaultsSetting shareSetting].dengji,leix,pageNo,shebStr,userGroupId,startTime,endTime];
    
    return urlString;
}

@end
