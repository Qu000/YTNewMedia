//
//  YTChooseCell.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTChooseCell.h"

@implementation YTChooseCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"chooseCell";
    YTChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTChooseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

@end
