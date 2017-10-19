//
//  ResultIconCell.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ResultIconCell.h"

@interface ResultIconCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ButTop;



@end
@implementation ResultIconCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ButTop.constant = 10;
    _jsimageView.hidden = YES;
}
- (IBAction)butClick:(UIButton *)sender {
  [UserDefaultsSetting_SW shareSetting].carSubmit = [NSString stringWithFormat:@"%d",arc4random()%1000];
}

-(void)loadTop {
    self.ButTop.constant = 210;
    _jsimageView.hidden = NO;
}


#pragma mark - 提交刷新
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [[UserDefaultsSetting_SW shareSetting] addObserver:self forKeyPath:@"jsicon" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self loadTop];
}
-(void)dealloc{
    [[UserDefaultsSetting_SW shareSetting] removeObserver:self forKeyPath:@"jsicon"];
    FuncLog;
}

@end
