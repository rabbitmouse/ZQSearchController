//
//  ZQSearchNormalViewController.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/25.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQSearchConst.h"

@interface ZQSearchNormalViewController : UIViewController

- (void)setHotDataSource:(NSArray *)datas;
- (void)refreshHistoryView;

@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, weak) id<ZQSearchChildViewDelegate> delegate;

@end
