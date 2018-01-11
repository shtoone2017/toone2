//
//  InputController.m
//  toone
//
//  Created by 上海同望 on 2018/1/10.
//  Copyright © 2018年 shtoone. All rights reserved.
//

#import "InputController.h"

@interface InputController ()
@property (nonatomic, weak) UITextField *textField;

@end
@implementation InputController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    [self loadUI];
    [self setRightBut];
}

-(void)loadUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 84, Screen_w, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    UITextField *textFile = [[UITextField alloc] init];
    textFile.frame = CGRectMake(10, 8, Screen_w, 30);
    textFile.borderStyle = UITextBorderStyleNone;
    textFile.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView addSubview:textFile];
    self.textField = textFile;
    _textField.placeholder = @"请输入";
    if (_oldString) {
        _textField.text = _oldString;
    }
    [textFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark - 保存按钮
-(void) setRightBut {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
-(void)editClick:(UITextField *)sender {
    if (self.callBlock) {
        self.callBlock(_textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)textFieldDidChange:(id)sender {
    //    UITextField *_field = (UITextField *)sender;
    
    //    NSLog(@"%@",[_field text]);
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
