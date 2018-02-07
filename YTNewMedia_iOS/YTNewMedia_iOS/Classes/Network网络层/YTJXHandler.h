//
//  YTJXHandler.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/5.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTHandler.h"

@interface YTJXHandler : YTHandler

/**
 * 获取精选信息
 * success
 * failed
 */
+ (void)executeGetJXTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 * 获取精选下拉刷新信息
 * success
 * failed
 */
+ (void)executeGetJXRefreshDownTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end
