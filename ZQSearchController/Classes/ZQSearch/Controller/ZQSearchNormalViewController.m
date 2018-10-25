//
//  ZQSearchNormalViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/25.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchNormalViewController.h"
#import "ZQSearchNormalLayout.h"
#import "ZQSearchNormalCell.h"
#import "ZQSearchCollectionReusableView.h"
#import "ZQSearchConst.h"

static NSString *normalHeaderIdentifier = @"headerIdentifier";
static NSString *normalCellIdentifier = @"cellIdentifier";

@interface ZQSearchNormalViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *hotList;

@end

@implementation ZQSearchNormalViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self loadHistorySource];
}

- (void)viewWillLayoutSubviews {
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - config ui
- (void)setupCollectionView {
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ZQSearchNormalCell class] forCellWithReuseIdentifier:normalCellIdentifier];
    [self.collectionView registerClass:[ZQSearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:normalHeaderIdentifier];
}

#pragma mark - config data
- (void)setHotDataSource:(NSArray *)datas {
    self.hotList = datas.copy;
    [self.collectionView reloadData];
}

- (void)loadHistorySource {
    [self.collectionView reloadData];
}

- (void)refreshHistoryView {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.hotList.count) {
        return 2;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.hotList.count) {
        if (section == 0) {
            return self.hotList.count;
        } else {
            return self.historyList.count;
        }
    } else {
        return self.historyList.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    BOOL showDeleteBtn = NO;
    
    ZQSearchCollectionReusableView *header = (ZQSearchCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:normalHeaderIdentifier forIndexPath:indexPath];
    if (self.hotList.count) {
        header.title = indexPath.section == 0 ? @"热门搜索" : @"搜索历史";
        showDeleteBtn = indexPath.section == 1;
    } else {
        header.title = @"搜索历史";
        showDeleteBtn = indexPath.section == 0;
    }
    
    @weakify(self)
    
    
    [header showDeleteHistoryBtn:showDeleteBtn CallBack:^{
        @strongify(self)
        [self.historyList removeAllObjects];
        [NSKeyedArchiver archiveRootObject:self.historyList toFile:ZQ_SEARCH_HISTORY_CACHE_PATH];
        [self.collectionView reloadData];
    }];
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZQSearchNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:normalCellIdentifier forIndexPath:indexPath];
    if (self.hotList.count) {
        cell.title = indexPath.section == 0 ? self.hotList[indexPath.item] : self.historyList[indexPath.item];
    } else {
        cell.title = self.historyList[indexPath.item];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidScroll)]) {
        [self.delegate searchChildViewDidScroll];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidSelectItem:)]) {
        id value;
        if (self.hotList.count) {
            value = indexPath.section == 0 ? self.hotList[indexPath.item] : self.historyList[indexPath.item];
        } else {
            value = self.historyList[indexPath.item];
        }
        [self.delegate searchChildViewDidSelectItem:value];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width , 50);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = nil;
    if (self.hotList.count) {
        string = indexPath.section == 0 ? self.hotList[indexPath.item] : self.historyList[indexPath.item];
    } else {
        string = self.historyList[indexPath.item];
    }

    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    CGSize rSize = CGSizeMake(size.width + 15 * 2, 34);
    
    return rSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 20, 0, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

#pragma mark - getter & setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ZQSearchNormalLayout *layout = [[ZQSearchNormalLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)historyList
{
    if (!_historyList) {
        _historyList = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:ZQ_SEARCH_HISTORY_CACHE_PATH]];
    }
    return _historyList;
}

@end
