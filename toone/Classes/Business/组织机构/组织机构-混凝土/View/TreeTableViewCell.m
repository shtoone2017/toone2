//
//  TreeTableViewCell.m
//  TreeTableView
//
//  Created by Meonardo on 16/3/18.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "TreeTableViewCell.h"
#import "Node.h"

@implementation TreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    Node *nodeName = [[Node alloc] init];
//    NSLog(@"%@",nodeName.name);
}

- (void)layoutSubviews // 每次删除或者插入cell时 将 缩进 * level = 得到的值给contentView 的frame, 尽量不要在创建cell的时候, 同时在上面出创建新的视图,
{
    [super layoutSubviews];
    
    CGFloat indentPoints = self.indentationLevel * self.indentationWidth;
    self.contentView.frame = CGRectMake(indentPoints,
                                        self.contentView.frame.origin.y,
                                        self.contentView.frame.size.width - indentPoints,
                                        self.contentView.frame.size.height);
}

@end
