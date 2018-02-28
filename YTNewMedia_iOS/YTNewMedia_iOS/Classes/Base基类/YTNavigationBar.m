//
//  YTNavigationBar.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/25.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTNavigationBar.h"
@interface YTNavigationBar()

@end
@implementation YTNavigationBar

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
    }
    return _rightBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self setupBtn];
    }
    return self;
}
-(void)setupBtn{
    
}
@end
