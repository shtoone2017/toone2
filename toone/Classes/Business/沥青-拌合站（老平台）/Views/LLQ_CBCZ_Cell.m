//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LLQ_CBCZ_Cell.h"
#import "LLQ_CBCZ_Model.h"
#import "LLQ_CBCZ_View.h"

#define CELL_WIDTH      self.frame.size.width
#define CELL_HEIGHT     self.frame.size.height
@interface LLQ_CBCZ_Cell()
@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) UILabel * shenheLabel;
@property (nonatomic,strong) UILabel * chuliLabel;
@end
@implementation LLQ_CBCZ_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *containerView = [[UIView alloc] init];
        [self.contentView addSubview:containerView];
        self.containerView = containerView;
        
        UILabel * chuliLabel = [[UILabel alloc] init];
        chuliLabel.font = [UIFont systemFontOfSize:9.0];
        chuliLabel.textAlignment = NSTextAlignmentCenter;
        chuliLabel.textColor = [UIColor whiteColor];
        chuliLabel.frame = CGRectMake(0, 0, 40, 12);
        chuliLabel.transform=CGAffineTransformMakeRotation(M_PI_4);
        [self.contentView addSubview:chuliLabel];
        self.chuliLabel = chuliLabel;
        
       
        UILabel * shenheLabel = [[UILabel alloc] init];
        shenheLabel.font = [UIFont systemFontOfSize:9.0];
        shenheLabel.textAlignment = NSTextAlignmentCenter;
        shenheLabel.textColor = [UIColor whiteColor];
        shenheLabel.frame = CGRectMake(0, 0, 40, 12);
        shenheLabel.transform=CGAffineTransformMakeRotation(-M_PI_4);
        [self.contentView addSubview:shenheLabel];
        self.shenheLabel = shenheLabel;
        
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setModel:(LLQ_CBCZ_Model *)model
{
    self.containerView.frame = self.bounds;
    for (UIView * subView in self.containerView.subviews) {
        if ([subView isKindOfClass:[LLQ_CBCZ_View class]]) {
            [subView removeFromSuperview];
            [subView.layer removeFromSuperlayer];
        }
    }
#pragma mark - 数据处理
    NSMutableArray * datas = [NSMutableArray array];
    [datas addObject:@{@"bhzName":[model.dataDict  objectForKey:@"bhzName"]}];
    [datas addObject:@{@"clTime": [model.dataDict  objectForKey:@"clTime"]}];
    [datas addObject:@{@"sjlq":   [model.dataDict  objectForKey:@"sjlq"]}];
    [datas addObject:@{@"sjtjj":  [model.dataDict  objectForKey:@"sjtjj"]}];
    [datas addObject:@{@"sjysb":  [model.dataDict  objectForKey:@"sjysb"]}];
    [datas addObject:@{@"lqwd":   [model.dataDict  objectForKey:@"lqwd"]}];
    [datas addObject:@{@"clwd":   [model.dataDict  objectForKey:@"clwd"]}];
    [datas addObject:@{@"glwd":   [model.dataDict  objectForKey:@"glwd"]}];
    for (NSString * key in model.dataDict.allKeys) {
        if ((([key hasPrefix:@"sjf"] || [key hasPrefix:@"sjg"]) && [[model.dataDict objectForKey:key] intValue]>=1)) {
            [datas addObject:@{key:[model.dataDict  objectForKey:key]}];
        }
    }
    int index = 0;
    for (NSDictionary* dict in datas) {
            LLQ_CBCZ_View * childrenCell  = [[NSBundle mainBundle] loadNibNamed:@"LLQ_CBCZ_View" owner:nil options:nil][0];
            childrenCell.frame = CGRectMake(0,index*15, self.containerView.frame.size.width, 15);
            [self.containerView addSubview:childrenCell];
            childrenCell.label1.text = [NSString stringWithFormat:@"%@ :",[model.fieldDict objectForKey:dict.allKeys.firstObject]];
            if ([dict.allKeys.firstObject hasPrefix:@"sjf"] || [dict.allKeys.firstObject hasPrefix:@"sjg"]) {
                int count = [[model.dataDict objectForKey:dict.allKeys.firstObject] intValue];
                if(count >=1 && count <= 3){
                    for (int i = 1; i<=count; i++) {
                        UIImageView * imgv = [[UIImageView alloc] init];
                        imgv.frame = CGRectMake(0, 0, 15, 15);
                        imgv.image = [UIImage imageNamed:@"Yellow_3D_arrow_top.png"];
                        [childrenCell.label2 addSubview:imgv];
                    }
                }
                
                if (count >=4 && count <= 6) {
                    for (int i = 4; i<=count; i++) {
                        UIImageView * imgv = [[UIImageView alloc] init];
                        imgv.frame = CGRectMake(15*(i-4), 0, 15, 15);
                        imgv.image = [UIImage imageNamed:@"Blue_3D_arrow_down.png"];
                        [childrenCell.label2 addSubview:imgv];
                    }
                }
                
                childrenCell.label2.text = nil;
            }else{
                childrenCell.label2.text = [model.dataDict  objectForKey:dict.allKeys.firstObject];
                childrenCell.label2.backgroundColor = [UIColor clearColor];
                childrenCell.label2.font = [UIFont systemFontOfSize:12];
                childrenCell.label2.textColor = [UIColor blackColor];
            }
            index++ ;
    }
    
    
    
      if (model.dataDict[@"chuli"]) {
        [self.contentView insertSubview:self.chuliLabel aboveSubview:self.containerView];
        self.chuliLabel.center = CGPointMake(CELL_WIDTH- 14/sqrt(2),  14/sqrt(2));
        if(EqualToString(model.dataDict[@"chuli"], @"0")){
            self.chuliLabel.backgroundColor = [UIColor bananaColor];
            self.chuliLabel.text = @"未处置";
        }else{
            self.chuliLabel.backgroundColor = [UIColor emeraldColor];
            self.chuliLabel.text = @"已处置";
        }
        
        
    }
    if (model.dataDict[@"shenhe"]) {
        [self.contentView insertSubview:self.shenheLabel aboveSubview:self.containerView];
        self.shenheLabel.center = CGPointMake(CELL_WIDTH- 14/sqrt(2),CELL_HEIGHT-14/sqrt(2));
        if (EqualToString(model.dataDict[@"shenhe"], @"0")) {
            self.shenheLabel.text = @"未审核";
            self.shenheLabel.backgroundColor = [UIColor brickRedColor];
        }else{
            self.shenheLabel.text = @"已审核";
            self.shenheLabel.backgroundColor = [UIColor emeraldColor];
        }
    }
}

