//
//  ZQSearchEditViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchEditViewController.h"
#import "ZQSearchEditBaseCell.h"
#import "ZQSearchEditNormalCell.h"
#import "ZQSearchConfirmCell.h"


@interface ZQSearchEditViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZQSearchEditViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

#pragma mark - config ui
- (void)configUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - config data
- (void)refreshSearchEditViewWith:(NSArray<ZQSearchData> *)data {
    self.datas = data.copy;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ZQSearchData> model = self.datas[indexPath.row];
    return [ZQSearchEditBaseCell heightWithType:model.editType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ZQSearchData> model = self.datas[indexPath.row];
    ZQSearchEditBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZQSearchEditBaseCell childCellIdentifierWith:@(model.editType)] forIndexPath:indexPath];
    [cell uploadCellWithData:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidScroll)]) {
        [self.delegate searchChildViewDidScroll];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidSelectRow:)]) {
        [self.delegate searchChildViewDidSelectRow:self.datas[indexPath.row]];
    }
}

#pragma mark - getter & setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[ZQSearchEditNormalCell class] forCellReuseIdentifier:[ZQSearchEditBaseCell childCellIdentifierWith:@(1)]];
        [_tableView registerClass:[ZQSearchConfirmCell class] forCellReuseIdentifier:[ZQSearchEditBaseCell childCellIdentifierWith:@(2)]];
    }
    return _tableView;
}

@end
