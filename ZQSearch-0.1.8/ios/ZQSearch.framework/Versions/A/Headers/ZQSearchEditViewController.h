//
//  ZQSearchEditViewController.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQSearchConst.h"

@interface ZQSearchEditViewController : UIViewController

@property (nonatomic, strong) NSArray<ZQSearchData> *datas;

- (void)refreshSearchEditViewWith:(NSArray<ZQSearchData> *)data;

@property (nonatomic, weak) id<ZQSearchChildViewDelegate> delegate;

@end
