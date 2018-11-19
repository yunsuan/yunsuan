//
//  StoreAuthVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "StoreAuthVC.h"

#import "SelectStoreVC.h"

#import "TitleContentImgCell.h"
#import "StoreAuthCollCell.h"
#import "CompleteSurveyCollCell.h"

@interface StoreAuthVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    
    NSMutableArray *_selectArr;
    NSMutableArray *_roleArr;
    
    
    
    NSString *_name;
    NSString *_role;
    NSString *_storeId;
    BOOL _isEmp;
}

@property (nonatomic, strong) UIView *storeView;

@property (nonatomic, strong) UILabel *storeTL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIButton *storeBtn;

@property (nonatomic, strong) UIView *roleView;

@property (nonatomic, strong) UILabel *roleTL;

@property (nonatomic, strong) UICollectionView *roleColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIView *employeeView;

@property (nonatomic, strong) UILabel *employeeTL;

@property (nonatomic, strong) UILabel *employeeL;

@property (nonatomic, strong) UIButton *empBtn;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation StoreAuthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _titleArr = @[@"所属门店",@"",@"是否为本店员工"];
    _imgArr = @[@"rightarrow",@"",@"downarrow1"];
    
    _selectArr = [@[] mutableCopy];
    _roleArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:StoreAuthStoreRole_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _roleArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            for (int i = 0; i < _roleArr.count; i++) {
                
                [_selectArr addObject:@(0)];
            }
            [_roleColl reloadData];
            [_roleColl mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_roleView).offset(80 *SIZE);
                make.top.equalTo(_roleView).offset(20 *SIZE);
                make.width.mas_equalTo(280 *SIZE);
                make.height.mas_equalTo(_roleColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
                make.bottom.equalTo(_roleView).offset(-20 *SIZE);
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"获取权限列表失败"];
        NSLog(@"%@",error);
    }];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (!_storeL.text.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择门店"];
        return;
    }
    
    for (int i = 0; i < _selectArr.count; i++) {
        
        if ([_selectArr[i] integerValue] == 1) {
            
            if (!_role.length) {
                
                _role = [NSString stringWithFormat:@"%@",_roleArr[i][@"id"]];
            }else{
                
                _role = [NSString stringWithFormat:@"%@,%@",_role,_roleArr[i][@"id"]];
            }
        }
    }
    if (!_role.length) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择权限"];
        return;
    }
    
    if ([_employeeL.text isEqualToString:@"是"]) {
        
        _isEmp = YES;
    }else{
        
        _isEmp = NO;
    }
    [BaseRequest POST:PersonalSoreAuth_URL parameters:@{@"store_id":@([_storeId integerValue]),@"role":_role,@"is_store_staff":@(_isEmp)} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"申请成功，等待审核通过" WithDefaultBlack:^{
               
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"服务器网络错误，请稍后尝试"];
        NSLog(@"%@",error);
    }];
}

- (void)ActionStoreBtn:(UIButton *)btn{
    
    SelectStoreVC *nextVC = [[SelectStoreVC alloc] init];
    nextVC.selectStoreVCBlock = ^(NSString * _Nonnull storeId, NSString * _Nonnull storeName) {
        
        _storeL.text = storeName;
        _storeId = storeId;

    };
    [self.navigationController pushViewController:nextVC animated:YES];

}

- (void)ActionEmpBtn:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否为本店员工" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _employeeL.text = @"是";
    }];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _employeeL.text = @"否";
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:male];
    [alert addAction:female];
    [alert addAction:cancel];
    [self.navigationController presentViewController:alert animated:YES completion:^{
        
    }];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _roleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
    }
    
    [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
    cell.titleL.text = _roleArr[indexPath.row][@"param"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue]) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"门店认证";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(37 *SIZE, 14 *SIZE + NAVIGATION_BAR_HEIGHT, 200 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"认证需要审核 请仔细填写信息";
    [self.view addSubview:label];
    
    _storeView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 40 *SIZE, SCREEN_Width, 50 *SIZE)];
    _storeView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_storeView];
    
    _storeTL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 18 *SIZE, 70 *SIZE, 12 *SIZE)];
    _storeTL.textColor = YJTitleLabColor;
    _storeTL.font = [UIFont systemFontOfSize:13 *SIZE];
    _storeTL.text = @"所属门店";
    [_storeView addSubview:_storeTL];
    
    _storeL = [[UILabel alloc] initWithFrame:CGRectMake(124 *SIZE , 18 *SIZE, 200 *SIZE, 12 *SIZE)];
    _storeL.textColor = YJTitleLabColor;
    _storeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _storeL.textAlignment = NSTextAlignmentRight;
    [_storeView addSubview:_storeL];
    
    _storeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _storeBtn.frame = _storeView.bounds;
    [_storeBtn addTarget:self action:@selector(ActionStoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_storeView addSubview:_storeBtn];
    
    _roleView = [[UIView alloc] init];
    _roleView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_roleView];
    
    _roleTL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 18 *SIZE, 70 *SIZE, 12 *SIZE)];
    _roleTL.textColor = YJTitleLabColor;
    _roleTL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roleTL.text = @"申请权限";
    [_roleView addSubview:_roleTL];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.itemSize = CGSizeMake(110 *SIZE, 30 *SIZE);
    
    _roleColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 *SIZE, 280 *SIZE, 70 *SIZE) collectionViewLayout:_flowLayout];
    _roleColl.backgroundColor = CH_COLOR_white;
    _roleColl.delegate = self;
    _roleColl.dataSource = self;
    
    [_roleColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [_roleView addSubview:_roleColl];
    
    _employeeView = [[UIView alloc] init];
    _employeeView.backgroundColor = CH_COLOR_white;
    [self.view addSubview:_employeeView];
    
    _employeeTL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 18 *SIZE, 100 *SIZE, 12 *SIZE)];
    _employeeTL.textColor = YJTitleLabColor;
    _employeeTL.font = [UIFont systemFontOfSize:13 *SIZE];
    _employeeTL.text = @"是否为本店员工";
    [_employeeView addSubview:_employeeTL];
    
    _employeeL = [[UILabel alloc] initWithFrame:CGRectMake(124 *SIZE , 18 *SIZE, 200 *SIZE, 12 *SIZE)];
    _employeeL.textColor = YJTitleLabColor;
    _employeeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _employeeL.textAlignment = NSTextAlignmentRight;
    [_employeeView addSubview:_employeeL];
    
    _empBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _empBtn.frame = CGRectMake(0, 0, SCREEN_Width, 50 *SIZE);
    [_empBtn addTarget:self action:@selector(ActionEmpBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_employeeView addSubview:_empBtn];
    
    
    [_roleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(self.view).offset(91 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    [_roleColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_roleView).offset(80 *SIZE);
        make.top.equalTo(_roleView).offset(20 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
        make.height.mas_equalTo(_roleColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
        make.bottom.equalTo(_roleView).offset(-20 *SIZE);
    }];
    
    [_employeeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_roleView.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(50 *SIZE);
    }];
    
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(0, SCREEN_Height - TAB_BAR_MORE - 40 *SIZE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_commitBtn];
}

@end
