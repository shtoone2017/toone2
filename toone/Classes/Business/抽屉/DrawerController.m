//
//  DrawerController.m
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "DrawerController.h"
#import "Drawer.h"
#import "DrawerHeaderImgv.h"

@interface DrawerController ()
@property (nonatomic,strong) DrawerHeaderImgv * imgv;

@property (nonatomic,strong)  NSArray * datas;

@property (nonatomic,strong) UIControl * control;
@end

@implementation DrawerController

-(NSArray *)datas{
    if (!_datas) {
        self.datas = [Drawer datas];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    DrawerHeaderImgv * imgv = [[DrawerHeaderImgv alloc] initWithFrame:CGRectMake(0, -253, Drawer_w, 253)];
    imgv.image = [UIImage imageNamed:@"bg_head_personal_center.png"];
    imgv.contentMode = UIViewContentModeScaleAspectFill;
    self.imgv = imgv;
    
    
    [self.tableView insertSubview:self.imgv atIndex:0];
    
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DrawerController"];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
////    NSLog(@"%f",scrollView.contentOffset.y);-
//    //计算往下拖拽的距离
//    CGFloat dragDelta = -(253) - scrollView.contentOffset.y;
//    if(dragDelta < 0){ //如果dragDelta＜0，说明，tableview向上拖动
//        dragDelta = 0;
//    }
//    //设置imageview的高度
//    if (dragDelta>80) return;//图的原因。。。。。
//    self.imgv.height = (253) + dragDelta;
//}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrawerController" forIndexPath:indexPath];
    Drawer * drawer = self.datas[indexPath.section][indexPath.row];
    cell.textLabel.text = drawer.title;
    cell.imageView.image = [UIImage imageNamed:drawer.icon];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //移除
    [self remove];
    //
    Drawer * drawer = self.datas[indexPath.section][indexPath.row];
    if (EqualToString(@"退出账号", drawer.title)) {
        id vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [[UIApplication sharedApplication].keyWindow.layer addTransitionWithType:@"fade"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [UserDefaultsSetting shareSetting].login = NO;
            [[UserDefaultsSetting shareSetting] saveToSandbox];
        });
    }
    
    if(EqualToString(@"版本", drawer.title)){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200ull*NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            NSString * address = @"https://www.pgyer.com/X6Vv";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
        });
    }
}

-(void)dealloc{
    FuncLog;
}
-(UIControl *)control{
    if (!_control) {
        UIControl * con =  [[UIControl alloc] initWithFrame:CGRectMake(0, 0, Screen_w, Screen_h)];
        con.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        con.alpha = 0.2;
        con.tag = 2;
        [con addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        self.control = con;
    }
    return _control;
}
-(void)show{
    
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    self.control.hidden = YES;
    [window addSubview:self.control];
    
    CGFloat x = -Drawer_w;
    CGFloat y = 0;
    CGFloat w = Drawer_w;
    CGFloat h = Screen_h;
    self.view.frame = CGRectMake(x, y, w, h);
    [window addSubview:self.view];
    
    [UIView animateWithDuration:0.20 animations:^{
        self.view.x = 0;
    }completion:^(BOOL finished) {
        self.control.hidden = NO;
        window.userInteractionEnabled = YES;
    }];
   

}
-(void)remove{
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    self.control.hidden = YES;
    window.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.35 animations:^{
        self.view.x = -Drawer_w;
    } completion:^(BOOL finished) {
        [self.control removeFromSuperview];
        [self.tableView removeFromSuperview];
        window.userInteractionEnabled = YES;
    }];
}
@end
