//
//  PonyNetDelegate.h
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PonyNetItem;
@protocol PonyNetDelegate <NSObject>

@optional
/**
 *   请求结束
 *
 *   @param returnData 返回的数据
 */
- (void)requestDidFinishLoading:(NSDictionary*)returnData;
/**
 *   请求失败
 *
 *   @param error 失败的 error
 */
- (void)requestdidFailWithError:(NSError*)error;

/**
 *   网络请求项即将被移除掉  用于批量请求
 *
 *   @param itme 网络请求项
 */
- (void)netWorkWillDealloc:(PonyNetItem *)itme;


@end
