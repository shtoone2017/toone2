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
    NodeTypeFBFX,//分部分项
};

@interface NodeViewController : ViewController
@property (nonatomic,copy) void(^ZZJGBlock)(NSString *name,NSString *identifier);

@property (nonatomic,copy) void(^CLBlock)(NSString *name,NSString *identifier);
@property (nonatomic,copy) void(^FBFXBlock)(NSString *identifier,NSString *name);//分部分项


@property (nonatomic,assign) NSInteger type;

@end
