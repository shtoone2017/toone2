//
//  Exmp1.m
//  toone
//
//  Created by 十国 on 16/11/21.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "Exmp1.h"
#import "Exmp1Cell.h"
@interface Exmp1 ()


@end

@implementation Exmp1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;
    //测试1.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellid = @"cell";
    Exmp1Cell * cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"test %ld",indexPath.row];
    if (indexPath.row == 0) {
        cell.label.text = @"exit";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            id vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateInitialViewController];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
            
            CATransition * ani = [CATransition animation];
            ani.type = @"rippleEffect";
            ani.removedOnCompletion = NO;
            ani.fillMode = kCAFillModeForwards;
            ani.duration = 2.0;
            [[UIApplication sharedApplication].keyWindow.layer addAnimation:ani forKey:nil];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [UserDefaultsSetting shareSetting].login = NO;
                [[UserDefaultsSetting shareSetting] saveToSandbox];
            });
            break;
        }
            
        default:
            break;
    }
}

-(void)dealloc{
     NSLog(@"Exmp1~~dealloc");
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
