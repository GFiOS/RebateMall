//
//  MDAFHelp.m
//  MDSpeedNews
//
//  Created by Medalands on 15/8/26.
//  Copyright (c) 2015年 Medalands. All rights reserved.
//

#import "MDAFHelp.h"


@implementation MDAFHelp

+(AFHTTPRequestOperation *)GET:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *dic =parameters;
    
    if (dic == nil)
    {
        dic = [NSMutableDictionary dictionary];
    }
    // 添加 默认 参数，每个接口 都需要添加
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionKey"];
    
    AFHTTPRequestOperation *requestOperation = [manager GET:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure(operation,error);
        }
    }];
    
    return requestOperation;
}

+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSMutableDictionary *dic = parameters;
    if (dic == nil)
    {
        dic = [NSMutableDictionary dictionary];
    }
    // 添加 默认 设置，版本号
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionKey"];
    
    AFHTTPRequestOperation *requestOperation = [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success)
        {
            //请求到的数据
            NSLog(@"请求到的数据打印====%@",responseObject);
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败的原因==%@",error);
        
        if (failure)
        {
            failure(operation,error);
        }
    }];
    
    //打印要请求的接接口，和要传递的参数
    NSLog(@"---url--%@,\nparam:%@",URLString,parameters);
    
    return requestOperation;
}


/*-------------------------*/
+(AFHTTPRequestOperation *)GETJson:(NSString *)URLString
parameters:(id)parameters
success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSMutableDictionary *dic =parameters;
    
    if (dic == nil)
    {
        dic = [NSMutableDictionary dictionary];
    }
    // 添加 默认 参数，每个接口 都需要添加
    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionKey"];
    
    AFHTTPRequestOperation *requestOperation = [manager GET:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success(operation,responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
        {
            failure(operation,error);
        }
    }];
    
    return requestOperation;
}

+(AFHTTPRequestOperation *)POSTJson:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.securityPolicy.allowInvalidCertificates = YES;
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *dic = parameters;
    if (dic == nil)
    {
        dic = [NSMutableDictionary dictionary];
    }
    // 添加 默认 设置，版本号
//    [dic setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionKey"];
    
    AFHTTPRequestOperation *requestOperation = [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success)
        {
            //请求到的数据
            NSLog(@"请求到的数据打印====%@",responseObject);
            success(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSString *str = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"请求失败的原因==%@",error);
        
        NSLog(@"返回来的值，不是json，是这个字符串:::::::::::::==%@",str);
        
        if (failure)
        {
            failure(operation,error);
        }
    }];
    
    //打印要请求的接接口，和要传递的参数
    NSLog(@"---url--%@,\nparam:%@",URLString,parameters);
    
    return requestOperation;
}


@end
