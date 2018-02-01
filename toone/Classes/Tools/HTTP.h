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
    GETS,
    POST,
    PUT
}HTTPRequestMethod;

typedef void(^successBlock_t)(id json);
typedef void(^failureBlock_t)(NSError* error);
typedef void(^bodyBlock_t)();
@interface HTTP : NSObject

+(HTTP*)shareAFNNetworking;

-(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock;



-(void)uploadWithUrlstring:(NSString*)urlString  parameter:(NSDictionary*)parameter data:(NSData*)data success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock;

/**
 专用编辑请求
 将json对象(NSData)传入body
 
 @param paraDic 参数字典
 @param urlString 请求地址
 */
- (void)requestToEditWithDic:(NSDictionary *)paraDic urlStr:(NSString *)urlString  success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlo;
@end
