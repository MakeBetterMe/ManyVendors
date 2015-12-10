//
//  PonyNetAgent.h
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PonyNetItem.h"
#import "PonyNetDefine.h"

@interface PonyNetAgent : NSObject <PonyNetDelegate>

SingletonH(PonyNetAgent);
/**
 *  items
 */
@property(nonatomic,strong)NSMutableArray *items;

/**
 *   单个网络请求项
 */
@property(nonatomic,strong)PonyNetItem *netWorkItem;

/**
 *  networkError
 */
@property(nonatomic,assign)BOOL networkError;


- (PonyNetItem*)conURL:(NSString *)url
                networkType:(PonyNetWorkType)networkType
                     params:(NSMutableDictionary *)params
                   delegate:(id)delegate
                    showHUD:(BOOL)showHUD
                     target:(id)target
                     action:(SEL)action
               successBlock:(PonyNetSuccessBlock)successBlock
               failureBlock:(PonyNetFailureBlock)failureBlock;

@end
