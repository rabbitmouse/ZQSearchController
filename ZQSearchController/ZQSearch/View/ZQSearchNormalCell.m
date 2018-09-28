//
//  ZQSearchNormalCell.m
//  ZQSearchController
//
//  Created by zzq on 2018/9/25.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import "ZQSearchNormalCell.h"
#import "UIColor+ZQSearch.h"

@interface ZQSearchNormalCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ZQSearchNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    [self changeStyleWith:NO];
}

- (void)changeStyleWith:(BOOL)heightLight {
    self.backgroundColor = heightLight ? [UIColor colorWithHexString:@"#00BC71" alpha:0.1] : [UIColor colorWithHexString:@"F7F7F7" alpha:1];
    self.titleLabel.textColor = heightLight ? [UIColor colorWithHexString:@"#00BC71" alpha:1] : [UIColor colorWithHexString:@"494949" alpha:1];
}

- (void)setHeightLight:(BOOL)heightLight {
    _heightLight = heightLight;
    [self changeStyleWith:heightLight];
}

- (void)setTitle:(NSString *)title {
    _title = title.copy;
    self.titleLabel.text = title;
}

@end
