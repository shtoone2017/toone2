//
//  TP_NYSDList_Cell.m
//  toone
//
//  Created by shtoone on 17/4/26.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "TP_NYSDList_Cell1.h"
#import "TP_NYSDList_Model.h"

@interface TP_NYSDList_Cell1()
@property (weak, nonatomic) IBOutlet UILabel *LabelText;

@end
@implementation TP_NYSDList_Cell1

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setLabel:(NSString *)text {
    if (text) {
        self.LabelText.text = text;
    }
}

@end
