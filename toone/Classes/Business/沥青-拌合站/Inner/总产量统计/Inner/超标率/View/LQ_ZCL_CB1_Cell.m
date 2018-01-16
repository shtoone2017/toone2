//
//  LQ_ZCL_CB1_Cell.m
//  toone
//
//  Created by shtoone on 17/1/12.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "LQ_ZCL_CB1_Cell.h"
#import "SGChart.h"

@interface LQ_ZCL_CB1_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *jiduLabel;
@property (weak, nonatomic) IBOutlet UIView *chaoBView;
//@property (nonatomic, strong) PNLineChart * lineChart;//折线图
@property (nonatomic, assign) float max;
@property (nonatomic, assign) float min;

@end
@implementation LQ_ZCL_CB1_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)muLabel:(int)date {
    switch (date) {
        case 1:
            self.jiduLabel.text = @"季度";
            break;
        case 2:
            self.jiduLabel.text = @"月份";
            break;
        case 3:
            self.jiduLabel.text = @"周";
            break;
        case 4:
            self.jiduLabel.text = @"天";
            break;
        default:
            self.jiduLabel.text = @"季度";
            break;
    }
}
-(void)method:(NSArray *)chaobiaoDatas axisNames:(NSArray *)names{
    NSArray * color = @[[UIColor redColor],[UIColor yellowColor],[UIColor blueColor]];
    SGLineDIY *   lineChart = [[SGLineDIY alloc]  initWithFrame:CGRectMake(0, 40, Screen_w, 260) data:chaobiaoDatas title:names color:color];
    lineChart.titleTop = @[@"低超标",@"中超标",@"高超标"];
    lineChart.backgroundColor = [UIColor whiteColor];
    [self.chaoBView addSubview:lineChart];
}
@end
