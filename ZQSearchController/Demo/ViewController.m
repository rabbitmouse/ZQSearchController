//
//  ViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/20.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ViewController.h"

#import "ZQSearchViewController.h"
#import "ZQSearchConst.h"
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
    
    ResultFuzzyViewController *resultController = [ResultFuzzyViewController new];
    
    ZQSearchViewController *vc = [[ZQSearchViewController alloc] initSearchViewWithHotDatas:hots resultController:resultController];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:NO];
    
}


#pragma mark - ZQSearchViewDelegate
- (void)searchEditViewRefreshWithDataBlock:(void (^)(id))block {
    NSMutableArray *arr = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 5 + arc4random() % 10; i++) {
            searchEditModel *edit = [searchEditModel new];
            edit.iconUrl = @"123";
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


- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController{
    
    //1
    NSLog(@"%@",keyString);
    //2
    NSLog(@"%@",data);
    //3
}

- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController {

    ResultViewController *vc = [ResultViewController new];
    [resultController.navigationController pushViewController:vc animated:YES];
}
@end
