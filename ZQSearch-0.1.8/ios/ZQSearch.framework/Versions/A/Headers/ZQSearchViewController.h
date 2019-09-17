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

@required
- (void)searchFuzzyResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController;
@optional
- (void)searchEditViewRefreshWithKeyString:(NSString *)keyString DataBlock:(void(^)(id data))block;
- (void)searchConfirmResultWithKeyString:(NSString *)keyString Data:(id<ZQSearchData>)data resultController:(UIViewController *)resultController;

@end


@interface ZQSearchViewController : UIViewController

- (instancetype)initSearchViewWithHotDatas:(NSArray *)hotList resultController:(UIViewController *)resultController;

@property (nonatomic, weak) id<ZQSearchViewDelegate> delegate;

@property (nonatomic, assign) BOOL closeFuzzyTable;//default is NO, 如果设置为YES，将不显示模糊匹配列表。可以不实现searchEditViewRefreshWithDataBlock和searchConfirmResultWithKeyString这两个代理。
@property (nonatomic, copy) NSString *placeholder;

@end
