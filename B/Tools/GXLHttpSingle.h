//
//  GXLHttpSingle.h
//  zhi
//
//  Created by Admin on 2018/7/27.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//网络请求返回码,这个可以修改
typedef NS_ENUM(NSInteger, ke_requestState){
    ke_requestStateSuccess=0
};


@interface GXLHttpSingle : AFHTTPSessionManager
+(instancetype)shareSingle;




/*
 使用方法，建议把用的接口，写在一个.h文件统一，如.pch，上面的网络返回码要修改
[GXLHttpSingle baseGetRequestWithUrl:@"he/1.php" WithDic:nil WithComplete:^(NSDictionary *returnContent, NSString *errorString) {
    NSLog(@"%@--%@",returnContent,errorString);
}];
*/
+(void)baseGetRequestWithUrl:(NSString *)url WithDic:(NSDictionary *)dic WithComplete:(void(^)(NSDictionary * returnContent,NSString *errorString))complete;
+(void)basePostRequestWithUrl:(NSString *)url WithDic:(NSDictionary *)dic WithComplete:(void(^)(NSDictionary * returnContent,NSString *errorString))complete;
/**
 检查网络状态
 */
+(BOOL)checkNetWorkState;





@end
