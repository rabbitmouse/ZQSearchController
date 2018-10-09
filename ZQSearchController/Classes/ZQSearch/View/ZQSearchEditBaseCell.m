//
//  ZQSearchEditBaseCell.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchEditBaseCell.h"

static NSString *searchEditCellIdentifier = @"searchEditCellIdentifier";
static NSString *searchCustomCellIdentifier = @"searchCustomCellIdentifier";

@implementation ZQSearchEditBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)childCellIdentifierWith:(id)key {
    if ([key intValue] == SearchEditTypeFuzzy) {
        return searchEditCellIdentifier;
    } else {
        return searchCustomCellIdentifier;
    }
}

+ (CGFloat)heightWithType:(SearchEditType)type {
    return type == SearchEditTypeFuzzy ? 44 : 80;
}

- (void)uploadCellWithData:(id)data {
    //子类实现
}

@end
