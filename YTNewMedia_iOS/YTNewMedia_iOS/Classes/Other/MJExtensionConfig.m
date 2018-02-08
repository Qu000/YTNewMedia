//
//  MJExtensionConfig.m
//  尚学堂映客
//
//  Created by 大欢 on 16/8/22.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "Data.h"
#import "YTVideoModel.h"

@implementation MJExtensionConfig

+ (void)load {
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
//    [JHCreator mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
//        return @{
//                 @"desc" : @"desciption"
//                 };
//    }];
    
    //下滑线
    [Data mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [YTVideoModel mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    //下滑线
    /*
    [JHFlow mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    [JHInfo mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    
    [JHFCreator mj_setupReplacedKeyFromPropertyName121:^NSString *(NSString *propertyName) {
        return [propertyName mj_underlineFromCamel];
    }];
    */
    
}

@end
