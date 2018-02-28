//
//  YTCustomNav.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YTBtnType) {
    YTBtnTypeChoose = 100,//精选
    YTBtnTypeVideo,//视频
    YTBtnTypeDiscover,//发现
    YTBtnTypeProfile//我的
};//6
@class YTCustomNav;//4
typedef void(^NavBlock)(YTCustomNav * customNav,YTBtnType idx);//7
@protocol YTCustomNavDelegate <NSObject>//1
-(void)customNav:(YTCustomNav *)customNav buttonType:(YTBtnType)idx;
//3----NSUInteger--6-->YTBtnType
@end//2

@interface YTCustomNav : UIView
- (void)setBtnType:(NSString *)typeName;
@property (nonatomic, weak) id<YTCustomNavDelegate> delegate;//5
@property (nonatomic, copy) NavBlock block;//8
@end
