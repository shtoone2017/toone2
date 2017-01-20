//
//  LqTreeTableView.h
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LqNode;

@protocol LqTreeTableCellDelegate <NSObject>

/** 点击哪个节点的代理方法.
 @param node 传出来的数据模型.
 @param reached 是否到达叶子节点(YES 为到达了, 你可以进行push 之类操作).
 */
-(void)cellClick:(LqNode *)node didReachToBottom:(BOOL)reached;

@end

@interface LqTreeTableView : UITableView
@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（部分数据）

@property (nonatomic , weak) id<LqTreeTableCellDelegate> LqTreeTableCellDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData : (id )data;

@property (nonatomic, strong) LqNode *nodeNada;

@end
