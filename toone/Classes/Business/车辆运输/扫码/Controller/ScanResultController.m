//
//  ScanResultController.m
//  toone
//
//  Created by 上海同望 on 2017/10/18.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "ScanResultController.h"
#import "YYModel.h"
#import "ScanResultCell.h"
#import "Car_ScanModel.h"
#import "ResultIconCell.h"

@interface ScanResultController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UITableView *tb;
@property (nonatomic, strong) Car_ScanModel *Headmodel;
@property (nonatomic,strong) UIImage *filePathImage;

@end
@implementation ScanResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运输单编辑";
    [self loadData];
    [self loadUI];
}

-(void)loadUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(choosePhoto)];
    self.tb.tableFooterView = [[UIView alloc] init];
    self.tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStylePlain];
    self.tb.delegate = self;
    self.tb.dataSource = self;
    [self.view addSubview:self.tb];
    [self.tb registerNib:[UINib nibWithNibName:@"ScanResultCell" bundle:nil] forCellReuseIdentifier:@"ScanResultCell"];
    [self.tb registerNib:[UINib nibWithNibName:@"ResultIconCell" bundle:nil] forCellReuseIdentifier:@"ResultIconCell"];
}

-(void)loadData {
//    NSLog(@"扫码结果 == %@",_result);
    NSData* data = [self.result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        _Headmodel = [Car_ScanModel modelWithDict:dic];
    }
}

-(void)choosePhoto{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"打开一个图片源" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    // 图片选择器
    UIImagePickerController *imgPC = [[UIImagePickerController alloc] init];
    
    //设置代理
    imgPC.delegate = self;
    
    //允许编辑图片
    imgPC.allowsEditing = YES;
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPC animated:YES completion:nil];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPC animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark 图片选择器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取修改后的图片
    self.filePathImage = info[UIImagePickerControllerEditedImage];
    
    [self.tb reloadData];
    //移除图片选择的控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 340;
    }
    if (indexPath.section == 1) {
        return 260;
    }
    return 0.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return @"基本信息";
        case 1:return @"提交照片";
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ScanResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ScanResultCell"];
        Car_ScanModel *model = self.Headmodel;
        cell.model = model;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        ResultIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ResultIconCell"];
        cell.iconImag.image = self.filePathImage;
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }
    return nil;
}


@end