-(void)setModel:(LLQ_CBCZ_Model *) model indexPath:(NSIndexPath *)indexPath{
    self.containerView.frame = self.bounds;
    for (UIView * subView in self.containerView.subviews) {
        if ([subView isKindOfClass:[LLQ_CBCZ_View class]]) {
            [subView removeFromSuperview];
            [subView.layer removeFromSuperlayer];
        }
    }
    
    int index = 0;
    for (NSString * key in model.lqisshow.allKeys) {
        if (![[model.lqisshow objectForKey:key] isEqualToString:@"0"]) {
            [[DWURunLoopWorkDistribution sharedRunLoopWorkDistribution] addTask:^BOOL(void) {
                if (![self.currentIndexPath isEqual:indexPath]) {
                    return NO;
                }
                LLQ_CBCZ_View * childrenCell  = [[NSBundle mainBundle] loadNibNamed:@"LLQ_CBCZ_View" owner:nil options:nil][0];
                childrenCell.frame = CGRectMake(0,index*15, self.containerView.frame.size.width, 15);
                [self.containerView addSubview:childrenCell];
                childrenCell.label1.text = [NSString stringWithFormat:@"%@ :",[model.fieldDict objectForKey:key]];
                childrenCell.label2.text = [model.dataDict  objectForKey:key];
                return YES;
            } withKey:indexPath];
            index++ ;
        }
    }
    if (model.dataDict[@"chuli"]) {
        [self.contentView insertSubview:self.chuliLabel aboveSubview:self.containerView];
        self.chuliLabel.center = CGPointMake(CELL_WIDTH- 14/sqrt(2),  14/sqrt(2));
        if(EqualToString(model.dataDict[@"chuli"], @"0")){
            self.chuliLabel.backgroundColor = [UIColor bananaColor];
            self.chuliLabel.text = @"未处置";
        }else{
            self.chuliLabel.backgroundColor = [UIColor emeraldColor];
            self.chuliLabel.text = @"已处置";
        }
        
        
    }
    if (model.dataDict[@"shenhe"]) {
        [self.contentView insertSubview:self.shenheLabel aboveSubview:self.containerView];
        self.shenheLabel.center = CGPointMake(CELL_WIDTH- 14/sqrt(2),CELL_HEIGHT-14/sqrt(2));
        if (EqualToString(model.dataDict[@"shenhe"], @"0")) {
            self.shenheLabel.text = @"未审核";
            self.shenheLabel.backgroundColor = [UIColor brickRedColor];
        }else{
            self.shenheLabel.text = @"已审核";
            self.shenheLabel.backgroundColor = [UIColor emeraldColor];
        }
    }
}
@end
