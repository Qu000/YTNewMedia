//
//  YTChooseCell.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTChooseCell.h"

@interface YTChooseCell()
@property (nonatomic, weak) UIImageView *iconImg;
@property (nonatomic, weak) UIView * bottomView;
@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * desLab;
@property (nonatomic, weak) UILabel * storyTagLab;
@property (nonatomic, weak) UILabel * itemTime;

@end
@implementation YTChooseCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"chooseCell";
    YTChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTChooseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
/**
* cell的初始化方法，一个cell只会调用一次
* 一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //取消cell选中变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupTopView];
        [self setupBottomView];
    }
    return self;
}
#pragma mark --- cell的上半部分
- (void)setupTopView{
    UIImageView * iconImg = [[UIImageView alloc]init];
    [self addSubview:iconImg];
    self.iconImg = iconImg;
}
#pragma mark --- cell的下半部分
- (void)setupBottomView{
    UIView *bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    UILabel * titleLab = [[UILabel alloc]init];
    titleLab.numberOfLines = 0;
    [titleLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];//加粗
    titleLab.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:titleLab];
    self.titleLab = titleLab;
    
    UILabel * desLab = [[UILabel alloc]init];
    desLab.textAlignment = NSTextAlignmentCenter;
    desLab.numberOfLines = 0;
    [desLab setFont:[UIFont systemFontOfSize:14]];
    [desLab setTextColor:YTRGB(160,160,160)];
    [self.bottomView addSubview:desLab];
    self.desLab = desLab;
    
    UILabel * storyTagLab = [[UILabel alloc]init];
    [storyTagLab setTextColor:[UIColor redColor]];
    [storyTagLab setFont:[UIFont fontWithName:@"Helvetica-Oblique" size:10]];//加粗并且倾斜
    storyTagLab.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:storyTagLab];
    self.storyTagLab = storyTagLab;
    
    UILabel * itemTime = [[UILabel alloc]init];
    [itemTime setFont:[UIFont systemFontOfSize:10]];
    [itemTime setTextColor:YTRGB(160,160,160)];
    itemTime.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:itemTime];
    self.itemTime = itemTime;
}
#pragma mark --- cell子控件的frame
-(void)layoutSubviews{
    self.iconImg.frame = CGRectMake(0, 0, self.width, 220);
    CGFloat bottomViewY = CGRectGetMaxY(self.iconImg.frame);
    
    self.bottomView.frame = CGRectMake(0, bottomViewY, self.width, 220);
    
    self.titleLab.frame =  CGRectMake(20, 10, self.bottomView.width - 40, 100);
    
    CGFloat desLabY = CGRectGetMaxY(self.titleLab.frame);
    self.desLab.frame = CGRectMake(20, desLabY, self.titleLab.width, 80);

    CGFloat itemTimeW = 70;
    CGFloat itemTimeX = self.bottomView.width - 40 - itemTimeW;
    CGFloat itemTimeY = CGRectGetMaxY(self.desLab.frame)+5;
    self.itemTime.frame = CGRectMake(itemTimeX, itemTimeY, itemTimeW, 20);
    
    CGFloat storyTagW = 70;
    CGFloat storyTagX = itemTimeX - storyTagW;
    CGFloat storyTagY = itemTimeY;
    self.storyTagLab.frame = CGRectMake(storyTagX, storyTagY, storyTagW, 20);
    
    self.cellH = CGRectGetMaxY(self.storyTagLab.frame);
    
}
#pragma mark --- cell的数据赋值
-(void)setData:(Data *)data{
    _data = data;
    [self.iconImg downloadImage:data.itemCoverUrl placeholder:@"avatar_default"];
    self.titleLab.text = data.itemTitle;
    self.desLab.text = [self decodeFromPercentEscapeString:data.itemDescription];
    
    //3.分隔字符串
    NSArray *storyTagArr = [data.storyTag componentsSeparatedByString:@","]; //从字符 , 分隔成2个元素的数组
    self.storyTagLab.text = [NSString stringWithFormat:@"#%@",storyTagArr[0]];
    
    NSString * itemTimeStr = [data.storyCreateTime substringToIndex:10];//截取掉下标9之前的字符串
    self.itemTime.text = itemTimeStr;
}

#pragma mark --- URL解码
- (NSString *)decodeFromPercentEscapeString: (NSString *) urlStr
{
    NSMutableString *outputStr = [NSMutableString stringWithString:urlStr];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,
                                                      [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
