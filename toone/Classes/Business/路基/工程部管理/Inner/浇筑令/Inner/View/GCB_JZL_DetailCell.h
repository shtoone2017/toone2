//
//  GCB_JZL_DetailCell.h
//  toone
//
//  Created by 上海同望 on 2017/8/21.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCB_JZL_DetailModel;
@interface GCB_JZL_DetailCell : UITableViewCell
@property (nonatomic,strong) GCB_JZL_DetailModel *model;//编辑
@property (nonatomic,strong) GCB_JZL_DetailModel *xzmodel;//新增

@property (nonatomic,assign) NSInteger isbjti;//1 新增 2 编辑
-(void)loadModel:(GCB_JZL_DetailModel *)model :(NSString *)name;
@end
