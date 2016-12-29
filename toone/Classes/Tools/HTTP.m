//
//  HTTP.m
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HTTP.h"
#import "AFNetworking.h"
@interface HTTP ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation HTTP

static HTTP *networking = nil;
+(HTTP*)shareAFNNetworking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[HTTP alloc] init];
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20;
//        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration]   ;
//        manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        networking .manager =manager;
    });
    return networking;
}

-(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{

    NSString *encodePath ;
    encodePath = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];//iOS7.0以后url编码
    switch (method) {
        case GET:{
            [self.manager GET:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case POST:{
            [self.manager POST:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
        }
        case PUT:{
            [self.manager PUT:encodePath parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
        }
    }
}


/*
 单张
 */
-(void)uploadWithUrlstring:(NSString*)urlString  parameter:(NSDictionary*)parameter data:(NSData*)data success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
   self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",                            
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [self.manager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
