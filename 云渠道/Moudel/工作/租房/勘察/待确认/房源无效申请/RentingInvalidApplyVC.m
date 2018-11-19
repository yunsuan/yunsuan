//
//  RentingInvalidApplyVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingInvalidApplyVC.h"

#import "DropDownBtn.h"

@interface RentingInvalidApplyVC ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) DropDownBtn *typeBtn;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RentingInvalidApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initDataSource];
}

- (void)initDataSource{
    
    _roomL.text = @"天鹅湖小区 - 17栋 - 2单元 - 103";
    _codeL.text = @"房源编号：CD - TEH - 20170810 - 1（F）";
    _storeL.text = @"归属门店：MDBHNO1";
    _typeL.text = @"无效类型:";
    _reasonL.text = @"无效描述:";
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房源无效申请";
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_contentView];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i < 3) {
            
            label.numberOfLines = 0;
            label.textColor = YJTitleLabColor;
            if (i == 0) {
                
                _roomL = label;
                [_contentView addSubview:_roomL];
            }else if (i == 1){
                
                _codeL = label;
                [_contentView addSubview:_codeL];
            }else{
                
                _storeL = label;
                [_contentView addSubview:_storeL];
            }
        }else{
            
            label.textColor = YJ86Color;
            if (i == 3) {
                
                _typeL = label;
                [_contentView addSubview:_typeL];
            }else{
                
                _reasonL = label;
                [_contentView addSubview:_reasonL];
            }
        }
    }
    
    _typeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(81 *SIZE, 114 *SIZE, 257 *SIZE, 33 *SIZE)];
    [_contentView addSubview:_typeBtn];
    
    _reasonTV = [[UITextView alloc] init];
    _reasonTV.layer.cornerRadius = 5 *SIZE;
    _reasonTV.clipsToBounds = YES;
    _reasonTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _reasonTV.layer.borderWidth = SIZE;
    [_contentView addSubview:_reasonTV];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(22 *SIZE, 494 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT *SIZE);
        make.right.equalTo(self.view).offset(0 *SIZE);
        //        make.width.mas_equalTo(SCREEN_Width);
        //        make.height.mas_equalTo(SIZE);
        //        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_contentView).offset(14 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_roomL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_storeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(34 *SIZE);
        make.right.equalTo(_contentView).offset(-9 *SIZE);
    }];
    
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_storeL.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(9 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(35 *SIZE);
        make.right.equalTo(_contentView).offset(-280 *SIZE);
        make.bottom.equalTo(_contentView).offset(-72 *SIZE);
    }];
    
    [_reasonTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_contentView).offset(81 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(24 *SIZE);
        make.width.mas_equalTo(257 *SIZE);
        make.height.mas_equalTo(77 *SIZE);
    }];
}

@end
