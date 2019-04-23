//
//  AuthenImgCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/4/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AuthenImgCell.h"

@implementation AuthenImgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 9 *SIZE, 100 *SIZE, 13 *SIZE)];
    label1.textColor = YJContentLabColor;
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.text = @"工牌照片";
    [self.contentView addSubview:label1];

    
    _imgView = [[UIImageView alloc] init];//WithFrame:CGRectMake(10 *SIZE, 3 *SIZE, 100 *SIZE, 83 *SIZE)];
    _imgView.image = [UIImage imageNamed:@"add_3"];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    [self.contentView addSubview:_imgView];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(40 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(83 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
