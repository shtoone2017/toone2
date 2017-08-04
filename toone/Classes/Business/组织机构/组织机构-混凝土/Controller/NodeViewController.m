//
//  NodeViewController.m
//  toone
//
//  Created by shtoone on 16/12/9.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "NodeViewController.h"
#import "Node.h"
#import "TreeTableView.h"
#import "NodeMode.h"
#import "LevelModel.h"

#define levelLength 3
@interface NodeViewController ()<TreeTableCellDelegate>
//数据存储
@property (nonatomic, strong) NSMutableArray *channs;
//递归添加
@property (nonatomic, strong) NSMutableArray *channArr;
@property (nonatomic, strong) Node *node;
@property (nonatomic, strong) TreeTableView *treeTableView;

@property (nonatomic, strong) LevelModel *leveModel;
@property (nonatomic,strong) NSMutableArray *originalDataArr;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end
@implementation NodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithData];
    
    
}
-(void)cellClick:(Node *)node didReachToBottom:(BOOL)reached {
    if (reached) {
        if (self.callBlock) {
            self.callBlock();
        }
        [self.navigationController  popViewControllerAnimated:YES];
    }
}

#pragma mark - 组织机构
-(void)initWithData {
    NodeMode *nodeMode = [[NodeMode alloc] init];
    __weak typeof(self) weakSelf = self;
    [nodeMode channelBlock:^(NSArray *result) {
        for (int i = 0; i < result.count; i++) {
            weakSelf.node = [[Node alloc] init];
//            weakSelf.node.parentId = (NSString *)[result[i] valueForKey:@"parentdepartid"];
//            weakSelf.node.name = (NSString *)[result[i] valueForKey:@"departname"];
//            weakSelf.node.nodeId = [result[i] valueForKey:@"ID"];
            
            weakSelf.node.parentId = (NSString *)[result[i] valueForKey:@"parentNo"];
            weakSelf.node.name = (NSString *)[result[i] valueForKey:@"projectName"];
            weakSelf.node.nodeId = [result[i] valueForKey:@"projectNo"];
            
            weakSelf.leveModel = [[LevelModel alloc] init];
            weakSelf.leveModel.parentNo = (NSString *)[result[i] valueForKey:@"parentNo"];
            weakSelf.leveModel.projectName = (NSString *)[result[i] valueForKey:@"projectName"];
            weakSelf.leveModel.projectNo = [result[i] valueForKey:@"projectNo"];
            [weakSelf.originalDataArr addObject:weakSelf.leveModel];
            
            [weakSelf.channs addObject:weakSelf.node];
        }
//        [self processData];
        int level = 0;
        for (int i = 0; i < weakSelf.channs.count; i++) {
            level = 0;
            if ([[weakSelf.channs[i] parentId]  isEqual: @""]) {
                level = 0;
            }else {
                //分层级
                [weakSelf clearLevel:weakSelf.channs[i] array:weakSelf.channs num:0 level:&level];
            }
            Node *node = _channs[i];
            node.expand = true;
            node.depth = level;
        }
        for (int i = 0; i < weakSelf.channs.count; i++) {
            if ([[weakSelf.channs[i] parentId]  isEqual: @""] || ![weakSelf.channs[i] parentId]) {
                [weakSelf.channArr addObject:_channs[i]];
            }
        }
        
        long arrCount = _channArr.count;
        
        for (int i = 0; i < arrCount; i++) {
            //            递归添加子节点
            [self addNode:_channArr[i] arry:_channs arryNode:_channArr];
        }
        
        
        TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-100) withData:_channArr];
        
        tableview.backgroundColor = [UIColor clearColor];
        tableview.bounces = NO;
        tableview.treeTableCellDelegate = self;
        tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:tableview];
        self.treeTableView = tableview;
    }];
}
#pragma mark - 分层级
-(void)clearLevel:(Node *)nodeObj array:(NSMutableArray *)array num:(int)num level:(int *)level {
    Node *mode = array[num];
    if ([nodeObj.parentId  isEqualToString:mode.nodeId]) {
        Node *noode = [[Node alloc] init];
        noode.nodeId = [array[num] nodeId];
        noode.parentId = [array[num] parentId];
        noode.name = [array[num] name];
        (*level)++;
        num = 0;
        
        [self clearLevel:noode array:array num:num level:level];
    }else {
        
        if(!nodeObj.parentId || [nodeObj.parentId isEqualToString:@""]){
            
            return;
        }else{
            num++;
            [self clearLevel:nodeObj array:array num:num level:level];
        }
    }
}


#pragma mark - 添加节点
-(void)addNode:(Node *)fristNode arry:(NSArray *)arry arryNode:(NSMutableArray *)arryNode {
    
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
#pragma mark - 测试--

- (void)processData
{
    //获取当前数据中最高等级
    LevelModel *firstModel = _originalDataArr[0];
    NSInteger longestLevel = firstModel.projectNo.length/levelLength;
    
    for (int i = 0; i<_originalDataArr.count; i++)
    {
        LevelModel *model = _originalDataArr[i];
        
        NSInteger level = model.projectNo.length/levelLength;
        if (longestLevel < level)
        {
            longestLevel = level;
        }
    }
    //根据最高等级,将数据分级
    NSMutableArray *levelArr = [NSMutableArray array];
    for (int i = 0; i<longestLevel; i++)
    {
        NSMutableArray *tempArr = [NSMutableArray array];
        [levelArr addObject:tempArr];
    }
    
    for (LevelModel *model in _originalDataArr)
    {
        NSInteger level = model.projectNo.length/levelLength;
        NSMutableArray *tempArr = levelArr[level-1];
        [tempArr addObject:model];
        [levelArr setObject:tempArr atIndexedSubscript:level-1];
    }
    
    for (int i = 0; i<levelArr.count-1; i++)
    {
        for (LevelModel *model in levelArr[i])
        {
            NSMutableArray *tempArr = [NSMutableArray array];
            for (LevelModel *nextLevelModel in levelArr[i+1])
            {
                if ([model.projectNo isEqualToString:nextLevelModel.parentNo])
                {
                    [tempArr addObject:nextLevelModel];
                }
            }
            model.data = tempArr;
        }
    }
}
- (NSMutableArray *)originalDataArr
{
    if (!_originalDataArr)
    {
        _originalDataArr = [NSMutableArray array];
    }
    return _originalDataArr;
}

@end
