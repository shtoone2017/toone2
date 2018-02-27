//
//  YS_TJ_Controller.m
//  toone
//
//  Created by 上海同望 on 2018/2/26.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "YS_TJ_Controller.h"
#import "SYS_MAIN_Cell.h"
#import "YS_YLJViewController.h"
#import "YS_TPWDViewController.h"
#import "YS_HD_Controller.h"
#import "YSMJViewController.h"
#import "YS_JLViewController.h"

@interface YS_TJ_Controller ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tbleView;

@end
@implementation YS_TJ_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor snowColor];
    [self loadUI];
}

-(void)loadUI {
    self.tbleView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbleView.delegate =self;
    _tbleView.dataSource = self;
    self.tbleView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tbleView];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *titleArr = @[@"摊铺机",@"压路机",@"压路厚度",@"压实面积",@"压路距离"];
    NSArray *imgArr = @[@"压实",@"压实",@"厚度",@"面积",@"距离1"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED {
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{//摊铺
            YS_TPWDViewController *vc = [YS_TPWDViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{//压路
            YS_YLJViewController *vc = [YS_YLJViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{//厚度
            YS_HD_Controller *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YS_HD_Controller"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{//面积
            YSMJViewController *vc = [YSMJViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:{//距离
            YS_JLViewController *vc = [YS_JLViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}

@end
