//
//  MyTableViewController.m
//  toone
//
//  Created by shtoone on 17/1/9.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

@end
@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)reloadData:(NSString *) urlString{
    NSLog(@"MyTableViewController~reloadData");
}
-(NSString *)startTime{
    if (!_startTime) {
        //self.startTime = [TimeTools time_3_monthsAgo];
        self.startTime = [UserDefaultsSetting shareSetting].startTime;
    }
    return _startTime;
}
-(NSString *)endTime{
    if (!_endTime) {
//        self.endTime = [TimeTools currentTime];
         self.endTime = [UserDefaultsSetting shareSetting].endTime;
    }
    return _endTime;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
