//
//  HNT_CBCZ_Detail_ChuliCell.m
//  toone
//
//  Created by 十国 on 2016/12/19.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HNT_CBCZ_Detail_ChuliCell.h"
#import "HNT_CBCZ_Detail_HeadMsg.h"
@interface HNT_CBCZ_Detail_ChuliCell()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CalendarViewControllerDelegate>

@property (nonatomic,weak) IBOutlet UITextField  * chulifangshi ;//  处置：处理方式
@property (nonatomic,weak) IBOutlet UITextField  * chulijieguo ;//  处置：处理结果
@property (nonatomic,weak) IBOutlet UITextField  * chuliren ;//  处置：处理人
@property (nonatomic,weak) IBOutlet UIButton  * chulishijian ;//  处置：处理时间
@property (nonatomic,weak) IBOutlet UITextField  * wentiyuanyin ;//  处置：处置原因
@property (nonatomic,weak) IBOutlet UIButton  * filePath ;//  处置：
@property (nonatomic,weak) IBOutlet UIButton  * confirmdate ;//  审批：确认时间
@property (nonatomic,weak) IBOutlet UITextField  * jianliresult ;//  审批：监理结果
@property (nonatomic,weak) IBOutlet UITextField  * jianlishenpi ;//  审批：监理审批
@property (nonatomic,weak) IBOutlet UIButton  * shenpidate ;//  审批：审批时间
@property (nonatomic,weak) IBOutlet UITextField  * shenpiren ;//  审批：审批人
- (IBAction)choiceMethod:(UIButton *)sender;
- (IBAction)cancelClick:(UIButton *)sender;
- (IBAction)commitClick:(UIButton *)sender;
- (IBAction)choiceTimeClick:(UIButton *)sender;
@property (nonatomic,assign) BOOL chuZhiZhuangTai;
@property (nonatomic,assign) BOOL shenPiZhuangTai;

@property (nonatomic,strong) UITextField * txf;//当前响应的输入框
@property (nonatomic,strong) UIImage * filePathImage;

@end

@implementation HNT_CBCZ_Detail_ChuliCell


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
 
    [textField resignFirstResponder];
    return YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod
    self.filePath.layer.borderWidth = 1.0;
    self.filePath.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.filePath.layer.cornerRadius = 3.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setChuZhiZhuangTai:(BOOL)chuZhiZhuangTai{
    _chuZhiZhuangTai = chuZhiZhuangTai;
    self.chulifangshi.enabled = chuZhiZhuangTai;
    self.chulijieguo.enabled = chuZhiZhuangTai;
    self.chulishijian.enabled = chuZhiZhuangTai;
    self.wentiyuanyin.enabled = chuZhiZhuangTai;
    self.filePath.enabled = chuZhiZhuangTai;
}
-(void)setShenPiZhuangTai:(BOOL)shenPiZhuangTai{
    _shenPiZhuangTai = shenPiZhuangTai;
    self.confirmdate.enabled = shenPiZhuangTai;
    self.jianliresult.enabled = shenPiZhuangTai;
    self.jianlishenpi.enabled = shenPiZhuangTai;
    self.shenpidate.enabled = shenPiZhuangTai;
}
-(void)setChuli:(NSString *)chuli{
    _chuli = chuli;
    //权限控制：
    if(EqualToString(chuli, @"0")){
        self.chuZhiZhuangTai = YES;//未处置
    }else if(EqualToString(chuli, @"1")){
        self.chuZhiZhuangTai = NO;//已处置
    }else{
        self.chuZhiZhuangTai = NO;//已处置
    }
}
-(void)setShenhe:(NSString *)shenhe{
    _shenhe = shenhe;
    if(EqualToString(shenhe, @"2")){
        self.shenPiZhuangTai = YES;//未处置
    }else if(EqualToString(shenhe, @"3")){
        self.shenPiZhuangTai = NO;//已审批
    }else{
        self.shenPiZhuangTai = NO;//已审批
    }
}
-(void)setHeadMsg:(HNT_CBCZ_Detail_HeadMsg *)headMsg{
    _headMsg = headMsg;
    
    self.chulifangshi.text = headMsg.chulifangshi;//  处置：处理方式
    self.chulijieguo.text = headMsg.chulijieguo;//  处置：处理结果
    self.chuliren.text = headMsg.chuliren;//  处置：处理人
    if (headMsg.chuliren.length < 1) {
        self.chuliren.text = [UserDefaultsSetting shareSetting].userFullName;
    }
    
    if (headMsg.chulishijian) {
        [self.chulishijian setTitle:headMsg.chulishijian forState:UIControlStateNormal];
        self.chulishijian.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.chulishijian.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -15, 0);//  处置：处理时间
    }
   
    
    self.wentiyuanyin.text = headMsg.wentiyuanyin;//  处置：处置原因
    
