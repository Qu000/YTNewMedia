//
//  YTChoseViewController.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

/*
 最上方的应当是悬浮的一个View
 下方则是TableView
 */
#import "YTChoseViewController.h"

#import "YTCustomNav.h"
#import "YTChooseCell.h"
#import "YTJXHandler.h"
#import "RootClass.h"

@interface YTChoseViewController ()
//@property (nonatomic, weak)YTCustomNav * topView;
@property (nonatomic, strong)NSMutableArray * dataList;

@end

@implementation YTChoseViewController

#pragma mark --- To prepare
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


#pragma mark --- Systems method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self setupNav];
    [self loadData];
}

#pragma mark --- Custom method
- (void)setupNav{
    YTCustomNav * customNav = [[YTCustomNav alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [customNav setBtnType:@"精选"];
//    [self.view addSubview:customNav];
//    self.topView = customNav;
    UIWindow *appWindow = [UIApplication sharedApplication].keyWindow;
    [appWindow addSubview:customNav];
}
- (void)loadData{
    [YTJXHandler executeGetJXTaskWithSuccess:^(id obj) {

        self.dataList = obj;

        [self.tableView reloadData];
    } failed:^(id obj) {
        NSLog(@"obj=%@",obj);
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTChooseCell * cell = [YTChooseCell cellWithTableView:tableView];

    cell.data = self.dataList[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT-64-44-20);
    
}

#pragma mark --- 下拉刷新

#pragma mark --- 上拉刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"上拉刷新");
    /*
    [YTJXHandler executeGetJXRefreshDownTaskWithSuccess:^(id obj) {

        [self.dataList addObjectsFromArray:obj];

        [self.tableView reloadData];
    } failed:^(id obj) {
        NSLog(@"obj=%@",obj);
    }];
     */
}
/*
    防止循环引用
 __weak YTChooseCell *weakSelf = self;
 self.block = ^(CGFloat cellH) {
 weakSelf.cellH = CGRectGetMaxY(weakSelf.storyTagLab.frame);
 };
    cell中的使用方法
 cell.block = ^(CGFloat cellH) {
     self.cellH = cellH;
 };
*/

@end
