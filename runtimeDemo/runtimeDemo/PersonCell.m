//
//  PersonCell.m
//  runtimeDemo
//
//  Created by zhs on 15/11/19.
//  Copyright (c) 2015年 zhs. All rights reserved.
//

#import "PersonCell.h"
#import <Masonry.h>

@implementation PersonCell
{
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.label = [UILabel new];
    _label.backgroundColor = [UIColor greenColor];
    _label.numberOfLines = 0;
    [self.contentView addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(self.contentView).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10) ;
    }];
}

- (void)setInforStr:(NSString *)inforStr {
    _inforStr = inforStr;
    
    
    _label.text = inforStr;
}
@end
