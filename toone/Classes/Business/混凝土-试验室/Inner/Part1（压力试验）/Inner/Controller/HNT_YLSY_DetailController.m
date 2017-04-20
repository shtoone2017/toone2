//
//  HNT_YLSY_DetailController.m
//  toone
//
//  Created by 十国 on 16/12/6.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_YLSY_DetailController.h"
#import "HNT_YLSY_DetailModel.h"
#import "LineChart1ViewController.h"
#import "AxisModel.h"

#import "HNT_ChuZhi_Controller.h"
@interface HNT_YLSY_DetailController ()<UIScrollViewDelegate,UITextFieldDelegate>
//1.压力试验
@property (weak, nonatomic) IBOutlet UILabel *SYRQ_Label;
@property (weak, nonatomic) IBOutlet UILabel *shebeiname_Label;
@property (weak, nonatomic) IBOutlet UILabel *GCMC_Label;
@property (weak, nonatomic) IBOutlet UILabel *SGBW_Label;
@property (weak, nonatomic) IBOutlet UILabel *testName_Label;//试验类型
@property (weak, nonatomic) IBOutlet UILabel *SJQD_Label;
@property (weak, nonatomic) IBOutlet UILabel *SJCC_Label;
@property (weak, nonatomic) IBOutlet UILabel *LQ_Label;
@property (weak, nonatomic) IBOutlet UILabel *QDDBZ_Label;
//2.力值曲线
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIView *redline;
@property (weak, nonatomic) IBOutlet UIScrollView *chart_sc;

- (IBAction)titleButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLine_x;
@property (weak, nonatomic) IBOutlet UILabel *KYLZ_Label;
@property (weak, nonatomic) IBOutlet UILabel *KYQD_Label;
//3.0 处置原因
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *big_sc_containerHeight;
@property (weak, nonatomic) IBOutlet UIView *containerView3;
@property (weak, nonatomic) IBOutlet UIScrollView *big_sc;
/******************************/

@property (nonatomic,strong) HNT_YLSY_DetailModel * model;


@end

@implementation HNT_YLSY_DetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self loadData];
}

-(void)dealloc{
    FuncLog;
}
-(void)loadUI{
    self.chart_sc.contentSize = CGSizeMake(Screen_w*3, 360);
    switch ([self.tableViewSigner integerValue]) {
        case 1:
        case 4:
        case 6:{
            break;
        }
        case 2:
        case 3:
        case 5:{
            self.big_sc_containerHeight.constant = 980-150-10;
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
    
    
    NSString * urlString = [NSString stringWithFormat:hntkangyaDetail_1,self.SYJID];
    __weak __typeof(self)  weakSelf = self;
  
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:nil success:^(id json) {
        if ([json[@"success"] boolValue]) {
            if ([json[@"data"] isKindOfClass:[NSDictionary class]]) {
                HNT_YLSY_DetailModel * model = [HNT_YLSY_DetailModel modelWithDict:json[@"data"]];
                weakSelf.model = model;
                //赋值
                weakSelf.SYRQ_Label.text = model.SYRQ;
                weakSelf.shebeiname_Label.text = model.shebeiname;
                weakSelf.GCMC_Label.text = model.GCMC;
                weakSelf.SGBW_Label.text = model.SGBW;
                weakSelf.testName_Label.text = model.testName;
                weakSelf.SJQD_Label.text = model.SJQD;
                weakSelf.SJCC_Label.text = model.SJCC;
                weakSelf.LQ_Label.text = model.LQ;
                weakSelf.QDDBZ_Label.text = model.QDDBZ;
                weakSelf.KYLZ_Label.text = [model.KYLZ componentsSeparatedByString:@"&"].firstObject;
                weakSelf.KYQD_Label.text = [model.KYQD componentsSeparatedByString:@"&"].firstObject;
                
//                weakSelf.txf.text = model.chuli;
                
                //
                switch ([weakSelf.tableViewSigner integerValue]) {
                    case 1:
                    case 4:
                    case 6:{
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
                            [chuZhi_btn setTitle:@"尚未处置，点击这里进入处置界面..." forState:UIControlStateNormal];
                            chuZhi_btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                            [weakSelf.containerView3 addSubview:chuZhi_btn];
                            [chuZhi_btn addTarget:self action:@selector(goto_chuzhi) forControlEvents:UIControlEventTouchUpInside];
                        }
                        break;
                    }
                    default:
                        break;
                }
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

                }
                
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
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button1 .titleLabel.font = [UIFont systemFontOfSize:12.0f];
    self.button2 .titleLabel.font = [UIFont systemFontOfSize:12.0f];
    self.button3 .titleLabel.font = [UIFont systemFontOfSize:12.0f];

    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.redLine_x.constant = (sender.tag-1)*70;
        [self.redline.superview layoutIfNeeded];
        
        self.chart_sc.contentOffset = CGPointMake(self.view.bounds.size.width*(sender.tag-1), 0);
    }completion:^(BOOL finished) {
        self.KYLZ_Label.text = [self.model.KYLZ componentsSeparatedByString:@"&"][sender.tag-1];
        self.KYQD_Label.text = [self.model.KYQD componentsSeparatedByString:@"&"][sender.tag-1];
    }];
}
#pragma mark - 进入处置界面
-(void)goto_chuzhi{
    [self performSegueWithIdentifier:@"HNT_YLSY_DetailController_chuzhi" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[HNT_ChuZhi_Controller class]]) {
        HNT_ChuZhi_Controller * controller = vc;
        controller.SYJID = self.SYJID;
    }
}
@end
