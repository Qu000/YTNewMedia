//
//  YTCustomNav.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTCustomNav.h"

@interface YTCustomNav()
@property (nonatomic, weak)UIButton * typeBtn;
@property (nonatomic, weak)UIButton * searchBtn;
@end

@implementation YTCustomNav

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setBtnType:(NSString *)typeName{
    
    UIButton * typeBtn = [[UIButton alloc]init];
    [typeBtn setTitle:typeName forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [typeBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [typeBtn addTarget:self action:@selector(clickTypeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:typeBtn];
    self.typeBtn = typeBtn;
    
    UIButton * searchBtn = [[UIButton alloc]init];
    [searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    self.searchBtn = searchBtn;
}

-(void)layoutSubviews{
    CGFloat typeBtnX = 10;
    CGFloat typeBtnY = 20;
    CGFloat typeBtnW = 50;
    CGFloat typeBtnH = 30;
    self.typeBtn.frame = CGRectMake(typeBtnX, typeBtnY, typeBtnW, typeBtnH);
    CGFloat searchBtnW = 50;
    CGFloat searchBtnX = self.width - searchBtnW - 10;
    CGFloat searchBtnY = 20;
    CGFloat searchBtnH = 30;
    self.searchBtn.frame = CGRectMake(searchBtnX, searchBtnY, searchBtnW, searchBtnH);
}
- (void)clickTypeBtn{
    NSLog(@"clickTypeBtn");
}
- (void)clickSearchBtn{
    NSLog(@"clickSearchBtn");
}
@end
