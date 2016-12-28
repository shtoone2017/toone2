//
//  HNT_WNSY_DetailController.m
//  toone
//
//  Created by 十国 on 16/12/7.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_WNSY_DetailController.h"
#import "HNT_WNSY_DetailModel.h"
#import "LineChart1ViewController.h"
#import "AxisModel.h"
@interface HNT_WNSY_DetailController ()<UITextFieldDelegate,UIScrollViewDelegate>
//1.万能试验
@property (weak, nonatomic) IBOutlet UILabel * SYRQ_Label;//日期
@property (weak, nonatomic) IBOutlet UILabel * shebeiname_Label;//设备
@property (weak, nonatomic) IBOutlet UILabel * GCMC_Label;//工程名称
@property (weak, nonatomic) IBOutlet UILabel * SGBW_Label;//施工部位
@property (weak, nonatomic) IBOutlet UILabel * testName_Label;//试验类型
@property (weak, nonatomic) IBOutlet UILabel * SJBH_Label;//试件编号
@property (weak, nonatomic) IBOutlet UILabel * GGZL_Label;//公称直径
@property (weak, nonatomic) IBOutlet UILabel * PZBM_Label;//品种

//2.力值曲线
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIView *redline;
@property (weak, nonatomic) IBOutlet UIScrollView *chart_sc;

- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
@property (weak, nonatomic) IBOutlet UILabel * LZ_Label;//最大力值
@property (weak, nonatomic) IBOutlet UILabel * LZQD_Label;//抗拉强度
@property (weak, nonatomic) IBOutlet UILabel * QFLZ_Label;//屈服力值
@property (weak, nonatomic) IBOutlet UILabel * QFQD_Label;//屈服强度
@property (weak, nonatomic) IBOutlet UILabel * SCL_Label;//伸长率

//3.0 处置原因
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *big_sc_containerHeight;
@property (weak, nonatomic) IBOutlet UIView *containerView3;
@property (weak, nonatomic) IBOutlet UIScrollView *big_sc;
@property (weak, nonatomic) IBOutlet UITextField *txf;
- (IBAction)submitAndCancelButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

/******************************/

@property (nonatomic,strong) HNT_WNSY_DetailModel * model;
//指示器MB用
@property (atomic, assign) BOOL canceled;
@end

@implementation HNT_WNSY_DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadData];
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification  object:nil];
}
- (void)keyboardWillChange:(NSNotification  *)notification{
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    //动画时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height);
    } completion:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    FuncLog;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.big_sc) {
        [self.txf resignFirstResponder];
    }
}
-(void)loadUI{
    self.chart_sc.contentSize = CGSizeMake(Screen_w*2, 360);
    switch ([self.tableViewSigner integerValue]) {
        case 1:
        case 3:{
            break;
        }
        case 2:
        case 4:{
            self.big_sc_containerHeight.constant = 1030-150-10;
            [self.containerView3 removeFromSuperview];
            break;
        }
        default:
            break;
    }
}
-(void)loadData{
    NSString * urlString = [NSString stringWithFormat:gangjinDetail_1,self.SYJID];
    __weak __typeof(self)  weakSelf = self;
//    NSLog(@"urlString = %@",urlString);
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSDictionary class]]) {
                HNT_WNSY_DetailModel * model = [HNT_WNSY_DetailModel modelWithDict:json[@"data"]];
                weakSelf.model = model;
                //赋值
                weakSelf.SYRQ_Label.text = model.SYRQ;//日期
                weakSelf.shebeiname_Label.text = model.shebeiname;//设备
                weakSelf.GCMC_Label.text = model.GCMC;//工程名称
                weakSelf.SGBW_Label.text = model.SGBW;//施工部位
                weakSelf.testName_Label.text = model.testName;//试验类型
                weakSelf.SJBH_Label.text = model.SJBH;//试件编号
                weakSelf.GGZL_Label.text = model.GGZL;//公称直径
                weakSelf.PZBM_Label.text = model.PZBM;//品种
                
                weakSelf.LZ_Label.text = [model.LZ componentsSeparatedByString:@"&"].firstObject;//最大力值
                weakSelf.LZQD_Label.text = [model.LZQD componentsSeparatedByString:@"&"].firstObject;//抗拉强度
                weakSelf.QFLZ_Label.text = [model.QFLZ componentsSeparatedByString:@"&"].firstObject;//屈服力值
                weakSelf.QFQD_Label.text = [model.QFQD componentsSeparatedByString:@"&"].firstObject;//屈服强度
                weakSelf.SCL_Label.text = [model.SCL componentsSeparatedByString:@"&"].firstObject;//伸长率
                
                
                weakSelf.txf.text = model.chuli;
                
                //处理数据
                NSArray * arrY = [model.f_LZ separatedWithFirstString:@"&" withSecondCharacter:@","];
                NSArray * arrX = [model.f_SJ separatedWithFirstString:@"&" withSecondCharacter:@","];
                
                NSMutableArray * totalArray = [NSMutableArray array];
                for (int i = 0; i<arrX.count; ++i) {
                    NSMutableArray * subArray = [NSMutableArray array];
                    for (int j = 0 ; j<[arrX[i] count]; ++j) {
                        AxisModel * model = [AxisModel new];
                        model.x = [arrX[i][j] doubleValue];
                        model.y = [arrY[i][j] doubleValue];
                        [subArray addObject:model];
                    }
                    [totalArray addObject:subArray];
                }
                for (int s = 0; s<totalArray.count; s++) {
                    for (int i = 1; i<[totalArray[s] count]; i++) {
                        for (int j = 0; j<[totalArray[s] count]-i; j++) {
                            if ([(AxisModel*)totalArray[s][j] x] >[(AxisModel*)totalArray[s][j+1] x]) {
                                AxisModel* temp = totalArray[s][j];
                                totalArray[s][j] = totalArray[s][j+1];
                                totalArray[s][j+1] = temp;
                            }
                        }
                    }
                }
                
                //加载曲线图
                for (int i = 0 ; i<totalArray.count; i++) {
                    //1.取出最大值和最小值
                    int y_Min = CGFLOAT_MAX;
                    int y_Max = CGFLOAT_MIN;
                    for (int j; j<arrY.count; j++) {
                        int value = [(NSString*)arrY[i][j] intValue];
                        if (value>y_Max) {
                            y_Max = value;
                        }
                        if (value<y_Min) {
                            y_Min = value;
                        }
                    }
                    
                    NSDictionary * dict = @{@"y_Max":FormatInt(y_Max),
                                            @"y_Min":FormatInt(y_Min),
                                            @"datas":totalArray[i],
                                            };
                    LineChart1ViewController * vc = [[LineChart1ViewController alloc] initWithDict:dict];
                    vc.view.frame = CGRectMake(weakSelf.view.bounds.size.width*i, 0, weakSelf.view.bounds.size.width, 360);
                    [weakSelf addChildViewController:vc];
                    [weakSelf.chart_sc addSubview:vc.view];
                    
                }
            }
        }
    } failure:^(NSError *error) {
    }];
    
}

