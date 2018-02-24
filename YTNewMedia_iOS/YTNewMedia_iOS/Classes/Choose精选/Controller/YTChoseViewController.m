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
#import "MJRefresh.h"

#import "AFNetworking.h"
@interface YTChoseViewController ()

@property (nonatomic, strong)NSMutableArray * dataList;
@property (nonatomic, strong)NSMutableArray * tempArr;
@property (nonatomic, assign)NSInteger pages;
@property (strong, nonatomic) UIWindow *appWindow;
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
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}
-(NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [[NSMutableArray alloc]init];
    }
    return _tempArr;
}

#pragma mark --- Systems method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pages = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self setupNav];
    
    [self refreshTop];
    [self refreshDowm];
}

#pragma mark --- Custom method
- (void)setupNav{
    YTCustomNav * customNav = [[YTCustomNav alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [customNav setBtnType:@"精选"];
    self.appWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.appWindow addSubview:customNav];
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
    return (SCREEN_HEIGHT-64-44-20);//20//90
    
}
#pragma mark --- 监测上滑下滑
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint h = [scrollView.panGestureRecognizer velocityInView:scrollView];
    
    if (h.y > 0) {
        NSLog(@"向下滑");
        self.appWindow.hidden = NO;
    }else{
        NSLog(@"向上滑");
        self.appWindow.hidden = YES;
    }
    if (scrollView.contentOffset.y == -64) {
        self.appWindow.hidden = NO;
    }
}
#pragma mark --- 下拉刷新
- (void)refreshTop{
// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
     MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置不同状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 2; i<=5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"t%zd", i]];
        [idleImages addObject:image];
    }
    //普通状态
    [header setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新
    [header setImages:idleImages forState:MJRefreshStatePulling];
    //正在刷新
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 设置 header
    self.tableView.mj_header = header;
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadNewData{
    
    NSString * timeSp = [self getNowTime];
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSDictionary * param = @{@"client_type":@"1",
                             @"client_version":@"3.2.6",
                             @"build_version":@"100938",
                             @"uuid":@"A836978E-75CA-4713-A835-B15A64DBBBCE",
                             @"session_key":@"",
                             @"req_time":timeSp,
                             @"offset":@"0",
                             @"limit":@"10"
                             };
    NSString * URL = [NSString stringWithFormat:@"%@%@",SERVER_HOST,API_JX];//
    //接收参数类型
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manger.requestSerializer.timeoutInterval = 15;
    [manger GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回信息正确--数据解析
        NSArray * newData = [Data mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //将最新的数据，添加到总数组的最  前 面
        NSRange range = NSMakeRange(0, newData.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.dataList insertObjects:newData atIndexes:set];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark --- 上拉刷新
- (void)refreshDowm{
    /*
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldData)];

    // 马上进入刷新状态
    [self.tableView.mj_footer beginRefreshing];
    */
    
    // 设置回调（一旦进入刷新状态，就调用 target 的 action，即调用 self 的 loadMoreData 方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOldData)];

    // 设置不同状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 2; i<=5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"t%zd", i]];
        [idleImages addObject:image];
    }
    //普通状态
    [footer setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新
    [footer setImages:idleImages forState:MJRefreshStatePulling];
    //正在刷新
    [footer setImages:idleImages forState:MJRefreshStateRefreshing];
    // 隐藏刷新状态文字
    footer.refreshingTitleHidden = YES;
    // 设置尾部
    self.tableView.mj_footer = footer;

}

- (void)loadOldData{
    
    NSString * timeSp = [self getNowTime];
    NSString * pagesStr = [NSString stringWithFormat:@"%ld",(long)self.pages];
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSDictionary * param = @{@"client_type":@"1",
                             @"client_version":@"3.2.6",
                             @"build_version":@"100938",
                             @"uuid":@"A836978E-75CA-4713-A835-B15A64DBBBCE",
                             @"session_key":@"",
                             @"req_time":timeSp,
                             @"offset":pagesStr,
                             @"limit":@"10"
                             };
    NSString * URL = [NSString stringWithFormat:@"%@%@",SERVER_HOST,API_JXRefreshDown];
    //接收参数类型
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manger.requestSerializer.timeoutInterval = 15;
    [manger GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回信息正确--数据解析
        NSArray * oldData = [Data mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //将最新的数据，添加到总数组的最  后 面
        [self.dataList addObjectsFromArray:oldData];
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
#warning 这里pages的自增需要一个判断
        self.pages = self.pages + 10;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];
}
#pragma mark --- 获取当前时间戳
- (NSString *)getNowTime{
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];//@"1517468580"
    return timeSp;
}


/*pragma mark --- 监测上滑下滑
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.oldY = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if( scrollView.contentOffset.y > self.oldY) {
        NSLog(@"向下滑");
        self.appWindow.hidden = YES;
    }else{
        NSLog(@"向上滑");
        self.appWindow.hidden = NO;
    }
}
 */
/* 删除行
-(NSArray*)tableView:(UITableView*)tableView editActionsForRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewRowAction*rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除"handler:^(UITableViewRowAction* _Nonnull action,NSIndexPath* _Nonnull indexPath)
    {
        NSLog(@"删除--，%ld", indexPath.row);
        NSLog(@"删除--，%ld", indexPath.section);
        [self.dataList removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
    }];
    
    return @[rowAction];
}
*/
/*
    防止循环引用
 
 __weak __typeof(self) weakSelf = self;
 __weak YTChooseCell *weakSelf = self;
 self.block = ^(CGFloat cellH) {
 weakSelf.cellH = CGRectGetMaxY(weakSelf.storyTagLab.frame);
 };
    cell中的使用方法
 cell.block = ^(CGFloat cellH) {
     self.cellH = cellH;
 };
*/
/*
 
 下拉刷新数据处理思维
 NSRange range = NSMakeRange(0, tempArr.count);
 NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:range];

 NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                        NSMakeRange(0,[self.tempArr count])];
 [self.dataList insertObjects:self.tempArr atIndexes:indexes];
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 //scrollView == self.tableView == self.view
 // 如果tableView还没有数据，就直接返回
 if (self.dataList.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
 
 CGFloat offsetY = scrollView.contentOffset.y;
 
 // 当最后一个cell完全显示在眼前时，contentOffset的y值
 CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
 if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
 // 显示footer
 self.tableView.tableFooterView.hidden = NO;
 
 // 加载更多的数据
 [self loadOldData];
 
 }

}
*/
 /*
 contentInset：除具体内容以外的边框尺寸
 contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
 contentOffset:
 1.它可以用来判断scrollView滚动到什么位置
 2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
 */

@end