//    @property (nonatomic,weak) IBOutlet UIButton  * filePath ;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString * urlString = FormatString(baseUrl, headMsg.filePath);
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        self.filePathImage = [UIImage imageWithData:data];
        
        if (self.filePathImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.filePath setBackgroundImage:self.filePathImage forState:UIControlStateNormal];
                [self.filePath setImage:nil forState:UIControlStateNormal];
            });
        }
    });

    
    if (headMsg.confirmdate) {
        [self.confirmdate setTitle:headMsg.confirmdate forState:UIControlStateNormal];
        self.confirmdate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.confirmdate.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -15, 0);//  审批：确认时间
    }
    
  
    
    self.jianliresult.text = headMsg.jianliresult;//  审批：监理结果
    self.jianlishenpi.text = headMsg.jianlishenpi;//  审批：监理审批

    
    if (headMsg.shenpidate) {
        [self.shenpidate setTitle:headMsg.shenpidate forState:UIControlStateNormal];
        self.shenpidate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.shenpidate.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -15, 0);//  审批：审批时间
    }
   
    
    self.shenpiren.text = headMsg.shenpiren;//  审批：审批人
    if (headMsg.shenpiren.length < 1) {
        self.shenpiren.text = [UserDefaultsSetting shareSetting].userFullName;
    }
}

- (IBAction)choiceMethod:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"打开一个图片源" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    // 图片选择器
    UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
    
    //设置代理
    imgPC.delegate = self;
    
    //允许编辑图片
    imgPC.allowsEditing = YES;
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [self.weakController presentViewController:imgPC animated:YES completion:nil];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.weakController presentViewController:imgPC animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self.weakController presentViewController:alertController animated:YES completion:nil];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    if (textField == self.chulifangshi) {
        self.headMsg.chulifangshi = textField.text;
    }
    if (textField == self.chulijieguo) {
        self.headMsg.chulijieguo = textField.text;
    }
    if (textField == self.wentiyuanyin) {
        self.headMsg.wentiyuanyin = textField.text;
    }
    if (textField == self.jianliresult) {
        self.headMsg.jianliresult = textField.text;
    }
    if (textField == self.jianlishenpi) {
        self.headMsg.jianlishenpi = textField.text;
    }
    
    self.txf = nil
    ;return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{self.txf = textField;return YES;}
- (IBAction)cancelClick:(UIButton *)sender {
    if (self.txf)[self.txf resignFirstResponder];}

