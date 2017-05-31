//
//  SW_ZZJG_Controller.m
//  toone
//
//  Created by sg on 2017/3/13.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "SW_ZZJG_Controller.h"

#import "SW_ZZJG_Cell.h"
@interface SW_ZZJG_Controller () <RATreeViewDelegate, RATreeViewDataSource>
@property (strong, nonatomic) NSArray *datas;
@property (weak, nonatomic) RATreeView *treeView;
@end

@implementation SW_ZZJG_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTree];
    [self loadData];
}
-(void)loadData{
    [Tools showActivityToView:self.view];
    NSString * urlString = departTree;
    NSDictionary * dict = @{@"userType":[UserDefaultsSetting_SW shareSetting].userType,
                            @"biaoshiid":[UserDefaultsSetting_SW shareSetting].biaoshi,
                            @"modelType":self.modelType,
                            };
    __weak typeof(self)  weakSelf = self;
    
    [[HTTP shareAFNNetworking] requestMethod:GET urlString:urlString parameter:dict success:^(id json) {
        NSMutableArray * datas = [NSMutableArray array];
        //业主：1  标段：2  项目部：3  拌合站：5
        if ([json[@"success"] boolValue]) {
            
            if ([[UserDefaultsSetting_SW shareSetting].userType isEqualToString:@"1"]) {
                if ([json[@"userGroup"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dict in json[@"userGroup"]) {
                        SW_ZZJG_Data * yz = [[SW_ZZJG_Data alloc] init];
                        yz.name = dict[@"userGroupId"];
//                        yz.departType = @"1";
                        [datas addObject:yz];
                    }
                }
                
                if ([json[@"biaoduan"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"biaoduan"]) {
                        SW_ZZJG_Data * biaoduan = [[SW_ZZJG_Data alloc] init];
                        biaoduan.name = dict[@"biaoduanminchen"];
                        biaoduan.biaoshiid = Format(dict[@"id"]);
                        biaoduan.departType = @"2";
//                        [datas addObject:biaoduan];
                        for (SW_ZZJG_Data *yz in datas) {
                            if (!yz.children) {
                                yz.children = [NSMutableArray array];
                            }
                            [yz addChild:biaoduan];
                        }
                    }
                }
                
                if ([json[@"xmb"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"xmb"]) {
                        SW_ZZJG_Data * xmb = [[SW_ZZJG_Data alloc] init];
                        xmb.name = dict[@"xiangmubuminchen"];
                        xmb.biaoshiid = Format(dict[@"id"]);
                        xmb.departType = @"3";
                        NSString * parentId = Format(dict[@"biaoduanid"]);
                        for (SW_ZZJG_Data *yz in datas) {
                            for (SW_ZZJG_Data * bianDuan in yz.children) {
                                if ([bianDuan.biaoshiid isEqualToString:parentId]) {
                                    if (!bianDuan.children) {
                                        bianDuan.children = [NSMutableArray array];
                                    }
                                    [bianDuan addChild:xmb];
                                }
                            }
                        }
                        
                    }
                }
                
                if ([json[@"bhz"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"bhz"]) {
                        SW_ZZJG_Data * bhz = [[SW_ZZJG_Data alloc] init];
                        bhz.name = dict[@"banhezhanminchen"];
                        bhz.biaoshiid = Format(dict[@"id"]);
                        bhz.departType = @"5";
                        bhz.shebeibianhao = dict[@"shebeibianhao"];
                        NSString * parentId  = Format(dict[@"xiangmubuid"]);
                        for (SW_ZZJG_Data * yz in datas) {
                            for (SW_ZZJG_Data * bianDuan in yz.children) {
                                for ( SW_ZZJG_Data *xmb in bianDuan.children) {
                                    if ([xmb.biaoshiid isEqualToString:parentId]) {
                                        if (!xmb.children) {
                                            xmb.children = [NSMutableArray array];
                                        }
                                        [xmb addChild:bhz];
                                    }
                                }
                            }
                        }
                        
                    }
                }
                
            }//1
            if ([[UserDefaultsSetting_SW shareSetting].userType isEqualToString:@"3"]) {
                if ([json[@"xmb"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"xmb"]) {
                        SW_ZZJG_Data * xmb = [[SW_ZZJG_Data alloc] init];
                        xmb.name = dict[@"xiangmubuminchen"];
                        xmb.biaoshiid = Format(dict[@"id"]);
                        xmb.departType = @"3";
                        [datas addObject:xmb];
                    }
                }
                
                if ([json[@"bhz"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"bhz"]) {
                        SW_ZZJG_Data * bhz = [[SW_ZZJG_Data alloc] init];
                        bhz.name = dict[@"banhezhanminchen"];
                        bhz.biaoshiid = Format(dict[@"id"]);
                        bhz.departType = @"5";
                        bhz.shebeibianhao = dict[@"shebeibianhao"];
                        NSString * parentId = Format(dict[@"xiangmubuid"]);
                        for (SW_ZZJG_Data * xmb in datas) {
                            if ([xmb.biaoshiid isEqualToString:parentId]) {
                                if (!xmb.children) {
                                    xmb.children = [NSMutableArray array];
                                }
                                [xmb addChild:bhz];
                            }
                        }
                    }
                }
                
            }//3
            if ([[UserDefaultsSetting_SW shareSetting].userType isEqualToString:@"2"] || [[UserDefaultsSetting_SW shareSetting].userType isEqualToString:@"5"] || [[UserDefaultsSetting_SW shareSetting].userType isEqualToString:@"6"]) {
                if ([json[@"biaoduan"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"biaoduan"]) {
                        SW_ZZJG_Data * biaoduan = [[SW_ZZJG_Data alloc] init];
                        biaoduan.name = dict[@"biaoduanminchen"];
                        biaoduan.biaoshiid = Format(dict[@"id"]);
                        biaoduan.departType = @"2";
                        [datas addObject:biaoduan];
                    }
                }
                
                if ([json[@"xmb"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"xmb"]) {
                        SW_ZZJG_Data * xmb = [[SW_ZZJG_Data alloc] init];
                        xmb.name = dict[@"xiangmubuminchen"];
                        xmb.biaoshiid = Format(dict[@"id"]);
                        xmb.departType = @"3";
                        NSString * parentId = Format(dict[@"biaoduanid"]);
                        for (SW_ZZJG_Data * bianDuan in datas) {
                            if ([bianDuan.biaoshiid isEqualToString:parentId]) {
                                if (!bianDuan.children) {
                                    bianDuan.children = [NSMutableArray array];
                                }
                                [bianDuan addChild:xmb];
                            }
                        }
                    }
                    
                }
                
                if ([json[@"bhz"] isKindOfClass:[NSArray class]]) {
                    for (NSDictionary * dict in json[@"bhz"]) {
                        SW_ZZJG_Data * bhz = [[SW_ZZJG_Data alloc] init];
                        bhz.name = dict[@"banhezhanminchen"];
                        bhz.biaoshiid = Format(dict[@"id"]);
                        bhz.departType = @"5";
                        bhz.shebeibianhao = dict[@"shebeibianhao"];
                        NSString * parentId  = Format(dict[@"xiangmubuid"]);
                        for (SW_ZZJG_Data * bianDuan in datas) {
                            for (SW_ZZJG_Data * xmb in bianDuan.children) {
                                if ([xmb.biaoshiid isEqualToString:parentId]) {
                                    if (!xmb.children) {
                                        xmb.children = [NSMutableArray array];
                                    }
                                    [xmb addChild:bhz];
                                }
                            }
                        }
                    }
                }
                
            }//2||5||6            
            
        }//success
        
         weakSelf.datas = datas;
        [weakSelf.treeView reloadData];
        [Tools removeActivity];
    } failure:^(NSError *error) {
        
    }];
}
-(void)loadTree{
    RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 64, Screen_w, Screen_h-64) style:RATreeViewStylePlain];
    
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
//    UIRefreshControl *refreshControl = [UIRefreshControl new];
//    [refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.treeView.scrollView addSubview:refreshControl];
    
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    [self.view addSubview:treeView];
    self.treeView = treeView;
    
    
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([SW_ZZJG_Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SW_ZZJG_Cell class])];
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    int systemVersion = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue];
//    if (systemVersion >= 7 && systemVersion < 8) {
//        CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
//        float heightPadding = statusBarViewRect.size.height+self.navigationController.navigationBar.frame.size.height;
//        self.treeView.scrollView.contentInset = UIEdgeInsetsMake(heightPadding, 0.0, 0.0, 0.0);
//        self.treeView.scrollView.contentOffset = CGPointMake(0.0, -heightPadding);
//    }
//    
//    self.treeView.frame = self.view.bounds;
//}


