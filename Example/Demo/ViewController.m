//
//  ViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/20.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ViewController.h"

#import "ZQSearchViewController.h"
#import "searchEditModel.h"
#import "ResultViewController.h"
#import "ResultFuzzyViewController.h"

@interface ViewController ()<ZQSearchViewDelegate>

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)searchTap:(id)sender {
    NSArray *hots = @[@"热门",@"热门热门",@"热门热门热门",@"热门热门",@"热门",@"热门",@"热热门热门热门门"];
    
    // 自定义的结果控制器，进一步展示关键字搜索结果
    ResultFuzzyViewController *resultController = [ResultFuzzyViewController new];
    
    ZQSearchViewController *vc = [[ZQSearchViewController alloc] initSearchViewWithHotDatas:hots resultController:resultController];
//    vc.closeFuzzyTable = YES; //关闭模糊匹配table
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:NO];
    
}


#pragma mark - ZQSearchViewDelegate

/**
 * 输入关键字，自动触发的事件回调
 * keyString：当前输入的关键字
 * DataBlock：需要回传的数据（该数据一般通过异步获取）
 */
- (void)searchEditViewRefreshWithKeyString:(NSString *)keyString DataBlock:(void (^)(id<ZQSearchData>))block {
    // 模拟异步获取数据，并回调
    // 回传数据需遵守ZQSearchData协议，用于UI展示
    NSMutableArray *arr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5 + arc4random() % 10; i++) {
            searchEditModel *edit = [searchEditModel new];
            edit.iconUrl = @"123";
            edit.image = [UIImage imageNamed:@"default"];
            edit.title = [NSString stringWithFormat:@"内容 %d", i];
            edit.desc = @"描述描述描述";
            edit.editType = i < 3 ? SearchEditTypeConfirm : SearchEditTypeFuzzy;
            [arr addObject:edit];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(arr.copy);
        });
    });
}

/**
 * 点击模糊匹配列表中的item
 * data：遵守ZQSearchData的原数据
 * resultController：传入的resultController
 */
- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController {
    
    // 在此跳转到下一个自定义页面，一般用于展示搜索结果的详情
    ResultViewController *vc = [ResultViewController new];
    [resultController.navigationController pushViewController:vc animated:YES];
}

/**
 * 关键词搜索回调，搜索栏触发或点击「模糊匹配」列表中的引导关键词触发
 * keyString：当前的关键词
 * data：遵守ZQSearchData的原数据
 * resultController：传入的resultController
 */
- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController{
    
    //1
    NSLog(@"%@",keyString);
    //2
    NSLog(@"%@",data);
    //3 在此处理关键字或结果页数据更新
    //
}
@end
