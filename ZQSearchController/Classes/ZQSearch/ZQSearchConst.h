//
//  ZQSearchConst.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#ifndef ZQSearchConst_h
#define ZQSearchConst_h

#import <UIKit/UIKit.h>

static NSString *ZQSearchHistorys = @"ZQSearchHistorys";

typedef NS_ENUM(NSUInteger, SearchEditType) {
    SearchEditTypeFuzzy = 1,
    SearchEditTypeConfirm = 2,
};

@protocol ZQSearchData<NSObject>
@required
@property (nonatomic, copy) NSString *title;

@optional
@property (nonatomic, assign) SearchEditType editType;
@property (nonatomic, strong) UIImage *image;//优先加载image图片
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *desc;

@end

@protocol ZQSearchChildViewDelegate<NSObject>

- (void)searchChildViewDidScroll;

- (void)searchChildViewDidSelectItem:(id)value;
- (void)searchChildViewDidSelectRow:(id)value;

@end


#define ZQ_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ZQSearchhistories.plist"] // the path of search record cached


#define ZQSearchWidth [UIScreen mainScreen].bounds.size.width
#define ZQSearchHeight [UIScreen mainScreen].bounds.size.height

//判断iPhoneX所有系列
#define Match_PhoneXAll ({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#define k_Height_NavContentBar 44.0f
#define k_Height_StatusBar (Match_PhoneXAll? 44.0 : 20.0)
#define k_Height_NavBar (Match_PhoneXAll ? 88.0 : 64.0)
#define k_Height_TabBar (Match_PhoneXAll ? 83.0 : 49.0)

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* ZQSearchConst_h */
