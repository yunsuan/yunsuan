//
//  MakeDateLookVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MakeDateLookVC.h"

#import "DropDownBtn.h"
#import "BaseHeader.h"

@interface MakeDateLookVC ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) BaseHeader *header;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@end

@implementation MakeDateLookVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
}

- (void)ActionTimeBtn:(UIButton *)btn{
    
    
}

- (void)initUI{
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    _header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _header.titleL.text = @"预约看房";
    [_contentView addSubview:_header];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            _seeWayL = label;
            [_contentView addSubview:_seeWayL];
        }else if (i == 1){
            
            _contactL = label;
            [_contentView addSubview:_contactL];
        }else{
            
            _phoneL = label;
            [_contentView addSubview:_phoneL];
        }
    }
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [_contentView addSubview:_timeL];
    
    _timeBtn = [[DropDownBtn alloc] initWithFrame:CGRectMake(0, 0, 291 *SIZE, 33 *SIZE)];
    [_timeBtn addTarget:self action:@selector(ActionTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_timeBtn];
}

@end
