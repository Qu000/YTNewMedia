//
//  YTAPIConfig.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/5.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTAPIConfig : NSObject

/** 服务器*/
#define SERVER_HOST @"http://www.yuntoo.com/"

/** 精选*/
#define API_JX  @"v2/home/channel/1/refresh"
/** 精选上拉刷新*/
#define API_JXRefreshDown @"v2/home/channel/1/"

/** 精选下拉刷新*/
#define API_Video @"v2/home/channel/3/refresh"
/** 精选上拉刷新*/
#define API_VideoRefreshDown @"v2/home/channel/3/"


@end
