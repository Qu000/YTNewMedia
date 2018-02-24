//
//  YTDiscoverCell.m
//  YTNewMedia_iOS
//
//  Created by qujiahong on 2018/2/24.
//  Copyright © 2018年 瞿嘉洪. All rights reserved.
//

#import "YTDiscoverCell.h"
#import "YTDiscoverCollectionCell.h"
@interface YTDiscoverCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UIView * titleView;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation YTDiscoverCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"discoverCell";
    YTDiscoverCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTDiscoverCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor greenColor];
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


-(void)setupTopView{
    UIView * titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor purpleColor];
    [self addSubview:titleView];
    self.titleView = titleView;
}

-(void)setupBottomView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;//每行的间距[纵向间距]
    layout.minimumInteritemSpacing = 0;//每行内部cell item的间距[横向]
    // 设置collectionView的滚动方向，需要注意的是如果使用了collectionview的headerview或者footerview的话， 如果设置了水平滚动方向的话，那么就只有宽度起作用了了
    //一个横向的collectionView
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height-self.titleView.height) collectionViewLayout:layout];
    
//    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//  用来调整内边距
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    // 注册collectionViewcell:YTDiscoverCollectionCell是我自定义的cell的类型
    [_collectionView registerClass:[YTDiscoverCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(void)layoutSubviews{
    self.titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    CGFloat collectionViewY = CGRectGetMaxY(self.titleView.frame);
    self.collectionView.frame = CGRectMake(0, collectionViewY, SCREEN_WIDTH, self.height - self.titleView.height);
}
#pragma mark -- UICollectionViewDataSource

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTDiscoverCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
//    cell.topImageView.image = [UIImage imageNamed:@"1"];
//    cell.bottomLabel.text = [NSString stringWithFormat:@"%zd.png",indexPath.row];
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200, 200);
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
//                       layout:(UICollectionViewLayout *)collectionViewLayout
//       insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, kSectionMargin);//分别为上、左、下、右
//}


@end
