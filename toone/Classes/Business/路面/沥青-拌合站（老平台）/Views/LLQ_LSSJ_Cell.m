//
//  HNT_SCCX_Cell.m
//  toone
//
//  Created by 十国 on 16/12/13.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_LSSJ_Cell.h"
#import "LLQ_LSSJ_Model.h"
#import "LLQ_CBCZ_View.h"

#define CELL_WIDTH      self.frame.size.width
#define CELL_HEIGHT     self.frame.size.height
@interface LLQ_LSSJ_Cell()
@property (nonatomic,strong) UIView * containerView;
@end

@implementation LLQ_LSSJ_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *containerView = [[UIView alloc] init];
        [self.contentView addSubview:containerView];
        self.containerView = containerView;        
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setModel:(LLQ_LSSJ_Model *)model
{
    self.containerView.frame = CGRectMake(0, 0, CELL_WIDTH, CELL_HEIGHT);
    for (UIView * subView in self.containerView.subviews) {
        if ([subView isKindOfClass:[LLQ_CBCZ_View class]]) {
            [subView removeFromSuperview];
            [subView.layer removeFromSuperlayer];
        }
    }
    
    
#pragma mark - 数据处理
    NSMutableArray * datas = [NSMutableArray array];
    [datas addObject:@{@"bhzName":[model.dataDict  objectForKey:@"bhzName"]}];
    [datas addObject:@{@"sjlq":    [model.dataDict  objectForKey:@"sjlq"]}];
    [datas addObject:@{@"sjtjj":    [model.dataDict  objectForKey:@"sjtjj"]}];
    [datas addObject:@{@"sjysb": [model.dataDict  objectForKey:@"sjysb"]}];
    [datas addObject:@{@"lqwd": [model.dataDict  objectForKey:@"lqwd"]}];
    [datas addObject:@{@"clwd": [model.dataDict  objectForKey:@"clwd"]}];
    [datas addObject:@{@"glwd": [model.dataDict  objectForKey:@"glwd"]}];
    [datas addObject:@{@"clTime": [model.dataDict  objectForKey:@"clTime"]}];
    
    int index = 0;
    for (NSDictionary * dict in datas) {
        LLQ_CBCZ_View * childrenCell  = [[NSBundle mainBundle] loadNibNamed:@"LLQ_CBCZ_View" owner:nil options:nil][0];
        childrenCell.frame = CGRectMake(0,index*15, self.containerView.frame.size.width, 15);
        [self.containerView addSubview:childrenCell];
        childrenCell.label1.text = [NSString stringWithFormat:@"%@ :",[model.fieldDict objectForKey:dict.allKeys.firstObject]];
        childrenCell.label2.text = [model.dataDict  objectForKey:dict.allKeys.firstObject];
        index++ ;
    }
}

@end
