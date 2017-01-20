//
//  LqNodeViewController.m
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "LqNodeViewController.h"
#import "LqNode.h"
#import "LqNodeModel.h"
#import "LqTreeTableView.h"

@interface LqNodeViewController ()<LqTreeTableCellDelegate>
//数据存储
@property (nonatomic, strong) NSMutableArray *channs;
//递归添加
@property (nonatomic, strong) NSMutableArray *channArr;
@property (nonatomic, strong) LqNode *node;
@property (nonatomic, strong) LqTreeTableView *treeTableView;

@end
@implementation LqNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self initWithData];
}

-(void)cellClick:(LqNode *)node didReachToBottom:(BOOL)reached {
    
    if (reached) {
        if (self.callBlock) {
            self.callBlock();
        }
        [self.navigationController  popViewControllerAnimated:YES];
    }
    
}

#pragma mark - 组织机构
-(void)initWithData {
    LqNodeModel *nodeMode = [[LqNodeModel alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [nodeMode lqNodeBlock:^(NSArray *result) {
        for (int i = 0; i < result.count; i++) {
            
            weakSelf.node = [[LqNode alloc] init];
            weakSelf.node.parentId = (NSString *)[result[i] valueForKey:@"parentdepartid"];
            
            weakSelf.node.name = (NSString *)[result[i] valueForKey:@"departname"];
            
            weakSelf.node.nodeId = [result[i] valueForKey:@"ID"];
            
            [weakSelf.channs addObject:weakSelf.node];
            
        }
        
        int level = 0;
        for (int i = 0; i < weakSelf.channs.count; i++) {
            
            level = 0;
            
            if ([[weakSelf.channs[i] parentId]  isEqual: @""]) {
                
                level = 0;
                
            }else {
                //分层级
                [weakSelf clearLevel:weakSelf.channs[i] array:weakSelf.channs num:0 level:&level];
                
            }
            LqNode *node = _channs[i];
            node.expand = true;
            node.depth = level;
        }
        
        for (int i = 0; i < weakSelf.channs.count; i++) {
            if ([[weakSelf.channs[i] parentId]  isEqual: @""]) {
                [weakSelf.channArr addObject:_channs[i]];
                
            }
        }
        
        long arrCount = _channArr.count;
        
        for (int i = 0; i < arrCount; i++) {
            //            递归添加子节点
            [self addNode:_channArr[i] arry:_channs arryNode:_channArr];
        }
        
        
        LqTreeTableView *tableview = [[LqTreeTableView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-100) withData:_channArr];
        
        tableview.backgroundColor = [UIColor clearColor];
        tableview.bounces = NO;
        tableview.LqTreeTableCellDelegate = self;
        tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:tableview];
        
        self.treeTableView = tableview;
        
    }];
    
}


#pragma mark - 分层级
-(void)clearLevel:(LqNode *)nodeObj array:(NSMutableArray *)array num:(int)num level:(int *)level {
    
    LqNode *mode = array[num];
    if ([nodeObj.parentId  isEqualToString:mode.nodeId]) {
        
        LqNode *noode = [[LqNode alloc] init];
        noode.nodeId = [array[num] nodeId];
        noode.parentId = [array[num] parentId];
        (*level)++;
        num = 0;
        
        [self clearLevel:noode array:array num:num level:level];
    }else {
        
        if([nodeObj.parentId isEqualToString:@""]){
            
            return;
        }else{
            
            num++;
            [self clearLevel:nodeObj array:array num:num level:level];
        }
    }
}


#pragma mark - 添加节点
-(void)addNode:(LqNode *)fristNode arry:(NSArray *)arry arryNode:(NSMutableArray *)arryNode {
    
    for (int i = 0; i < arry.count; i++) {
        if ([fristNode.nodeId isEqualToString:[arry[i] parentId]]) {
            
            [_channArr addObject:arry[i]];
            [self addNode:arry[i] arry:arry arryNode:_channArr];
        }
    }
}


-(NSMutableArray *)channs {
    if (_channs == nil) {
        _channs = [NSMutableArray  array];
    }
    return _channs;
}
-(NSMutableArray *)channArr {
    if (_channArr == nil) {
        _channArr = [NSMutableArray array];
    }
    return _channArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
