//
//  LqNode.h
//  toone
//
//  Created by shtoone on 16/12/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LqNode : NSObject

@property (nonatomic , copy) NSString *parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , copy) NSString *nodeId;//本节点的id

@property (nonatomic , copy) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态


@end
