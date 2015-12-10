//
//  PonyNetManager.m
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyNetManager.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "PonyNetAgent.h"

@implementation PonyNetManager

SingletonM(PonyNetManager);
#pragma mark Get
//代理
+ (void)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict delegate:(id<PonyNetDelegate>)delegate showHUD:(BOOL)showHUD{

}
//block
+ (void)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict successBlock:(PonyNetSuccessBlock)successBlock failureBlock:(PonyNetFailureBlock)failureBlock showHUD:(BOOL)showHUD{

}
//target-action
+ (void)getRequstWithURL:(NSString *)url params:(NSDictionary *)paramsDict target:(id)target action:(SEL)action showHUD:(BOOL)showHUD{

}



#pragma mark - POST请求的三种回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                  delegate:(id<PonyNetDelegate>)delegate
              successBlock:(PonyNetSuccessBlock)successBlock
              failureBlock:(PonyNetFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[PonyNetAgent sharedPonyNetAgent] conURL:url networkType:PonyNetPost params:mutableDict delegate:delegate showHUD:showHUD target:target action:action successBlock:successBlock failureBlock:failureBlock];
}


//代理
+ (void)postReqeustWithURL:(NSString *)url params:(NSDictionary *)paramsDict delegate:(id<PonyNetDelegate>)delegate showHUD:(BOOL)showHUD{

}
//block
+ (void)postReqeustWithURL:(NSString *)url params:(NSDictionary *)paramsDict successBlock:(PonyNetSuccessBlock)successBlock failureBlock:(PonyNetFailureBlock)failureBlock showHUD:(BOOL)showHUD{

}
//target-action
+ (void)postReqeustWithURL:(NSString *)url params:(NSDictionary *)paramsDict target:(id)target action:(SEL)action showHUD:(BOOL)showHUD{
    
}


#pragma mark Upload
+ (void)uploadFileWithURL:(NSString *)url params:(NSDictionary *)paramsDict successBlock:(PonyNetSuccessBlock)successBlock failureBlock:(PonyNetFailureBlock)failureBlock uploadParam:(PonyUploadParam *)uploadParam showHUD:(BOOL)showHUD{
    if (showHUD) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }
    NSLog(@"上传图片接口 URL-> %@",url);
    NSLog(@"上传图片的参数-> %@",paramsDict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:nil animated:YES];
        NSLog(@"----> %@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:nil animated:YES];
        NSLog(@"----> %@",error.domain);
        if (error) {
            failureBlock(error);
        }
    }];
}

@end
