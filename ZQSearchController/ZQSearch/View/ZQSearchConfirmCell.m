//
//  ZQSearchConfirmCell.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/26.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchConfirmCell.h"

@interface ZQSearchConfirmCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end


@implementation ZQSearchConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)uploadCellWithData:(id)data {
    id<ZQSearchData> model = data;
    self.titlelabel.text = model.title;
    self.descLabel.text = model.desc;
}


@end
