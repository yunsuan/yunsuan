//
//  ModifyProjectAnalysisVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyProjectAnalysisVC.h"

#import "BaseHeader.h"

@interface ModifyProjectAnalysisVC ()
{
    
    NSMutableArray *_dataArr;
    NSArray *_titleArr;
    NSArray *_tagArr;
    NSArray *_contentArr;
    NSMutableDictionary *_dataDic;
}

@property (nonatomic, strong) UITextView *sellTV;

@property (nonatomic, strong) UITextView *decoTV;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation ModifyProjectAnalysisVC

- (instancetype)initWithData:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = @[@"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。"];
    _tagArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _dataArr = [[NSMutableArray alloc] init];
    _titleArr = @[@"核心卖点",@"装修描述"];
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic;
    dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"house_id":self.houseId,@"type":self.typeId}];
    if (![self isEmpty:_sellTV.text]) {
        
        if ([self.typeId integerValue] == 1) {

            [dic setObject:_sellTV.text forKey:@"core_selling"];
        }else{
            
            [dic setObject:_sellTV.text forKey:@"advantage"];
        }
    }else{
        
        if ([self.typeId integerValue] == 1) {
            
            [dic setObject:@" " forKey:@"core_selling"];
        }else{
            
            [dic setObject:@" " forKey:@"advantage"];
        }
    }
    
    if (![self isEmpty:_decoTV.text]) {
        
        if ([self.typeId integerValue] == 1) {
            
            [dic setObject:_decoTV.text forKey:@"decoration_standard"];
        }else{
            
            [dic setObject:_decoTV.text forKey:@"describe"];
        }
    }else{
        
        if ([self.typeId integerValue] == 1) {
            
            [dic setObject:@" " forKey:@"decoration_standard"];
        }else{
            
            [dic setObject:@" " forKey:@"describe"];
        }
    }
    
    
    [BaseRequest POST:HouseSurveyUpdateHouseInfo_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyProjectAnalysisVCBlock) {
                
                self.modifyProjectAnalysisVCBlock();
            }
            [self alertControllerWithNsstring:@"修改成功" And:@"修改成功" WithDefaultBlack:^{
               
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"修改失败"];
    }];
}




- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"修改勘察信息";
   
    for (int i = 0; i < 2; i++) {
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + i * 147 *SIZE, SCREEN_Width, 140 *SIZE)];
        whiteView.backgroundColor = [UIColor whiteColor];
        
//        BaseHeader *header = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        BaseHeader *header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        header.frame = CGRectMake(0, 0, SCREEN_Width, 40 *SIZE);
//        header.titleL.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        if (i == 0) {
            
            header.titleL.text = @"核心卖点";
        }else{
            
            header.titleL.text = @"装修描述";
        }
        [whiteView addSubview:header];
        
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(28 *SIZE, 47 *SIZE, 314 *SIZE, 75 *SIZE)];
        tv.font = [UIFont systemFontOfSize:12 *SIZE];
        tv.textColor = YJContentLabColor;
        if (i == 0) {
            
            if ([self.typeId integerValue] == 1) {
                
                tv.text = _dataDic[@"core_selling"];
            }else{
                
                tv.text = _dataDic[@"advantage"];
            }
            _sellTV = tv;
            [whiteView addSubview:_sellTV];
        }else{
            
            if ([self.typeId integerValue] == 1) {
                
                tv.text = _dataDic[@"decoration_standard"];
            }else{
                
                tv.text = _dataDic[@"describe"];
            }
            _decoTV = tv;
            [whiteView addSubview:_decoTV];
        }
        [self.view addSubview:whiteView];
    }
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
}

@end
