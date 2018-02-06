//
//  YTChooseCell.h
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

//typedef void(^CallBackBlcok) (CGFloat cellH);

@interface YTChooseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) Data * data;
/** cell的高度 */
@property (nonatomic, assign)CGFloat cellH;
/** block回调cell的高度 */
//@property (nonatomic, copy) CallBackBlcok block;
@end
