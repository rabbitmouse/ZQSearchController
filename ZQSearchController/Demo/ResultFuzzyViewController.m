//
//  ResultFuzzyViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/28.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ResultFuzzyViewController.h"

@interface ResultFuzzyViewController ()

@end

@implementation ResultFuzzyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 375, 100)];
    label.text = @"模糊搜索结果，可以显示自定义模糊搜索结果列表";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}


@end
