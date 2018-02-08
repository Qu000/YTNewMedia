//
//  YTVideoCell.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/8.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTVideoModel.h"
@interface YTVideoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) YTVideoModel * data;
@end
