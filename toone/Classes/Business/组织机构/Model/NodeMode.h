//
//  NodeMode.h
//  TreeTableView
//
//  Created by shtoone on 16/11/29.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChannelBlock)(NSArray *result);
@interface NodeMode : NSObject
//节点名称
@property (nonatomic, copy) NSString*departname;
//父节点id
@property (nonatomic, copy) NSString*parentdepartid;
//本节点id
@property (nonatomic, copy) NSString*ID;

@property (nonatomic, copy) NSString*success;


@property (nonatomic, strong) NSArray*channel;

-(void)channelBlock:(ChannelBlock)channelBlock;

@end
