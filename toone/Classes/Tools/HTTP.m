//
//  HTTP.m
//  toone
//
//  Created by 十国 on 16/11/22.
//  Copyright © 2016年 shtoone. All rights reserved.
//

#import "HTTP.h"
#import "AFNetworking.h"


@implementation HTTP


static AFHTTPSessionManager *manager = nil;
static HTTP *networking = nil;
+(HTTP*)shareAFNNetworking{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[HTTP alloc] init];
        AFHTTPSessionManager * sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 20;
        
        

//        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration]   ;
//        manager.responseSerializer.acceptableContentTypes =[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        manager =sessionManager;
    });
    return networking;
}

-(void)requestMethod:(HTTPRequestMethod)method urlString:(NSString*)urlString parameter:(NSDictionary*)parameter success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock{

    NSString *encodePath ;
    encodePath = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];//iOS7.0以后url编码
    switch (method) {
        case GET:{
            [manager GET:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSData *resData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:resData options:0 error:nil];
                if (successBlock)
                {
                    successBlock(dic);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case GETS:{
            [manager GET:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSData *resData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
//                NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:resData options:0 error:nil];
                if (successBlock)
                {
                    successBlock(responseStr);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case POST:{
            [manager POST:encodePath parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if (successBlock) successBlock(jsondata);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failureBlock) failureBlock(error);
            }];
            break;
        }
        case PUT:{
            [manager PUT:encodePath parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",                            
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [manager POST:urlString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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


/**
 专用编辑请求
 将json对象(NSData)传入body

 @param paraDic 参数字典
 @param urlString 请求地址
 */
- (void)requestToEditWithDic:(NSDictionary *)paraDic urlStr:(NSString *)urlString  success:(successBlock_t)successBlock failure:(failureBlock_t)failureBlock
{
    WS(weakSelf);
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paraDic options:0 error:&error];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"Reply JSON: %@", responseObject);
            if (responseObject[@"success"])
            {
                if ((NSInteger)responseObject[@"success"] == 1)
                {
                    id jsondata = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                    if (successBlock) successBlock(jsondata);
                    [weakSelf showMessage:@"编辑成功"];
                }
                else
                {
                    [weakSelf showMessage:@"编辑失败"];
                }
            }
            else
            {
                [weakSelf showMessage:@"编辑失败"];
            }
            
            
        } else {
            
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if(failureBlock) failureBlock(error);
        }
        
    }] resume];
}

// show message
- (void)showMessage:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message];
}
@end
