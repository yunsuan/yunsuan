//
//  AddContractCell5.m
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddContractCell5.h"

@implementation AddContractCell5

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = YJBackColor;
    
//    _addBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add10"]];
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"add10"] forState:UIControlStateNormal];
    //    _addImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_addBtn];
    
    _notesL = [[UILabel alloc]init];
    _notesL.font = [UIFont systemFontOfSize:10*SIZE];
    _notesL.text =@"*置顶后自动设置为主权益人";
    _notesL.textAlignment = NSTextAlignmentCenter;
    _notesL.textColor = COLOR(170, 170, 170, 1);
    [self.contentView addSubview:_notesL];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(22 *SIZE);
        make.top.equalTo(self.contentView).offset(19 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-19 *SIZE);
    }];
    
    [_notesL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_addBtn.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    //    _addImg.image
}

@end
