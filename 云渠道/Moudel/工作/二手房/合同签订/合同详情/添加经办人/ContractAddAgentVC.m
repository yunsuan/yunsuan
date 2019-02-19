//
//  ContractAddAgentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractAddAgentVC.h"

#import "DropDownBtn.h"

@interface ContractAddAgentVC ()

@property (nonatomic, strong) DropDownBtn *flowBtn;

@property (nonatomic, strong) DropDownBtn *agentBtn;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@end

@implementation ContractAddAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"添加经办人";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 175 *SIZE)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
}

@end
