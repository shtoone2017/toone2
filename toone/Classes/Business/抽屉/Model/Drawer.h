//
//  Drawer.h
//  toone
//
//  Created by 十国 on 16/11/23.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

//yi屉
@interface Drawer : NSObject


@property (nonatomic,copy) NSString * icon;
@property (nonatomic,copy) NSString * title;


-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)drawerWithDict:(NSDictionary*)dict;
+(NSArray*)datas;
@end
