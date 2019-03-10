//
//  AuthenedVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenedVC.h"
#import "AuthenTableCell.h"
#import "AuthenCollCell.h"
//#import "SelectCompanyVC.h"
#import "AuthenticationVC.h"
#import "AuthenedTableHeader.h"

@interface AuthenedVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
//    NSMutableArray *_imgArr;
//    NSInteger _index;
    NSDictionary *_dataDic;
}
@property (nonatomic, strong) UITableView *authenTable;

@property (nonatomic, strong) UICollectionView *authenColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *dimissionBtn;

@end

@implementation AuthenedVC

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        _dataDic = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = [[NSMutableArray alloc] init];
    NSArray *tempArr = @[_dataDic[@"company_name"],_dataDic[@"work_code"],_dataDic[@"company_name"],_dataDic[@"butter_project"],_dataDic[@"department"],_dataDic[@"position"],_dataDic[@"create_time"]];
    _contentArr = [NSMutableArray arrayWithArray:tempArr];
    if ([_dataDic[@"role"] integerValue] == 1) {
        
        _contentArr[2] = @"经纪人";
        _contentArr[3] = @"";

    }else if ([_dataDic[@"role"] integerValue] == 2){
        
        _contentArr[2] = @"确认人";
        _contentArr[3] = _dataDic[@"butter_project"];

    }else{
        
        _contentArr[2] = @"确认单签字人";
        _contentArr[3] = _dataDic[@"butter_project"];

    }
    _titleArr = @[@"所属公司",@"工号",@"角色",@"申请项目",@"所属部门",@"职位",@"入职/申请时间"];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
    nextVC.status = @"重新认证";
    nextVC.beforeId = _dataDic[@"id"];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [BaseRequest GET:QuitAuth_URL parameters:@{@"id":_dataDic[@"id"]} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"离职成功" And:nil WithDefaultBlack:^{
                
                [UserModel defaultModel].agent_identity = @"3";
                [UserModelArchiver archive];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

#pragma mark --table代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 117 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AuthenedTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AuthenedTableHeader"];
    if (!header) {
        
        header = [[AuthenedTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 117 *SIZE)];
    }
    
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * Identifier = @"AuthenTableCell";
    AuthenTableCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        
        cell = [[AuthenTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightView.hidden = YES;
    cell.titleL.text = _titleArr[(NSUInteger) indexPath.row];
    cell.contentL.text = _contentArr[(NSUInteger) indexPath.row];
    return cell;
}


#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = YES;
    NSString *imgname = _dataDic[@"img_url"];
    if (imgname.length>0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                cell.imageView.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"default_3"];
    }

    
    return cell;
}


- (void)initUI{
    
    self.titleLabel.text = @"公司认证";
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width, 806 *SIZE);
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _authenTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 478 *SIZE) style:UITableViewStylePlain];
    _authenTable.backgroundColor = self.view.backgroundColor;
    _authenTable.delegate = self;
    _authenTable.dataSource = self;
    _authenTable.bounces = NO;
    _authenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _authenTable.tableFooterView = [[UIView alloc] init];
    [_scrollView addSubview:_authenTable];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_authenTable.frame), SCREEN_Width, 174 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:whiteView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 100 *SIZE, 13 *SIZE)];
    label1.textColor = YJContentLabColor;
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.text = @"工牌照片";
    [whiteView addSubview:label1];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl.backgroundColor = [UIColor whiteColor];
    _authenColl.delegate = self;
    _authenColl.dataSource = self;
    
    [_authenColl registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [whiteView addSubview:_authenColl];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(21 *SIZE, 37 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 2 *SIZE;
    _commitBtn.backgroundColor = YJLoginBtnColor;
    [_commitBtn setTitle:@"重新认证" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_commitBtn];
    
    _dimissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dimissionBtn.frame = CGRectMake(21 *SIZE, 87 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _dimissionBtn.layer.masksToBounds = YES;
    _dimissionBtn.layer.cornerRadius = 2 *SIZE;
    _dimissionBtn.backgroundColor = YJLoginBtnColor;
    [_dimissionBtn setTitle:@"离职" forState:UIControlStateNormal];
    [_dimissionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _dimissionBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_dimissionBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_dimissionBtn];
}

@end
