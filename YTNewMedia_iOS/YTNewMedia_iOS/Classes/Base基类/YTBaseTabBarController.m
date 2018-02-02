//
//  YTBaseTabBarController.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTBaseTabBarController.h"

#import "YTChoseViewController.h"
#import "YTVideoViewController.h"
#import "YTDiscoverViewController.h"
#import "YTProfileViewController.h"

#import "YTBaseNavController.h"
#import "YTCustomNav.h"
@interface YTBaseTabBarController ()

@end

@implementation YTBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI{
    YTChoseViewController * choseVc = [[YTChoseViewController alloc]init];
    [self addChildVc:choseVc withTabTitle:@"精选" title:@"精选" image:@"tab_bar_home" selectedImage:@"tab_bar_home_h"];
    
    YTVideoViewController * videoVc = [[YTVideoViewController alloc]init];
    [self addChildVc:videoVc withTabTitle:@"视频" title:@"视频" image:@"tab_bar_find" selectedImage:@"tab_bar_find_h"];
    
    YTDiscoverViewController * discoverVc = [[YTDiscoverViewController alloc]init];
    [self addChildVc:discoverVc withTabTitle:@"发现" title:@"发现" image:@"tab_bar_findye" selectedImage:@"tab_bar_findye_h"];
    
    YTProfileViewController * profileVc = [[YTProfileViewController alloc]init];
    [self addChildVc:profileVc withTabTitle:@"我的" title:@"我的" image:@"tab_bar_profile" selectedImage:@"tab_bar_profile_h"];
}
- (void)addChildVc:(UIViewController *)childVc withTabTitle:(NSString *)tabTitle title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVc.navigationItem.title = title;
    childVc.title = tabTitle;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    //声明：这张图片按照原来的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary *textAtts = [NSMutableDictionary dictionary];
    textAtts[NSForegroundColorAttributeName] = YTRGB(123, 123, 123);
    
    NSMutableDictionary *selectTextAtts = [NSMutableDictionary dictionary];
    selectTextAtts[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    
    
    [childVc.tabBarItem setTitleTextAttributes:textAtts forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAtts forState:UIControlStateSelected];
    
    //先给外面传进来的小控制器，包装一个导航控制器
    YTBaseNavController * nav = [[YTBaseNavController alloc]initWithRootViewController:childVc];
    
    //添加子控制器
    [self addChildViewController:nav];
    
}

@end
