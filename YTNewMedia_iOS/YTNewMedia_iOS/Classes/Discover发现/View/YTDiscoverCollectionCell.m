//
//  YTDiscoverCollectionCell.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/24.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTDiscoverCollectionCell.h"

@interface YTDiscoverCollectionCell()
@property (nonatomic,weak) UIImageView * iconImg;
@property (nonatomic,weak) UILabel * contentLab;
@end
@implementation YTDiscoverCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        UIImageView * iconImg = [[UIImageView alloc]init];
        iconImg.backgroundColor = [UIColor greenColor];
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.backgroundColor = [UIColor orangeColor];
        [self addSubview:contentLab];
        self.contentLab = contentLab;
    }
    return self;
}
-(void)layoutSubviews{
    self.iconImg.frame = CGRectMake(0, 0, 100, 100);
    CGFloat contentLabY = CGRectGetMaxY(self.iconImg.frame);
    self.contentLab.frame = CGRectMake(0, contentLabY, 100, 100);
}
@end
