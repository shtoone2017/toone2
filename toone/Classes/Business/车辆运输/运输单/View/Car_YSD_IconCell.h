//
//  Car_YSD_IconCell.h
//  toone
//
//  Created by 上海同望 on 2017/10/17.
//  Copyright © 2017年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car_YSD_IconCell;

@protocol Car_YSD_IconCellDelegate <NSObject>
@optional
- (void)didClickImage:(UIImage *)image Car_YSD_IconCell:(Car_YSD_IconCell *)iconCell;

@end

@interface Car_YSD_IconCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (nonatomic, weak) id<Car_YSD_IconCellDelegate> delegate;



@end
