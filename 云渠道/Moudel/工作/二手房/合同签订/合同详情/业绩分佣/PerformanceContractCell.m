//
//  PerformanceContractCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "PerformanceContractCell.h"

@implementation PerformanceContractCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = YJBackColor;
        
        if (i == 0) {
            
            _typeL = label;
            [self.contentView addSubview:_typeL];
            
            _line1 = line;
            [self.contentView addSubview:_line1];
        }else if (i == 1){
            
            _salemanL = label;
            [self.contentView addSubview:_salemanL];
            
            _line2 = line;
            [self.contentView addSubview:_line2];
        }else if (i == 2){
            
            _propertyL = label;
            [self.contentView addSubview:_propertyL];
            
            _line3 = line;
            [self.contentView addSubview:_line3];
        }else if (i == 3){
            
            _moneyL = label;
            [self.contentView addSubview:_moneyL];
            
            _line4 = line;
            [self.contentView addSubview:_line4];
        }else{
            
            _storeL = label;
            [self.contentView addSubview:_storeL];
            
            _line5 = line;
            [self.contentView addSubview:_line5];
        }
    }
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(62 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_salemanL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(77 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(62 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(149 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(62 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(223 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(62 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-5 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(62 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(72 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
//        make..mas_equalTo(1 *SIZE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(144 *SIZE);
            make.top.equalTo(self.contentView).offset(0 *SIZE);
            make.width.mas_equalTo(1 *SIZE);
            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    //        make..mas_equalTo(1 *SIZE);
        }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(216 *SIZE);
            make.top.equalTo(self.contentView).offset(0 *SIZE);
            make.width.mas_equalTo(1 *SIZE);
            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    //        make..mas_equalTo(1 *SIZE);
        }];
    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(288 *SIZE);
            make.top.equalTo(self.contentView).offset(0 *SIZE);
            make.width.mas_equalTo(1 *SIZE);
            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    //        make..mas_equalTo(1 *SIZE);
        }];
    
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0 *SIZE);
            make.top.equalTo(_typeL.mas_bottom).offset(10 *SIZE);
            make.height.mas_equalTo(1 *SIZE);
            make.width.mas_equalTo(360 *SIZE);
            make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    //        make..mas_equalTo(1 *SIZE);
        }];
}
@end
