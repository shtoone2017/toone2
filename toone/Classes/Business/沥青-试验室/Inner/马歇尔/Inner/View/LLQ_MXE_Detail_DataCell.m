
//
//  SW_CBCZ_Detail_DataCell.m
//  toone
//
//  Created by sg on 2017/3/22.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LLQ_MXE_Detail_DataCell.h"
#import "LLQ_MXE_Detail_Data.h"
@interface LLQ_MXE_Detail_DataCell()
@property (weak, nonatomic) IBOutlet UIButton *lb1;
@property (weak, nonatomic) IBOutlet UIButton *lb2;
@property (weak, nonatomic) IBOutlet UIButton *lb3;
@property (weak, nonatomic) IBOutlet UIButton *lb4;
@property (weak, nonatomic) IBOutlet UIButton *lb5;
@property (weak, nonatomic) IBOutlet UIButton *lb6;

@property (weak, nonatomic) IBOutlet UILabel *wd1;
@property (weak, nonatomic) IBOutlet UILabel *wd2;
@property (weak, nonatomic) IBOutlet UILabel *wd3;
@property (weak, nonatomic) IBOutlet UILabel *wd4;
@property (weak, nonatomic) IBOutlet UILabel *wd5;
@property (weak, nonatomic) IBOutlet UILabel *wd6;

@property (weak, nonatomic) IBOutlet UILabel *lpj;
@property (weak, nonatomic) IBOutlet UILabel *lfw;

@property (weak, nonatomic) IBOutlet UILabel *wdpj;
@property (weak, nonatomic) IBOutlet UILabel *wdfw;

@end

@implementation LLQ_MXE_Detail_DataCell
/**
 biaoZhun2&biaoZhun1 流值范围
 biaoZhun3 稳定值范围
 avgvalue1 流平均值
 avgvalue2 稳定平均值
 */


-(void)setModel:(LLQ_MXE_Detail_Data *)model{
    
    self.lpj.text = model.avgvalue1;
    self.wdpj.text = model.avgvalue2;
    
    self.lfw.text = [NSString stringWithFormat:@"%@~%@",model.biaoZhun1,model.biaoZhun2];
    self.wdfw.text = [NSString stringWithFormat:@">=%@",model.biaoZhun3];
    
    
    NSArray *liuArr = [model.liuzhi componentsSeparatedByString:@"&"];
    NSArray *wdArr = [model.wendingdu componentsSeparatedByString:@"&"];
//    self.lb1.hidden = YES;
    self.lb2.hidden = YES;
    self.lb3.hidden = YES;
    self.lb4.hidden = YES;
    self.lb5.hidden = YES;
    self.lb6.hidden = YES;
//    数据容易炸

    [self.lb1 setTitle:liuArr[0] forState:UIControlStateNormal];
    if (liuArr.count > 1) {
        self.lb2.hidden = NO;
        [self.lb2 setTitle:liuArr[1] forState:UIControlStateNormal];
    }
    if (liuArr.count > 2) {
        self.lb3.hidden = NO;
        [self.lb3 setTitle:liuArr[2] forState:UIControlStateNormal];
    }
    if (liuArr.count > 3) {
        self.lb4.hidden = NO;
        [self.lb4 setTitle:liuArr[3] forState:UIControlStateNormal];
    }
    if (liuArr.count > 4) {
        self.lb5.hidden = NO;
        [self.lb5 setTitle:liuArr[4] forState:UIControlStateNormal];
    }
    if (liuArr.count > 5) {
        self.lb6.hidden = NO;
        [self.lb6 setTitle:liuArr[5] forState:UIControlStateNormal];
    }
    
    self.wd1.text = wdArr[0];
    if (wdArr.count > 1) {
        self.wd2.text = wdArr[1];
    }
    if (wdArr.count > 2) {
        self.wd3.text = wdArr[2];
    }
    if (wdArr.count > 3) {
        self.wd4.text = wdArr[3];
    }
    if (wdArr.count > 4) {
        self.wd5.text = wdArr[4];
    }
    if (wdArr.count >5) {
        self.wd6.text = wdArr[5];
    }
}

- (IBAction)btnAction:(UIButton *)sender
{
    if (_block)
    {
        _block(sender.tag);
    }
    
    
}




@end
