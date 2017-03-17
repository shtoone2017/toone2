//
//  HNT_CBCZ_Cell.m
//  toone
//
//  Created by 十国 on 16/12/14.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "SW_CBCZ_Cell.h"
#import "SW_CBCZ_Model.h"
#import "SW_CBCZ_View.h"

#define CELL_WIDTH      self.frame.size.width
#define CELL_HEIGHT     self.frame.size.height
@interface SW_CBCZ_Cell()
@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) UILabel * shenheLabel;
@property (nonatomic,strong) UILabel * chuliLabel;
@end
@implementation SW_CBCZ_Cell

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
        chuliLabel.font = [UIFont systemFontOfSize:12.0];
        chuliLabel.textAlignment = NSTextAlignmentCenter;
        chuliLabel.textColor = [UIColor whiteColor];
        chuliLabel.frame = CGRectMake(0, 0, 70, 20);
        chuliLabel.transform=CGAffineTransformMakeRotation(M_PI_4);
        [self.contentView addSubview:chuliLabel];
        self.chuliLabel = chuliLabel;
        
       
        UILabel * shenheLabel = [[UILabel alloc] init];
        shenheLabel.font = [UIFont systemFontOfSize:12.0];
        shenheLabel.textAlignment = NSTextAlignmentCenter;
        shenheLabel.textColor = [UIColor whiteColor];
        shenheLabel.frame = CGRectMake(0, 0, 70, 20);
        shenheLabel.transform=CGAffineTransformMakeRotation(-M_PI_4);
        [self.contentView addSubview:shenheLabel];
        self.shenheLabel = shenheLabel;
        
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setModel:(SW_CBCZ_Model *)model
{
    self.containerView.frame = CGRectMake(0, 0, CELL_WIDTH, CELL_HEIGHT);    
    for (UIView * subView in self.containerView.subviews) {
        if ([subView isKindOfClass:[SW_CBCZ_View class]]) {
            [subView removeFromSuperview];
            [subView.layer removeFromSuperlayer];
        }
    }
    
    int index = 0;
    for (NSString * key in model.isShow.allKeys) {
        if (![[model.isShow objectForKey:key] isEqualToString:@"0"]) {
            SW_CBCZ_View * childrenCell  = [[NSBundle mainBundle] loadNibNamed:@"SW_CBCZ_View" owner:nil options:nil][0];
            childrenCell.frame = CGRectMake(0,index*20, self.containerView.frame.size.width, 20);
            [self.containerView addSubview:childrenCell];
            childrenCell.label1.text = [NSString stringWithFormat:@"%@ :",[model.fieldDict objectForKey:key]];
            childrenCell.label2.text = [model.dataDict  objectForKey:key];
            index++ ;
        }
    }
    if (model.dataDict[@"chuli"]) {
        [self.contentView insertSubview:self.chuliLabel aboveSubview:self.containerView];
        self.chuliLabel.center = CGPointMake(CELL_WIDTH- 25/sqrt(2),  25/sqrt(2));
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
        self.shenheLabel.center = CGPointMake(CELL_WIDTH- 25/sqrt(2),CELL_HEIGHT-25/sqrt(2));
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
