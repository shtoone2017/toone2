//
//  LqTreeTableView.m
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LqTreeTableView.h"
#import "LqNode.h"
#import "TheProjectCell.h"

@interface LqTreeTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) NSArray *data;//传递过来已经组织好的数据（全量数据）

@property (nonatomic, assign)NSInteger maxDepth;//节点最深处

@end
@implementation LqTreeTableView
-(instancetype)initWithFrame:(CGRect)frame withData : (id )data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _data = data;
        _tempData = [self createTempData:data];
    }
    return self;
}

/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData : (NSArray *)data{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i=0; i<data.count; i++) {
        LqNode *node = [_data objectAtIndex:i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    
    return tempArray;
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"LqtreeNodeCell";
    UINib *nib = [UINib nibWithNibName:@"TheProjectCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
    TheProjectCell *cell = (TheProjectCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    LqNode *node = [_tempData objectAtIndex:indexPath.row];
    
    // cell有缩进的方法
    cell.LqtreeNode = node;
    cell.cellLabel.text = node.name;
    cell.cellLabel.layer.cornerRadius = 5;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    [cell setNeedsDisplay];
    return cell;
}

#pragma mark - Optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LqNode *node = [_tempData objectAtIndex:indexPath.row];
    
    if ([_LqTreeTableCellDelegate respondsToSelector:@selector(cellClick:didReachToBottom:)]) {
        [_LqTreeTableCellDelegate  cellClick:node didReachToBottom:YES];
    }
    
    self.nodeNada = node;
    [UserDefaultsSetting shareSetting].departName  = node.name;
    [UserDefaultsSetting shareSetting].departId = node.nodeId;
    
}


@end
