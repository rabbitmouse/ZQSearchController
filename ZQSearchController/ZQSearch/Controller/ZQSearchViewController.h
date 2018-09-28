//
//  ZQSearchViewController.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/20.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQSearchConst.h"

typedef NS_ENUM(NSUInteger, ZQSearchBarStyle) {
    ZQSearchBarStyleNone,
    ZQSearchBarStyleCannel,
    ZQSearchBarStyleBack,
};

typedef NS_ENUM(NSUInteger, ZQSearchState) {
    ZQSearchStateNormal,
    ZQSearchStateEditing,
    ZQSearchStateResult,
};

@protocol ZQSearchViewDelegate<NSObject>

- (void)searchEditViewRefreshWithDataBlock:(void(^)(id data))block;
- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController;
- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController;

@end


@interface ZQSearchViewController : UIViewController

- (instancetype)initSearchViewWithHotDatas:(NSArray *)hotList resultController:(UIViewController *)resultController;

@property (nonatomic, weak) id<ZQSearchViewDelegate> delegate;

@end
