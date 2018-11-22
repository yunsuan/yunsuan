//
//  MaintainLookHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainLookHeader.h"

@interface MaintainLookHeader()
{

    
}
@end

@implementation MaintainLookHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    NSArray *titleArr = @[@"近七日看房(次)",@"累计看房(次)"];
    NSArray *titleArr1 = @[@"看房日期",@"出价",@"带看人",@"联系方式"];
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:_blueView];
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:19 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            
            _numL = label;
            [_blueView addSubview:_numL];
        }else{
            
            _allL = label;
            [_blueView addSubview:_allL];
        }
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(180 *SIZE * i, 42 *SIZE, 180 *SIZE, 12 *SIZE)];
        label1.textColor = [UIColor whiteColor];
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        [_blueView addSubview:label1];
    }
    
    _lightView = [[UIView alloc] init];
    _lightView.backgroundColor = COLOR(224, 241, 255, 1);
    [self.contentView addSubview:_lightView];
    
    for (int i = 0;  i < 4; i++) {
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.textColor = YJContentLabColor;
        label2.font = [UIFont systemFontOfSize:12 *SIZE];
        label2.text = titleArr1[i];
        switch (i) {
            case 0:
            {
                _timeL = label2;
                [_lightView addSubview:_timeL];
                break;
            }
            case 1:
            {
                _priceL = label2;
                [_lightView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _agentL = label2;
                [_lightView addSubview:_agentL];
                break;
            }
            case 3:
            {
                _phoneL = label2;
                [_lightView addSubview:_phoneL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_blueView).offset(0 *SIZE);
        make.top.equalTo(_blueView).offset(14 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
        make.bottom.equalTo(_blueView).offset(-38 *SIZE);
    }];
    
    [_allL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_blueView).offset(180 *SIZE);
        make.top.equalTo(_blueView).offset(14 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
        make.bottom.equalTo(_blueView).offset(-38 *SIZE);
    }];
    
    [_lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_blueView.mas_bottom).offset(0 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_lightView).offset(10 *SIZE);
        make.top.equalTo(_lightView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.bottom.equalTo(_lightView).offset(-15 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_lightView).offset(100 *SIZE);
        make.top.equalTo(_lightView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.bottom.equalTo(_lightView).offset(-15 *SIZE);
    }];
    
    [_agentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_lightView).offset(190 *SIZE);
        make.top.equalTo(_lightView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.bottom.equalTo(_lightView).offset(-15 *SIZE);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_lightView).offset(280 *SIZE);
        make.top.equalTo(_lightView).offset(14 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.bottom.equalTo(_lightView).offset(-15 *SIZE);
    }];
}

@end
