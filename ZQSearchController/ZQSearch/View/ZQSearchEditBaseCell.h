//
//  ZQSearchEditBaseCell.h
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQSearchConst.h"

@protocol searchEditCellProtocol<NSObject>

- (void)uploadCellWithData:(id)data;

@end

@interface ZQSearchEditBaseCell : UITableViewCell<searchEditCellProtocol>

+ (NSString *)childCellIdentifierWith:(id)key;
+ (CGFloat)heightWithType:(SearchEditType)type;

@end
