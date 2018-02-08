//
//  YTVideoModel.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTVideoModel : NSObject

//实际上，视频 与 精选的model是一致的

@property (nonatomic, strong) NSString * channelName;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger imageWidth;
@property (nonatomic, strong) NSString * itemCoverUrl;
@property (nonatomic, strong) NSString * itemDescription;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, strong) NSString * itemTitle;
@property (nonatomic, assign) NSInteger itemType;
@property (nonatomic, assign) NSInteger refItemId;
@property (nonatomic, strong) NSString * storyCreateTime;
@property (nonatomic, assign) NSInteger storyId;
@property (nonatomic, strong) NSString * storyTag;
@property (nonatomic, strong) NSString * storyTitle;
@property (nonatomic, strong) NSString * userAvatar;
@property (nonatomic, strong) NSString * userEmail;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * userIntro;
@property (nonatomic, assign) NSInteger userIsPro;
@property (nonatomic, strong) NSString * userNickname;
@property (nonatomic, assign) NSInteger videoId;
@property (nonatomic, strong) NSString * videoImageUrl;
@property (nonatomic, strong) NSString * videoMd5;
@property (nonatomic, assign) NSInteger videoSize;
@property (nonatomic, assign) NSInteger videoTotalTime;
@property (nonatomic, strong) NSString * videoUrl;
@end
