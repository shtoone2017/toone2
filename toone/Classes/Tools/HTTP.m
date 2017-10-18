//
//  HTTP.m
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HTTP.h"
#import "AFNetworking.h"


static HTTP *networking = nil;
static AFHTTPSessionManager *afnManager = nil;
@implementation HTTP

+(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{
    [self shareAFNNetworking];
    [networking requestMethod:method urlString:urlString parameter:parameter success:successBlock failure:failureBlock];
}


+(HTTP*)shareAFNNetworking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[HTTP alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        afnManager.requestSerializer.timeoutInterval = 20;
    });
    return networking;
}

-(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{
     NSString * encodePath = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];//iOS7.0以后url编码
    switch (method) {
        case GET:{
            [afnManager GET:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case POST:{
            [afnManager POST:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case PUT:{
            [afnManager  PUT:encodePath parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
    }
}


/*
 单张
 */
-(void)uploadWithUrlstring:(NSString*)urlString  parameter:(NSDictionary*)parameter data:(NSData*)data success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{
   afnManager.responseSerializer.acceptableContentTypes = [NSSet               setWithObjects:
                     @"application/json",
                     @"text/html",
                     @"image/jpeg",                            
                     @"image/png",
                     @"application/octet-stream",
                     @"text/json",
                     nil];
    [afnManager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        if (data != nil) {
             [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError * err;
        id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        if (successBlock) successBlock(jsondata);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         if(failureBlock) failureBlock(error);
    }];
}
@end
