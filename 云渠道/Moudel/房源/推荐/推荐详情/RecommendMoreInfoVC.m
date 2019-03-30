
//
//  RecommendMoreInfoVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendMoreInfoVC.h"

@interface RecommendMoreInfoVC ()<WMPageControllerDataSource,WMPageControllerDelegate>


@property (nonatomic, strong) UIImageView *companyImg;

@property (nonatomic, strong) UILabel *fansL;

@property (nonatomic, strong) UILabel *commentL;

@property (nonatomic, strong) UILabel *praiseL;

@property (nonatomic, strong) UILabel *identityL;

@property (nonatomic, strong) UILabel *introL;



@end

@implementation RecommendMoreInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    
}

@end