- (IBAction)titleButtonClick:(UIButton *)sender {
    [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:12.0f];
    self.button2 .titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.redLine_x.constant = (sender.tag-1)*70;
        [self.redline.superview layoutIfNeeded];
        
        self.chart_sc.contentOffset = CGPointMake(self.view.bounds.size.width*(sender.tag-1), 0);
    }completion:^(BOOL finished) {
        self.LZ_Label.text = [self.model.LZ componentsSeparatedByString:@"&"][sender.tag-1];//最大力值
        self.LZQD_Label.text = [self.model.LZQD componentsSeparatedByString:@"&"][sender.tag-1];//抗拉强度
        self.QFLZ_Label.text = [self.model.QFLZ componentsSeparatedByString:@"&"][sender.tag-1];//屈服力值
        self.QFQD_Label.text = [self.model.QFQD componentsSeparatedByString:@"&"][sender.tag-1];//屈服强度
        self.SCL_Label.text = [self.model.SCL componentsSeparatedByString:@"&"][sender.tag-1];//伸长率
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self submitAndCancelButtonClick:self.submitButton];
    return YES;
}
- (IBAction)submitAndCancelButtonClick:(id)sender {
    [self.txf resignFirstResponder];
    if (sender == self.submitButton) {
        if (!self.txf.enabled) {
            return;
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        if (self.txf.text.length == 0) {
            hud.label.text = NSLocalizedString(@"您还没有输入处置原因", @"HUD cleanining up title");
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }
        
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
        
        NSString * urlString = hntkangyaPost;
        NSDictionary * dict = @{@"SYJID":self.SYJID,@"chaobiaoyuanyin":self.txf.text};
        __weak typeof(self) weakSelf = self;
        __weak UIButton * weakButton = sender;
        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dict success:^(id json) {
            if ([json[@"success"] boolValue]) {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    // Do something useful in the background and update the HUD periodically.
                    [self doSomeWorkWithProgress];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                        weakSelf.txf.enabled = NO;
                        weakButton.enabled = NO;
                    });
                });
            }
        } failure:nil];
    }
}
#pragma  mark - 给指示器添加进度状态
- (void)doSomeWorkWithProgress {
    self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f) {
        if (self.canceled) break;
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progress;
        });
        usleep(3000);
    }
}



@end
