//
//  Car_localDetailController.m
//  toone
//
//  Created by 上海同望 on 2017/10/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "Car_localDetailController.h"
#import "Car_ScanModel.h"
#import "ScanResultCell.h"
#import "Car_ResultCell.h"
#import "ResultIconCell.h"

@interface Car_localDetailController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic, strong) Car_ResultCell *cell1;
@property (nonatomic, strong) ScanResultCell *submitCell;
@property (nonatomic, strong) ResultIconCell *cell2;

@end
@implementation Car_localDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运输单再编辑";
    [self loadUI];

}

-(void)loadUI{
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    [self.tb registerNib:[UINib nibWithNibName:@"ScanResultCell" bundle:nil] forCellReuseIdentifier:@"ScanResultCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"Car_ResultCell" bundle:nil] forCellReuseIdentifier:@"Car_ResultCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"ResultIconCell" bundle:nil] forCellReuseIdentifier:@"ResultIconCell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:return 340;
        case 1:return 190;
        case 2:return 230;
    }
    return 0.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"提交照片";
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScanResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ScanResultCell"];
        self.submitCell = cell;
        Car_ScanModel *model = self.Headmodel;
        NSDictionary *dict = @{@"status":_status?:@"",
                               @"qsfl":_qsfl?:@"",
                               @"jsyy":_jsyy?:@"",
                               @"jsyylx":_jsyylx?:@"",
                               @"jsbz":_jsbz?:@"",
                               };
        [cell setData:model :dict];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1 ) {
        Car_ResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Car_ResultCell"];
        self.cell1 = cell;
        NSData *ImageData = [[NSData alloc] initWithBase64EncodedString:_Headmodel.QS_img options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *Image = [UIImage imageWithData:ImageData];
        cell.qsImg.image = Image;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        ResultIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultIconCell"];
        self.cell2 = cell;
        cell.jsimageView.image = _jsIcon;
        [cell.submitBut addTarget:self action:@selector(loadIcon:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark - 上传图片
-(void)chop:(UIImage *)img add:(NSString *)str{
    __block NSDictionary *dic;
    NSString *urlString = @"http://61.237.239.105:18190/FCDService/FilesUpload.asmx/FileUpload";
    NSData *data =[Tools compressOriginalImage:img toMaxDataSizeKBytes:100];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dict = @{@"filestr":encodedImageStr?:@"",
                           @"filename":[NSString stringWithFormat:@"%@%zd.jpg",str,[TimeTools timeStampWithTimeString:[TimeTools currentTime]]],
                           };
    
    [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dict success:^(id json) {
        if ([json[@"code"] integerValue] == 1) {
            dic = json[@"data"];
            if (_imgBlock) {
                _imgBlock(dic);
            }
        }else {
            [SVProgressHUD showImage:nil status:@"请重新提交照片"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//提交
-(void)loadIcon:(NSData *)imgData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self)  weakSelf = self;
    __block NSDictionary *dicQs;
    if (_submitCell.status.length == 0 || _submitCell.qsflTf.text.length == 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"必填项不可为空，请填写完整信息";
        [hud hideAnimated:YES afterDelay:2.0];
        return;
    }
    if ([_submitCell.status isEqualToString:@"签收"]) {
        if (_cell1.qsImg.image==nil) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请上传图片";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }else {
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
            hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
            [weakSelf chop:_cell1.qsImg.image add:@"qsImg"];
            self.imgBlock = ^(NSDictionary *iconDic) {
                dicQs = iconDic;
                NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadQSXX";
                NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                                       @"fcdbh":weakSelf.Headmodel.FCDBH?:@"",
                                       @"bhzbh":weakSelf.Headmodel.BHZBH?:@"",
                                       @"qsfl":weakSelf.submitCell.qsflTf.text?:@"",
                                       @"qsr":weakSelf.Headmodel.QSR?:@"",
                                       @"xlwzmc":weakSelf.Headmodel.XLWZ?:@"",
                                       @"xlwzcode":@"1",
                                       @"xlwzzb":weakSelf.loation?:@"",
                                       @"qszp":iconDic?:@"",
                                       @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                                       };
                
                [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
                    if ([json isKindOfClass:[NSDictionary class]]) {
                        if ([json[@"code"] integerValue] == 1) {
                            NSMutableArray *Arr = [NSKeyedUnarchiver unarchiveObjectWithFile:Car_ScanModelInfoPath];
                            if (Arr.count > 1) {
                                [Arr removeObjectAtIndex:Arr.count];
                            }else {
                                [[NSFileManager defaultManager] removeItemAtPath:Car_ScanModelInfoPath error:nil];
                            }
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                UIViewController * vc = weakSelf.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                                [weakSelf.navigationController popToViewController:vc animated:YES];
                            });
                        }else {
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text = json[@"message"];
                        }
                        [hud hideAnimated:YES afterDelay:2.0];
                    }
                } failure:^(NSError *error) {
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"网络连接异常";
                    [hud hideAnimated:YES afterDelay:2.0];
                }];
            };
            
        }
    }
    if ([_submitCell.status isEqualToString:@"拒收"]) {
        if (([_submitCell.jsyylx isEqualToString:@"5"] && _submitCell.bzTf.text.length ==0 ) || _submitCell.jsyy.length == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"必填项不可为空，请填写完整信息";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }
        if (_cell1.qsImg.image==nil || _cell2.jsimageView.image==nil) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"请上传两张图片";
            [hud hideAnimated:YES afterDelay:2.0];
            return;
        }else {
            //
            hud.mode = MBProgressHUDModeDeterminate;
            hud.label.text = NSLocalizedString(@"正在提交", @"HUD loading title");
            hud.contentColor = [UIColor colorWithRed:0.f green:0.6f blue:0.7f alpha:1.f];
            [weakSelf chop:_cell1.qsImg.image add:@"qsImg"];
            //            [weakSelf chop:_cell2.jsimageView.image add:@"jsImg"];
            self.imgBlock = ^(NSDictionary *img) {
                __block NSDictionary *dicIcon;
                NSString *urlString = @"http://61.237.239.105:18190/FCDService/FilesUpload.asmx/FileUpload";
                NSData *data =[Tools compressOriginalImage:weakSelf.cell2.jsimageView.image toMaxDataSizeKBytes:100];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                
                NSDictionary *dic = @{@"filestr":encodedImageStr?:@"",
                                      @"filename":[NSString stringWithFormat:@"jsImg%zd.jpg",[TimeTools timeStampWithTimeString:[TimeTools currentTime]]],
                                      };
                
                [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlString parameter:dic success:^(id json) {
                    if ([json[@"code"] integerValue] == 1) {
                        dicIcon = json[@"data"];
                        NSString *urlSting = @"http://61.237.239.105:18190/FCDService/FCDService.asmx/UploadJSXX";
                        NSDictionary *dict = @{@"token":[UserDefaultsSetting_SW shareSetting].Token,
                                               @"fcdbh":weakSelf.Headmodel.FCDBH?:@"",
                                               @"bhzbh":weakSelf.Headmodel.BHZBH?:@"",
                                               @"qsfl":weakSelf.submitCell.qsflTf.text?:@"",
                                               @"qsr":weakSelf.Headmodel.QSR?:@"",
                                               @"xlwzmc":weakSelf.Headmodel.XLWZ?:@"",
                                               @"xlwzcode":@"1",
                                               @"xlwzzb":weakSelf.loation?:@"",
                                               @"qszp":img?:@"",//签收
                                               @"qssj":[TimeTools timeStampWithTimeString:[TimeTools currentTime]],
                                               @"jsyylx":weakSelf.submitCell.jsyylx?:@"",
                                               @"jsyy":weakSelf.submitCell.jsyy?:@"",
                                               @"jspz":dicIcon?:@"",//拒收
                                               };
                        
                        [[HTTP shareAFNNetworking] requestMethod:POST urlString:urlSting parameter:dict success:^(id json) {
                            if ([json isKindOfClass:[NSDictionary class]]) {
                                if ([json[@"code"] integerValue] == 1) {
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                        UIViewController * vc = weakSelf.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
                                        [weakSelf.navigationController popToViewController:vc animated:YES];
                                    });
                                }else {
                                    hud.mode = MBProgressHUDModeText;
                                    hud.label.text = json[@"message"];
                                }
                                [hud hideAnimated:YES afterDelay:2.0];
                            }
                        } failure:^(NSError *error) {
                            hud.mode = MBProgressHUDModeText;
                            hud.label.text = @"网络连接异常";
                            [hud hideAnimated:YES afterDelay:2.0];
                        }];
                    }else {
                        [SVProgressHUD showImage:nil status:@"请重新提交照片"];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
                
            };
            
        }
    }
    
}



@end
