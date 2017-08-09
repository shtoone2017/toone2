//
//  NodeViewController.h
//  toone
//
//  Created by shtoone on 16/12/9.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger,NodeType) {
    NodeTypeZZJG = 0,
    NodeTypeCL,
};

@interface NodeViewController : ViewController
@property (nonatomic,copy) void(^callBlock)();

@property (nonatomic,assign) NSInteger type;

@end
