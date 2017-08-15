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

//#define levelLength 3
@interface NodeViewController ()<TreeTableCellDelegate>
{
    NSString *selectName;
    NSString *selectId;
}

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
    self.view.backgroundColor = [UIColor whiteColor];
    if (_type == NodeTypeCL)
    {
        [self getDataOfMaterial];
    }
    if (_type == NodeTypeFBFX)//分部分项
    {
        [self initWithFbfx];
    }
     if(_type == NodeTypeZZJG)
    {
        [self initWithData];
    }
    
    [self addButton];
}
-(void)addButton {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(cellClick)];
    rightBarItem.tintColor = [UIColor wheatColor];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}
-(void)cellClick:(Node *)node didReachToBottom:(BOOL)reached {
    if (reached) {
        
    }
}
-(void)cellClick {
    if (_type == NodeTypeCL)
    {
        if (self.CLBlock)
        {
            self.CLBlock(selectName, selectId);
        }
    }
    if (_type == NodeTypeFBFX)
    {
        if (self.FBFXBlock)
        {
            self.FBFXBlock(selectId);
        }
    }
    
    if(_type == NodeTypeZZJG)
    {
        if (self.ZZJGBlock)
        {
            self.ZZJGBlock(selectName, selectId);
        }
    }
    
    [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark - 组织机构
-(void)initWithData {
    NodeMode *nodeMode = [[NodeMode alloc] init];
    __weak typeof(self) weakSelf = self;
    [nodeMode channelBlock:^(NSArray *result) {
        for (int i = 0; i < result.count; i++) {
            weakSelf.node = [[Node alloc] init];
            weakSelf.node.parentId = (NSString *)[result[i] valueForKey:@"parentdepartid"];
            weakSelf.node.name = (NSString *)[result[i] valueForKey:@"departname"];
            weakSelf.node.nodeId = [result[i] valueForKey:@"ID"];
            [weakSelf.channs addObject:weakSelf.node];
        }
        
        [weakSelf setUpUI];
    }];
}
#pragma mark - 分部分项
-(void)initWithFbfx {
    [Tools showActivityToView:self.view];
    NSString *orgCode = @"";
    NSString *urlString = [NSString stringWithFormat:AppPartial,orgCode];
    __weak typeof(self) weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        NSArray *dictArr = dict[@"data"];
        for (int i = 0; i < dictArr.count; i++) {
            NSDictionary *modelDic = dictArr[i];
            weakSelf.node = [[Node alloc] init];
            
            if ([[modelDic valueForKey:@"parentNo"] isKindOfClass:[NSNull class]]) {
                weakSelf.node.parentId = @"";
            }else {
                weakSelf.node.parentId = (NSString *)[modelDic valueForKey:@"parentNo"] ? :@"";
            }
            weakSelf.node.name = (NSString *)[modelDic valueForKey:@"projectName"];
            weakSelf.node.nodeId = [modelDic valueForKey:@"projectNo"];
            [weakSelf.channs addObject:weakSelf.node];
        }
        [weakSelf setUpUI];
        [Tools removeActivity];
    }];
}

//材料名称结构
- (void)getDataOfMaterial
{
    NSString *urlString = [NSString stringWithFormat:@"%@appWZproject.do?AppCaiLiaoNameDict",baseUrl];
    __weak typeof(self) weakSelf = self;
    [[NetworkTool sharedNetworkTool] getObjectWithURLString:urlString completeBlock:^(id result) {
        
        NSDictionary *dict = (NSDictionary *)result;
        
        NSArray *dictArr = dict[@"data"];
        
         for (int i = 0; i < dictArr.count; i++) {
             NSDictionary *modelDic = dictArr[i];
             weakSelf.node = [[Node alloc] init];
             if ([[modelDic valueForKey:@"parentnode"] isKindOfClass:[NSNull class]])
             {
                 weakSelf.node.parentId = @"";
             }
             else{
                 weakSelf.node.parentId = (NSString *)[modelDic valueForKey:@"parentnode"] ? :@"";
             }
             
             weakSelf.node.name = (NSString *)[modelDic valueForKey:@"cailiaoname"];
             weakSelf.node.nodeId = [modelDic valueForKey:@"cailiaono"];
             [weakSelf.channs addObject:weakSelf.node];
         
         }
        [weakSelf setUpUI];
    }];
}


- (void)setUpUI
{
    int level = 0;
    for (int i = 0; i < self.channs.count; i++) {
        level = 0;
        if ([[self.channs[i] parentId]  isEqual: @""]) {
            level = 0;
        }else {
            //分层级
            [self clearLevel:self.channs[i] array:self.channs num:0 level:&level];
        }
        Node *node = _channs[i];
        node.depth = level;
        if (!node.depth) {
            node.expand = true;
        }
    }
    for (int i = 0; i < self.channs.count; i++) {
        if ([[self.channs[i] parentId]  isEqual: @""] || ![self.channs[i] parentId]) {
            [self.channArr addObject:_channs[i]];
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
    tableview.block = ^(NSString *name, NSString *identifier) {
        selectName = name;
        selectId = identifier;
    };
    
    [self.view addSubview:tableview];
    self.treeTableView = tableview;
    
}

#pragma mark - 分层级
-(void)clearLevel:(Node *)nodeObj array:(NSMutableArray *)array num:(int)num level:(int *)level {
    Node *mode = array[num];
    if([nodeObj.parentId isEqualToString:@""]){
        return;
    }else{
        if ([nodeObj.parentId  isEqualToString:mode.nodeId]) {
            Node *noode = [[Node alloc] init];
            noode.nodeId = [array[num] nodeId];
            noode.parentId = [array[num] parentId];
            noode.name = [array[num] name];
            (*level)++;
            num = 0;
            
            [self clearLevel:noode array:array num:num level:level];
        }else {
            if ([nodeObj.parentId isEqualToString:@""]) {
                return;
            }else {
                num++;
                [self clearLevel:nodeObj array:array num:num level:level];
            }
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
