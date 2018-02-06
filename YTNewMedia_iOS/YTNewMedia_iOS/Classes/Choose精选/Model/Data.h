#import <Foundation/Foundation.h>

@interface Data : NSObject

/**
 * 类别：经典-艺术-东方
 */
@property (nonatomic, strong) NSString * channelName;
/**
 * 对视频的描述：使用url进行逆转码，才能显示正确的文字信息
 */
@property (nonatomic, strong) NSString * descriptionField;

/**
 * 视频的总时间（秒）
 */
@property (nonatomic, assign) NSInteger videoTotalTime;
/**
 * 视频的地址
 */
@property (nonatomic, strong) NSString * videoUrl;
/**
 * 视频的封面图片地址
 */
@property (nonatomic, strong) NSString * videoImageUrl;
/**
 * 视频的时间（2018-02-04 23:13:37 +0800）
 */
@property (nonatomic, strong) NSString * storyCreateTime;
/**
 * title：粗体的标题
 */
@property (nonatomic, strong) NSString * itemTitle;
/**
 * item的封面图片地址，不是视频时可取
 */
@property (nonatomic, strong) NSString * itemCoverUrl;
/**
 * 对item的描述：使用url进行逆转码，才能显示正确的文字信息，不是视频时可取
 */
@property (nonatomic, strong) NSString * itemDescription;
/**
 * item的tag标签
 */
@property (nonatomic, strong) NSString * storyTag;

@property (nonatomic, assign) NSInteger imageHeight;
@property (nonatomic, assign) NSInteger imageWidth;

@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, assign) NSInteger itemType;
@property (nonatomic, assign) NSInteger refItemId;

@property (nonatomic, assign) NSInteger storyId;

@property (nonatomic, strong) NSString * storyTitle;
@property (nonatomic, strong) NSString * userAvatar;
@property (nonatomic, strong) NSString * userEmail;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * userIntro;
@property (nonatomic, assign) NSInteger userIsPro;
@property (nonatomic, strong) NSString * userNickname;
@property (nonatomic, assign) NSInteger videoId;

@property (nonatomic, strong) NSString * videoMd5;
@property (nonatomic, assign) NSInteger videoSize;


@end
