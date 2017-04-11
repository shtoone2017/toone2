//
//  HTTP.h
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    GET,
    POST,
    PUT
}HTTPRequestMethod;

typedef void(^successBlock_t)(id json);
typedef void(^failureBlock_t)(NSError* error);
//typedef void(^bodyBlock_t)();
@interface HTTP : NSObject

+(HTTP*)shareAFNNetworking;

-(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock;

-(void)uploadWithUrlstring:(NSString*)urlString  parameter:(NSDictionary*)parameter data:(NSData*)data success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock;


+(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock;
@end
