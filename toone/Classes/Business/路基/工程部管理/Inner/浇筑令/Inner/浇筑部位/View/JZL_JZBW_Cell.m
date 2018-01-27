//
//  JZL_JZBW_Cell.m
//  toone
//
//  Created by 上海同望 on 2017/8/24.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "JZL_JZBW_Cell.h"
#import "JZL_JZBW_Model.h"

@interface JZL_JZBW_Cell ()
@property (weak, nonatomic) IBOutlet UILabel *dwgcLabel;
@property (weak, nonatomic) IBOutlet UILabel *fbgcLabel;
@property (weak, nonatomic) IBOutlet UILabel *fxgcLabel;
@property (weak, nonatomic) IBOutlet UILabel *jzbwLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjqdLabel;
@property (weak, nonatomic) IBOutlet UILabel *sjflLabel;


@end
@implementation JZL_JZBW_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(JZL_JZBW_Model *)model {
    _model = model;
    _dwgcLabel.text = model.zjiedian;
    _fbgcLabel.text = model.yjiedian;
    _fxgcLabel.text = model.bjiedian;
    _jzbwLabel.text = model.projectname;
    _sjqdLabel.text = model.shejiqiangdu;
    _sjflLabel.text = model.shejifangliang;
}

@end
