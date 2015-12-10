//
//  PonyNetItem.m
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyNetItem.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "NetUrl.h"
@interface PonyNetItem ()
@property (nonatomic,copy) PonyNetSuccessBlock successBlock;
@property (nonatomic,copy) PonyNetFailureBlock failureBlock;
@end

@implementation PonyNetItem

- (PonyNetItem *)initWithtype:(PonyNetWorkType)networkType url:(NSString *)url params:(NSDictionary *)params delegate:(id)delegate target:(id)target action:(SEL)action hashValue:(NSUInteger)hashValue showHUD:(BOOL)showHUD successBlock:(PonyNetSuccessBlock)successBlock failureBlock:(PonyNetFailureBlock)failureBlock{
    if (self == [super init]) {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        self.tagrget        = target;
        self.selector       = action;
        self.successBlock   = successBlock;
        self.failureBlock   = failureBlock;
        [self config];
    }
    return self;
}


- (void)config{
    if (self.showHUD) {
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
    }
    __weak typeof(self)weakSelf = self;
    NSString *requestUrl = [NSString stringWithFormat:NET_HOST,self.url];
    NSLog(@"--请求url地址--%@\n",self.url);
    NSLog(@"----请求参数%@\n",self.params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //TODO:设置其他参数
    //        AFJSONResponseSerializer *jsonSer =(AFJSONResponseSerializer*) manager.responseSerializer;
    //        jsonSer.removesKeysWithNullValues = YES;
    //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // 是否使用 https
    if ([requestUrl hasPrefix:@"https"]) {
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        manager.securityPolicy = securityPolicy;
    }
    if (_networkType == PonyNetGet){
        [manager GET:requestUrl parameters:_params success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
            [MBProgressHUD hideAllHUDsForView:nil animated:YES];
            NSLog(@"\n\n----请求的返回结果 %@\n",responseObject);
            if (_successBlock) {
                _successBlock(responseObject);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                [weakSelf.delegate requestDidFinishLoading:responseObject];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
            [weakSelf removewItem];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:nil animated:YES];
            NSLog(@"---error==%@\n",error.localizedDescription);
            if (_failureBlock) {
                _failureBlock(error);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                [weakSelf.delegate requestdidFailWithError:error];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
            [weakSelf removewItem];
        }];
    
    }else{
        [manager POST:requestUrl parameters:_params success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
            [MBProgressHUD hideHUDForView:nil animated:YES];
            NSLog(@"\n\n----请求的返回结果 %@\n",responseObject);
            if (_successBlock) {
                _successBlock(responseObject);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                [weakSelf.delegate requestDidFinishLoading:responseObject];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
            [weakSelf removewItem];
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            [MBProgressHUD hideAllHUDsForView:nil animated:YES];
            NSLog(@"---error==%@\n",error.localizedDescription);
            if (_failureBlock) {
                _failureBlock(error);
            }
            if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                [weakSelf.delegate requestdidFailWithError:error];
            }
            [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
            [weakSelf removewItem];
        }];
    }
}


/**
 *   移除网络请求项
 */
- (void)removewItem{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error{
    if ([self.tagrget respondsToSelector:self.selector]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

- (void)dealloc{
    
    
}




@end
