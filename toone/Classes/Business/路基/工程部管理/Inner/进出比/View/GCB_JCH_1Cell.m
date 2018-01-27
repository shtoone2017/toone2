//
//  GCB_JCH_1Cell.m
//  toone
//
//  Created by 上海同望 on 2017/9/12.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "GCB_JCH_1Cell.h"
#import "GCB_JCH_Model.h"

@interface GCB_JCH_1Cell ()
@property (weak, nonatomic) IBOutlet UILabel *name ;//  材料名称
@property (weak, nonatomic) IBOutlet UILabel *shiji ;//  进场
@property (weak, nonatomic) IBOutlet UILabel *peibi ;//  出场
@property (weak, nonatomic) IBOutlet UILabel *wuchazhi ;//  消耗


@end
@implementation GCB_JCH_1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(GCB_JCH_Model *)model {
    _model = model;
    _name.text = model.cailiaoName;
    _shiji.text = model.jinchang;
    _peibi.text = model.chuchang;
    _wuchazhi.text = model.xiaohao;
}


@end
