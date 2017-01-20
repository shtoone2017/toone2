//
//  LqNodeModel.h
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LqNodeBlock)(NSArray *result);

@interface LqNodeModel : NSObject

@property (nonatomic, copy) NSString *departname;//节点名称
@property (nonatomic, copy) NSString *ID;//组织机构id
//@property (nonatomic, copy) NSString *description;//对组织机构的描述
@property (nonatomic, copy) NSString *parentdepartid;//父节点id

@property (nonatomic, strong) NSArray *channel;

-(void)lqNodeBlock:(LqNodeBlock)lqNodeBlock;
@end
