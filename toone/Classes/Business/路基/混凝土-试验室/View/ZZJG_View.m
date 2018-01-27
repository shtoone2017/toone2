//
//  ZZJG_view.m
//  toone
//
//  Created by 十国 on 16/11/28.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ZZJG_View.h"
@interface ZZJG_View()
@property (weak, nonatomic) IBOutlet UILabel *label;


@end
@implementation ZZJG_View


-(void)setTitle:(NSString *)title{
    _title = title;
    _label.text = title;
}

@end
