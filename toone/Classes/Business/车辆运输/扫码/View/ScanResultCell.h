//
//  ScanResultCell.h
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car_ScanModel;
@interface ScanResultCell : UITableViewCell
@property (nonatomic, strong) Car_ScanModel *model;

@property (nonatomic, copy) NSString *dataImg;//图片参数
@property (nonatomic, copy) NSString *jsImg;//图片参数
@property (nonatomic, copy) NSString *loation;

@property (nonatomic, copy) NSString *status;//是否签收

@property (nonatomic, copy) NSString *jsyy;//拒收原因
@property (nonatomic, copy) NSString *jsyylx;


@property (weak, nonatomic) IBOutlet UITextField * bhz_Label         ;// 拌合站1
@property (weak, nonatomic) IBOutlet UITextField * facdBh_Label       ;// 发车单编号1
@property (weak, nonatomic) IBOutlet UITextField * bhzBh_Label     ;// 浇筑令编号1
@property (weak, nonatomic) IBOutlet UITextField * gongName_Label           ;// 工程名称1
@property (weak, nonatomic) IBOutlet UITextField * qiangdudengji_Label          ;// 强度等级1
@property (weak, nonatomic) IBOutlet UITextField *tldLabel;//塌落度1
@property (weak, nonatomic) IBOutlet UITextField *sjflLabel;//设计方量1
@property (weak, nonatomic) IBOutlet UITextField *bcflLabel;//本车1
@property (weak, nonatomic) IBOutlet UITextField *qsflTf;//签收量
@property (weak, nonatomic) IBOutlet UITextField *cphLabel;//车牌号1
@property (weak, nonatomic) IBOutlet UITextField *qsrLabel;//签收人1
@property (weak, nonatomic) IBOutlet UITextField * user_Label;// 发车人1
@property (weak, nonatomic) IBOutlet UITextField *fcTiemTf;//发车时间1
@property (weak, nonatomic) IBOutlet UITextField *qlwzTf;//卸料位置1


@property (weak, nonatomic) IBOutlet UIView *jsyyView;//拒收
@property (weak, nonatomic) IBOutlet UIButton *jsBut;

@property (weak, nonatomic) IBOutlet UIView *bzView;//备注
@property (weak, nonatomic) IBOutlet UITextField *bzTf;

@property (weak, nonatomic) IBOutlet UIButton *xzBut;//状态显示
@property (weak, nonatomic) IBOutlet UIView *xzStatusView;//状态

@end
