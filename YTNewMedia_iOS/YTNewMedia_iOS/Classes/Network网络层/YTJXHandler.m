//
//  YTJXHandler.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/5.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTJXHandler.h"

#import "YTHttpTool.h"
#import "Data.h"
@implementation YTJXHandler

+ (void)executeGetJXTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];//@"1517468580"

    NSDictionary * param = @{@"client_type":@"1",
                             @"client_version":@"3.2.6",
                             @"build_version":@"100938",
                             @"uuid":@"A836978E-75CA-4713-A835-B15A64DBBBCE",
                             @"session_key":@"",
                             @"req_time":timeSp,
                             @"offset":@"0",
                             @"limit":@"10"
                             };
    
    [YTHttpTool getWithPath:API_JX params:param success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json[@"error_msg"]);
            
        }
        else{
            success(json);
            //            返回信息正确--数据解析
            NSArray * datas = [Data mj_objectArrayWithKeyValuesArray:json[@"data"]];
            success(datas);
            
            
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

+ (void)executeGetJXRefreshDownTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];//@"1517470080"
    NSDictionary * param = @{@"client_type":@"1",
                             @"client_version":@"3.2.6",
                             @"build_version":@"100938",
                             @"uuid":@"A836978E-75CA-4713-A835-B15A64DBBBCE",
                             @"session_key":@"",
                             @"req_time":timeSp,
                             @"offset":@"10",
                             @"limit":@"10"
                             };
    [YTHttpTool getWithPath:API_JXRefreshDown params:param success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json[@"error_msg"]);
            
        }
        else{
            success(json);
            //            返回信息正确--数据解析
            NSArray * datas = [Data mj_objectArrayWithKeyValuesArray:json[@"data"]];
            success(datas);
            
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
