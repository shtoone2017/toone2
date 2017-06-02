//
//  MySegmentedControl.h
//  toone
//
//  Created by 十国 on 16/11/29.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void (^SegBlock_t)(int  tag);

@interface MySYSSegmentedControl : UIView

@property (nonatomic,copy) SegBlock_t segBlock;

-(void)switchToSYS;

@end
