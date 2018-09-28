//
//  searchEditModel.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZQSearchConst.h"

@interface searchEditModel : NSObject<ZQSearchData>

@property (nonatomic, assign) SearchEditType editType;

@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

@end