#pragma mark - Actions

//- (void)refreshControlChanged:(UIRefreshControl *)refreshControl
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [refreshControl endRefreshing];
//    });
//}

//- (void)editButtonTapped:(id)sender
//{
//    [self.treeView setEditing:!self.treeView.isEditing animated:YES];
//    [self updateNavigationItemButton];
//}

//- (void)updateNavigationItemButton
//{
//    UIBarButtonSystemItem systemItem = self.treeView.isEditing ? UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit;
//    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:@selector(editButtonTapped:)];
//    self.navigationItem.rightBarButtonItem = self.editButton;
//}


#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}

//- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item
//{
//    return YES;
//}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    SW_ZZJG_Cell *cell = (SW_ZZJG_Cell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    SW_ZZJG_Cell *cell = (SW_ZZJG_Cell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:YES animated:YES];
}

//- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item
//{
//    if (editingStyle != UITableViewCellEditingStyleDelete) {
//        return;
//    }
//    
//    SW_ZZJG_Data *parent = [self.treeView parentForItem:item];
//    NSInteger index = 0;
//    
//    if (parent == nil) {
//        index = [self.datas indexOfObject:item];
//        NSMutableArray *children = [self.datas mutableCopy];
//        [children removeObject:item];
//        self.datas = [children copy];
//        
//    } else {
//        index = [parent.children indexOfObject:item];
//        [parent removeChild:item];
//    }
//    
//    [self.treeView deleteItemsAtIndexes:[NSIndexSet indexSetWithIndex:index] inParent:parent withAnimation:RATreeViewRowAnimationRight];
//    if (parent) {
//        [self.treeView reloadRowsForItems:@[parent] withRowAnimation:RATreeViewRowAnimationNone];
//    }
//}

#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    SW_ZZJG_Data *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"拥有%@个子集", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    SW_ZZJG_Cell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([SW_ZZJG_Cell class])];
    [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(dataObject) weakObj = dataObject;
    cell.additionButtonTapAction = ^(id sender){
        if (weakSelf.zzjgCallBackBlock) {
            weakSelf.zzjgCallBackBlock(weakObj);
        }
        
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    return cell;
}
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.datas count];
    }
    
    SW_ZZJG_Data *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    SW_ZZJG_Data *data = item;
    if (item == nil) {
        return [self.datas objectAtIndex:index];
    }
    
    return data.children[index];
}

@end
