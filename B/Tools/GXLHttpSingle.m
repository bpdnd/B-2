//
//  GXLHttpSingle.m
//  zhi
//
//  Created by Admin on 2018/7/27.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "GXLHttpSingle.h"
static NSString * const BaseURLString = @"http://39.106.46.224:8085";
@implementation GXLHttpSingle
+(instancetype)shareSingle{
    static GXLHttpSingle *httpSingle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpSingle = [[GXLHttpSingle alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        httpSingle.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        httpSingle.requestSerializer.timeoutInterval = 10; //超时时间
    });
    return httpSingle;
}
+(BOOL)checkNetWorkState{
    static BOOL isAF = YES;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                isAF = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未连接网络");
                isAF = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"连接2g/3g/4g");
                isAF = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"连接wifi");
                isAF = YES;
                break;
            default:
                break;
        }
    }];
    return isAF;
}
+(void)baseGetRequestWithUrl:(NSString *)url WithDic:(NSDictionary *)dic WithComplete:(void (^)(NSDictionary *, NSString *))complete{
    [[GXLHttpSingle shareSingle] GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"url==>%@/%@,parameters==>%@",BaseURLString,url,dic);
        NSDictionary *rsponseDic = responseObject;
        if ([[rsponseDic objectForKey:@"errno"] integerValue] == ke_requestStateSuccess) {
            complete(rsponseDic,nil);
        }else{
            NSString *errorMsg = [rsponseDic objectForKey:@"error"];
            complete(nil,errorMsg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,@"失败");
    }];
}

+(void)basePostRequestWithUrl:(NSString *)url WithDic:(NSDictionary *)dic WithComplete:(void (^)(NSDictionary *, NSString *))complete{
    [[GXLHttpSingle shareSingle]POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"url==>%@/%@,parameters==>%@",BaseURLString,url,dic);
        NSDictionary *rsponseDic = responseObject;
        if ([[rsponseDic objectForKey:@"errno"] integerValue] == ke_requestStateSuccess) {
            complete(rsponseDic,nil);
        }else{
            NSString *errorMsg = [rsponseDic objectForKey:@"error"];
            complete(nil,errorMsg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(nil,@"失败");
    }];
}

@end
