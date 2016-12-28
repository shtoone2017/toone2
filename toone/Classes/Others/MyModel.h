//
//  MyModel.h
//  toone
//
//  Created by 十国 on 16/11/24.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)modelWithDict:(NSDictionary*)dict;
@end
