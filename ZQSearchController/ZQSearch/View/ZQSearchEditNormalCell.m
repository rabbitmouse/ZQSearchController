//
//  ZQSearchEditNormalCell.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchEditNormalCell.h"

@interface ZQSearchEditNormalCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ZQSearchEditNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)uploadCellWithData:(id)data {
    id<ZQSearchData> model = data;
    self.titleLabel.text = [NSString stringWithFormat:@"搜索 \"%@\"",model.title];
}


@end
