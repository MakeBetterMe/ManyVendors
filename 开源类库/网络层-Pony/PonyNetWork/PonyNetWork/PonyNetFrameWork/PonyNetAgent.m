//
//  PonyNetAgent.m
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import "PonyNetAgent.h"

@implementation PonyNetAgent

SingletonM(PonyNetAgent);

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */


- (PonyNetItem *)conURL:(NSString *)url networkType:(PonyNetWorkType)networkType params:(NSMutableDictionary *)params delegate:(id)delegate showHUD:(BOOL)showHUD target:(id)target action:(SEL)action successBlock:(PonyNetSuccessBlock)successBlock failureBlock:(PonyNetFailureBlock)failureBlock{
    if (self.networkError) {
        NSLog(@"网络断开连接，请检查网络");
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    /// 如果有一些公共处理，可以写在这里
    NSUInteger hashValue = [delegate hash];
    self.netWorkItem = [[PonyNetItem alloc]initWithtype:networkType url:url params:params delegate:delegate target:target action:action hashValue:hashValue showHUD:showHUD successBlock:successBlock failureBlock:failureBlock];
    self.netWorkItem.delegate = self;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}


/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)netWorkWillDealloc:(PonyNetItem *)itme{
    [self.items removeObject:itme];
    self.netWorkItem = nil;
}

/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems{
    PonyNetAgent *agent = [PonyNetAgent sharedPonyNetAgent];
    [agent.items removeAllObjects];
    agent.netWorkItem = nil;
}

@end
