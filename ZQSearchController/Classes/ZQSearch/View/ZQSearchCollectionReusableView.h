//
//  ZQSearchCollectionReusableView.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/25.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^emptyBlock)(void);

@interface ZQSearchCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) NSString *title;

- (void)showDeleteHistoryBtn:(BOOL)show CallBack:(void(^)(void))callBack;

@end
