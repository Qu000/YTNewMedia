//
//  YTProfileViewController.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTProfileViewController.h"
#import "YTCustomNav.h"

@interface YTProfileViewController ()
@property (strong, nonatomic) UIWindow *appWindow;
@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation YTProfileViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.appWindow.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.appWindow.hidden = YES;
    self.appWindow = nil;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupScrollView];
    [self setupControls];
}

#pragma mark --- Custom method
- (void)setupNav{
    YTCustomNav * customNav = [[YTCustomNav alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [customNav setBtnType:@"我的"];
    UIWindow *appWindow = [UIApplication sharedApplication].keyWindow;
    [appWindow addSubview:customNav];
}
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
    scrollView.backgroundColor = [UIColor purpleColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-44);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}
- (void)setupControls{
    UIImageView * headImg = [[UIImageView alloc]init];
    headImg.backgroundColor = [UIColor orangeColor];
    CGFloat headWH = SCREEN_WIDTH/3;
//    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(headWH, headWH));
//        make.top.mas_equalTo(60);
//    }];
    headImg.frame = CGRectMake(headWH, 60, headWH, headWH);
    [self.scrollView addSubview:headImg];
    
    
}
@end
