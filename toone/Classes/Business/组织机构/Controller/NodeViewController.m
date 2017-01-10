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


@interface NodeViewController ()<TreeTableCellDelegate>
//数据存储
@property (nonatomic, strong) NSMutableArray *channs;
//递归添加
@property (nonatomic, strong) NSMutableArray *channArr;
@property (nonatomic, strong) Node *node;
@property (nonatomic, strong) TreeTableView *treeTableView;

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
    [Tools showActivityToView:self.view];
    __weak typeof(self) weakSelf = self;
    [nodeMode channelBlock:^(NSArray *result) {
        for (int i = 0; i < result.count; i++) {
            
            weakSelf.node = [[Node alloc] init];
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
            Node *node = _channs[i];
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
        
        
        TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), Screen_h-64) withData:_channArr];
        
        tableview.backgroundColor = [UIColor clearColor];
        tableview.treeTableCellDelegate = self;
        tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:tableview];
        
        self.treeTableView = tableview;
        
        [Tools removeActivity];
        
    }];
    
}


#pragma mark - 分层级
-(void)clearLevel:(Node *)nodeObj array:(NSMutableArray *)array num:(int)num level:(int *)level {
    
    Node *mode = array[num];
    if ([nodeObj.parentId  isEqualToString:mode.nodeId]) {
        
        Node *noode = [[Node alloc] init];
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

@end
