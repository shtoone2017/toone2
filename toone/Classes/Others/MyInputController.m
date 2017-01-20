//
//  MyInputController.m
//  toone
//
//  Created by shtoone on 17/1/4.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyInputController.h"
#import "DayQueryModel.h"

@interface MyInputController ()
@property (nonatomic, weak) UITextField *textField;

@end
@implementation MyInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请输入";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [self setRightBut];
    [self addTextF];
}

#pragma mark - 监听文本框
-(void)addTextF {
    UITextField *textFile = [[UITextField alloc] init];
    textFile.frame = CGRectMake(10, 70, Screen_w-20, 30);
    textFile.borderStyle = UITextBorderStyleNone;
    textFile.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textFile];
    self.textField = textFile;
    [textFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        switch (self.index) {
                        case 0:
                            break;
                        case 1:
                            break;
                        case 2:
                            break;
                        case 3:
                           textFile.placeholder = self.model.dailyxzcl;
                            break;
                        case 4:
                           textFile.placeholder = self.model.dailymd;
//                            alertController.title = @"标准密度(kg/m2)";
                            break;
                        case 5:
                           textFile.placeholder = self.model.dailybuwei;
//                            alertController.title = @"施工桩号";
                            break;
                        case 6:
                           textFile.placeholder = self.model.dailycd;
//                            alertController.title = @"长度(m)";
                            break;
                        case 7:
                           textFile.placeholder = self.model.dailykd;
//                            alertController.title = @"宽度(m)";
                            break;
                        case 8:
                            break;
                        case 9:
                           textFile.placeholder = self.model.dailysjhd;
//                            alertController.title = @"实际厚度";
                            break;
                        case 10:
                           textFile.placeholder = self.model.dailyxh;
//                            alertController.title = @"型号";
                            break;
                        case 11:
                           textFile.placeholder = self.model.dailybeizhu;
//                            alertController.title = @"备注";
                            break;
                        default:
                            break;
                    }
}
- (void)textFieldDidChange:(id)sender {
//    UITextField *_field = (UITextField *)sender;
    
//    NSLog(@"%@",[_field text]);
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark - 保存按钮
-(void) setRightBut {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)editClick:(UIBarButtonItem *)sender {
    switch (self.index) {
                        case 0:
                            break;
                        case 1:
                            break;
                        case 2:
                            break;
                        case 3:
                            self.model.dailyxzcl = self.textField.text;
                            break;
                        case 4:
                            self.model.dailymd = self.textField.text;
                            break;
                        case 5:
                            self.model.dailybuwei = self.textField.text;
                            break;
                        case 6:
                            self.model.dailycd = self.textField.text;
                            break;
                        case 7:
                            self.model.dailykd = self.textField.text;
                            break;
                        case 8:
                            break;
                        case 9:
                            self.model.dailysjhd = self.textField.text;
                            break;
                        case 10:
                            self.model.dailyxh = self.textField.text;
                            break;
                        case 11:
                            self.model.dailybeizhu = self.textField.text;
                            break;
                        default:
                            break;
                    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