- (IBAction)commitClick:(UIButton *)sender {
    switch (sender.tag) {
        case 21:{//处置
            if (![UserDefaultsSetting shareSetting].hntchaobiaoReal) {
                [Tools tip:@"没有处置权限，无法提交"];
                break;
            }
            if (!self.chuZhiZhuangTai) {
                break;
            }
            if (self.wentiyuanyin.text.length == 0 || self.chulifangshi.text.length == 0 || self.chulishijian.currentTitle.length == 0||self.chulijieguo.text.length == 0  ) {
                [Tools tip:@"信息不完整，无法提交"];
                break;
            }
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:super.superview animated:YES];
//            hud.mode = MBProgressHUDModeDeterminate;
//            hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
            
            NSString * urlString = FormatString(baseUrl, @"app.do?AppHntChaobiaoChuzhi");
            NSDictionary * dic = @{@"jieguobianhao":self.headMsg.SId,
                                   @"chaobiaoyuanyin":self.wentiyuanyin.text,
                                   @"chuzhifangshi":self.chulifangshi.text,
                                   @"chuzhiren":[UserDefaultsSetting shareSetting].userFullName,
                                   @"chuzhishijian":[TimeTools timeStampWithTimeString:self.chulishijian.currentTitle],
                                   @"chuzhijieguo":self.chulijieguo.text,
                                   @"isIos":@"1"
                                   };
            
            
            NSData *  data =[Tools compressOriginalImage:self.filePathImage toMaxDataSizeKBytes:30];
          
            
            
            [[HTTP shareAFNNetworking] uploadWithUrlstring:urlString parameter:dic data:data success:^(id json) {
                if ([json[@"success"] boolValue]){
//                    hud.mode = MBProgressHUDModeText;
//                    hud.label.text = @"提交成功,请刷新数据";
                    [Tools tip:@"提交成功,请刷新数据"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [self.weakController.navigationController popViewControllerAnimated:YES];
                    });
                }else{
//                    hud.mode = MBProgressHUDModeText;
//                    hud.label.text = @"抱歉，提交失败";
                    [Tools tip:@"抱歉，提交失败"];
                }
//                [hud hideAnimated:YES afterDelay:2.0];
            } failure:^(NSError *error) {
//                hud.mode = MBProgressHUDModeText;
//                hud.label.text = @"网络故障，提交失败";
//                [hud hideAnimated:YES afterDelay:2.0];
                [Tools tip:@"网络故障，提交失败"];
            }];
            break;
        }
        case 22:{//审批
            if (![UserDefaultsSetting shareSetting].hntchaobiaoSp) {
                [Tools tip:@"没有审批权限，无法提交"];
                break;
            }
            if (!self.shenPiZhuangTai) {
                break;
            }
            
            if (self.jianliresult.text.length == 0 || self.jianlishenpi.text.length == 0 || self.confirmdate.currentTitle.length == 0 || self.shenpidate.currentTitle.length == 0) {
                [Tools tip:@"信息不完整，无法提交"];
                break;
            }

            NSString * urlString = FormatString(baseUrl, @"app.do?AppHntChaobiaoShenpi");
            NSDictionary * dic = @{@"jieguobianhao":self.headMsg.SId,
                                   @"jianliresult":self.jianliresult.text,
                                   @"jianlishenpi":self.jianlishenpi.text,
                                   @"confirmdate":self.confirmdate.currentTitle,
                                   @"shenpiren":[UserDefaultsSetting shareSetting].userFullName,
                                   @"shenpidate":self.shenpidate.currentTitle,
                                   };
            
            [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dic success:^(id json) {
                if ([json[@"success"] boolValue]){
                    [Tools tip:@"提交成功,请刷新数据"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [self.weakController.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    [Tools tip:@"抱歉，提交失败"];
                }
            } failure:^(NSError *error) {
                 [Tools tip:@"网络故障，提交失败"];
            }];
            break;
        }
    }
}

- (IBAction)choiceTimeClick:(UIButton *)sender {

    [sender setTitle:[TimeTools currentTime] forState:UIControlStateNormal];
    if (sender == self.chulishijian) {
        self.headMsg.chulishijian = sender.currentTitle;
    }
    if (sender == self.confirmdate) {
        self.headMsg.confirmdate = sender.currentTitle;
    }
    if (sender == self.shenpidate) {
        self.headMsg.shenpidate = sender.currentTitle;
    }
     //[self calendarWithTimeString:nil obj:sender];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.txf)[self.txf resignFirstResponder],self.txf = nil;
}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    NSLog(@"%@",info);
    
    //获取修改后的图片
    self.filePathImage = info[UIImagePickerControllerEditedImage];

    //更改button里的图片
    [self.filePath setBackgroundImage:self.filePathImage forState:UIControlStateNormal];
    [self.filePath setImage:nil forState:UIControlStateNormal];

    //移除图片选择的控制器
    [self.weakController dismissViewControllerAnimated:YES completion:nil];
}


//**************
//-(void)calendarWithTimeString:(NSString*)timeString  obj:(id)obj{
//    CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
//    calendarController.view.frame = self.weakController.view.frame;
//    calendarController.obj = obj;
//    calendarController.delegate = self;
//    NSArray *arr = [timeString componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"- "]];
//    if (arr.count > 1) {
//        [calendarController setYear:arr[0] month:arr[1] day:arr[2]];
//    }
//    
//    [self.weakController presentViewController:calendarController animated:YES completion:nil];
//}
////可选协议 @optional
//-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
//    if ([month intValue] <10) {
//        month = [NSString stringWithFormat:@"0%d",[month intValue]];
//    }
//    if ([day intValue] <10) {
//        day = [NSString stringWithFormat:@"0%d",[day intValue]];
//    }
//    [(UIButton*)controller.obj setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@", year, month, day,[TimeTools current_HH_mm_SS]] forState:UIControlStateNormal];
//    FuncLog;
//}
@end
