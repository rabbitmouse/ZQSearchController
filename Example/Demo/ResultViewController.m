//
//  ResultViewController.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/28.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 375, 100)];
    label.text = @"准确搜索，需要跳转的结果界面";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}


@end
