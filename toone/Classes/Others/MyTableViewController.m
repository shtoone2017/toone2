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
    
}
-(NSString *)startTime{
    if (!_startTime) {
        self.startTime = [TimeTools time_3_monthsAgo];
    }
    return _startTime;
}
-(NSString *)endTime{
    if (!_endTime) {
        self.endTime = [TimeTools currentTime];
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
