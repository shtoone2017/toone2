
//
//  Exp3View.m
//  toone
//
//  Created by 十国 on 16/12/1.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exp3View.h"
#import "SYS_testTypeModel.h"
#import "SYS_SB_Model.h"
#define CELL_HEIGHT 30.0

@interface Exp3View()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * datas;

@end
@implementation Exp3View

/*
 实验室 设备
 */

-(instancetype)initWithSBJson:(id)json frame:(CGRect)frame {
    if ([json isKindOfClass:[NSArray class]]) {
        NSMutableArray * datas = [NSMutableArray array];
        for (NSDictionary * dict in json) {
            SYS_SB_Model * model = [SYS_SB_Model modelWithDict:dict];
            [datas addObject:model];
        }
        self.datas = datas;
    }
    
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h =  (self.datas.count > 5 ? 5 :self.datas.count)*CELL_HEIGHT;
    if (self = [super initWithFrame:CGRectMake(x, y, w, h)]) {
        [self ui];
    }
    return self;
}
-(void)ui{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    tableView.rowHeight = CELL_HEIGHT;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SB"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SB" forIndexPath:indexPath];
    SYS_SB_Model * model = self.datas[indexPath.row];
    cell.textLabel.text = model.banhezhanminchen;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor black75PercentColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FuncLog;
    SYS_SB_Model * model = self.datas[indexPath.row];
    if (_exp3ViewBlock) {
        _exp3ViewBlock(model.banhezhanminchen,model.gprsbianhao);
    }
    
    self.exp3ViewBlock = nil;
    [self removeFromSuperview];
    [self.layer removeFromSuperlayer];
}
-(void)dealloc{
    FuncLog;
}
@end
