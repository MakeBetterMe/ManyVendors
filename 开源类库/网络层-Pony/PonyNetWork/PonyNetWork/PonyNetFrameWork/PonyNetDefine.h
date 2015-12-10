//
//  PonyNetDefine.h
//  PonyNetWork
//
//  Created by 王云鹏 on 15/12/10.
//  Copyright © 2015年 Pony. All rights reserved.
//

#ifndef PonyNetDefine_h
#define PonyNetDefine_h

/**
 *  请求类型
 */
typedef enum {
    PonyNetGet = 1,   /**< GET请求 */
    PonyNetPost       /**< POST请求 */
} PonyNetWorkType;

/**
 *  网络请求超时的时间
 */
#define PonyNet_TIME_OUT 20


/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^PonyStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^PonyNetSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^PonyNetFailureBlock)(NSError *error);





// .h文件
#define SingletonH(name) + (instancetype)shared##name;

// .m文件
#define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* PonyNetDefine_h */
