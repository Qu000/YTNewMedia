//
//  YTVideoViewController.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/2.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTVideoViewController.h"
#import "YTVideoModel.h"
#import "YTVideoCell.h"
#import "YTCustomNav.h"

#import "MJRefresh.h"
#import "AFNetworking.h"
@interface YTVideoViewController ()

@property (nonatomic, strong)NSMutableArray * dataList;
@property (nonatomic, strong)NSMutableArray * tempArr;
@property (nonatomic, assign)NSInteger pages;
@property (strong, nonatomic) UIWindow *appWindow;

@end

@implementation YTVideoViewController

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
    
    [self refreshTop];
    [self refreshDowm];
}
#pragma mark --- Custom method
- (void)setupNav{
    YTCustomNav * customNav = [[YTCustomNav alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [customNav setBtnType:@"视频"];
    UIWindow *appWindow = [UIApplication sharedApplication].keyWindow;
    [appWindow addSubview:customNav];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YTVideoCell * cell = [YTVideoCell cellWithTableView:tableView];
    
    cell.data = self.dataList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT-64-44-20);
    
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
    NSString * URL = [NSString stringWithFormat:@"%@%@",SERVER_HOST,API_Video];
    //接收参数类型
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manger.requestSerializer.timeoutInterval = 15;
    [manger GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回信息正确--数据解析
        NSArray * newData = [YTVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        //将最新的数据，添加到总数组的最  前 面
        NSRange range = NSMakeRange(0, newData.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.dataList insertObjects:newData atIndexes:set];
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (void)refreshDowm{
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
    NSString * URL = [NSString stringWithFormat:@"%@%@",SERVER_HOST,API_VideoRefreshDown];
    //接收参数类型
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manger.requestSerializer.timeoutInterval = 15;
    [manger GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回信息正确--数据解析
        NSArray * oldData = [YTVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
