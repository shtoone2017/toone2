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

#import "HNT_ChuZhi_Controller.h"
@interface HNT_WNSY_DetailController ()<UITextFieldDelegate,UIScrollViewDelegate>
//1.万能试验
@property (weak, nonatomic) IBOutlet UILabel * SYRQ_Label;//日期
//@property (weak, nonatomic) IBOutlet UILabel * shebeiname_Label;//设备
//@property (weak, nonatomic) IBOutlet UILabel * GCMC_Label;//工程名称
@property (weak, nonatomic) IBOutlet UILabel * SGBW_Label;//施工部位
//@property (weak, nonatomic) IBOutlet UILabel * testName_Label;//试验类型
@property (weak, nonatomic) IBOutlet UILabel * SJBH_Label;//试件编号
@property (weak, nonatomic) IBOutlet UILabel * GGZL_Label;//公称直径
//@property (weak, nonatomic) IBOutlet UILabel * PZBM_Label;//品种

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
//@property (weak, nonatomic) IBOutlet UILabel * SCL_Label;//伸长率

//3.0 处置原因
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *big_sc_containerHeight;
@property (weak, nonatomic) IBOutlet UIView *containerView3;
@property (weak, nonatomic) IBOutlet UIScrollView *big_sc;


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
}
-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
    self.chart_sc.contentSize = CGSizeMake(Screen_w*2, 360);
    switch ([self.tableViewSigner integerValue]) {
        case 1:
        case 3:{
            break;
        }
        case 4:{
            break;
        }
        case 2:{
            self.big_sc_containerHeight.constant = 950-150-10;
            [self.containerView3 removeFromSuperview];
            break;
        }
        default:
            break;
    }
}
-(void)loadData{
    //添加指示器
    [Tools showActivityToView:self.view];
    
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
//                weakSelf.shebeiname_Label.text = model.shebeiname;//设备
//                weakSelf.GCMC_Label.text = model.GCMC;//工程名称
                weakSelf.SGBW_Label.text = model.SGBW;//施工部位
//                weakSelf.testName_Label.text = model.testName;//试验类型
                weakSelf.SJBH_Label.text = model.SJBH;//试件编号
                weakSelf.GGZL_Label.text = model.GCZJ;//公称直径
//                weakSelf.PZBM_Label.text = model.PZBM;//品种
                
                weakSelf.LZ_Label.text = [model.LZ componentsSeparatedByString:@"&"].firstObject;//最大力值
                weakSelf.LZQD_Label.text = [model.LZQD componentsSeparatedByString:@"&"].firstObject;//抗拉强度
                weakSelf.QFLZ_Label.text = [model.QFLZ componentsSeparatedByString:@"&"].firstObject;//屈服力值
                weakSelf.QFQD_Label.text = [model.QFQD componentsSeparatedByString:@"&"].firstObject;//屈服强度
//                weakSelf.SCL_Label.text = [model.SCL componentsSeparatedByString:@"&"].firstObject;//伸长率
                
                
//                weakSelf.txf.text = model.chuli;
                switch ([weakSelf.tableViewSigner integerValue]) {
                    case 1:
                    case 4:
                    case 3:{
                        if (model.chuli.length >0) {
                            NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
                            CGSize maxSize = CGSizeMake(Screen_w-20, MAXFLOAT);
                            CGSize size = [model.chuli boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
                            CGFloat height = size.height;
                            if (height > 100) {
                                height = 100;
                            }
                            UILabel * chuZhi_label = [[UILabel alloc] init];
                            chuZhi_label.frame = CGRectMake(10, 40, Screen_w-20, height);
                            chuZhi_label.font = [UIFont systemFontOfSize:12.0];
                            chuZhi_label.text = model.chuli;
                            chuZhi_label.numberOfLines=0;
                            [weakSelf.containerView3 addSubview:chuZhi_label];
                        }
                        else{
                            UIButton * chuZhi_btn = [UIButton buttonWithType:UIButtonTypeSystem];
                            chuZhi_btn.frame = CGRectMake(0, 40, Screen_w, 30);
                            [chuZhi_btn setTitle:@"尚未处置，点击这里开始处置..." forState:UIControlStateNormal];
                            chuZhi_btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                            [weakSelf.containerView3 addSubview:chuZhi_btn];
                            [chuZhi_btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
                        }
                        break;
                    }
                    default:
                        break;
                }
          /*      //处理数据
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
                    if (arrY.count >= 1) {
                        
                        for (int j; j<arrY.count; j++) {
                            int value = [(NSString*)arrY[i][j] intValue];
                            if (value>y_Max) {
                                y_Max = value;
                            }
                            if (value<y_Min) {
                                y_Min = value;
                            }
                        }
                    }
                    
                    
                    NSDictionary * dict = @{@"y_Max":FormatInt(y_Max),
                                            @"y_Min":FormatInt(y_Min),
                                            @"datas":totalArray[i],
                                            };
                    if ([totalArray[i] count] == 0) {
                        [Tools tip:@"没有数据"];
                        //移除指示器
                        [Tools removeActivity];
                        return ;
                    }
                    LineChart1ViewController * vc = [[LineChart1ViewController alloc] initWithDict:dict];
                    vc.view.frame = CGRectMake(weakSelf.view.bounds.size.width*i, 0, weakSelf.view.bounds.size.width, 360);
                    [weakSelf addChildViewController:vc];
                    [weakSelf.chart_sc addSubview:vc.view];
                    
                }*/
                //移除指示器
                [Tools removeActivity];
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
//        self.SCL_Label.text = [self.model.SCL componentsSeparatedByString:@"&"][sender.tag-1];//伸长率
    }];
}
#pragma mark - 进入处置界面
-(void)goto_chuzhi{
    [self performSegueWithIdentifier:@"HNT_WNSY_DetailController_chuzhi" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_ChuZhi_Controller class]]) {
        HNT_ChuZhi_Controller * controller = vc;
        controller.SYJID = self.SYJID;
    }
}
@end
