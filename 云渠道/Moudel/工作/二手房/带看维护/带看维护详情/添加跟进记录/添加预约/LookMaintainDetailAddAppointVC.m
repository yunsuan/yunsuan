//
//  LookMaintainDetailAddAppointVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailAddAppointVC.h"

#import "LookMaintainDetailVC.h"
#import "LookMaintainDetailAddAppointRoomVC.h"

#import "LookMaintainDetailAddAppointRoomModel.h"

#import "LookMaintainDetailAddAppointCell.h"
#import "LookMaintainDetailAddAppointCell2.h"

@interface LookMaintainDetailAddAppointVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSString *_takeId;
}
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UIButton *commintBtn;

@end

@implementation LookMaintainDetailAddAppointVC

- (instancetype)initWithTakeId:(NSString *)takeId
{
    self = [super init];
    if (self) {
        
        _takeId = takeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    LookMaintainDetailAddAppointRoomVC *nextVC = [[LookMaintainDetailAddAppointRoomVC alloc] initWithTakeId:_takeId];
    nextVC.dataDic = self.dataDic;
    nextVC.lookMaintainDetailAddAppointRoomVCBlock = ^(NSDictionary * _Nonnull dic) {
        
        [_dataArr addObject:dic];
        [_table reloadData];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)ActionCommitBtn:(UIButton *)btn{
    
    if (!_dataArr.count) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请选择带看房源"];
        return;
    }
    
    NSMutableArray *tempArr = [@[] mutableCopy];
    for (NSDictionary *dic in _dataArr) {
        
        LookMaintainDetailAddAppointRoomModel *model = dic[@"model"];
        [tempArr addObject:@{@"house_id":model.house_id,@"take_time":dic[@"take_time"]}];
    }
    [self.dataDic setObject:tempArr forKey:@"take_group"];
    [BaseRequest GET:TakeMaintainFollowAdd_URL parameters:self.dataDic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.lookMaintainDetailAddAppointVCBlock) {
                
                self.lookMaintainDetailAddAppointVCBlock();
            }
            for (UIViewController *vc in self.navigationController.viewControllers) {
                
                if ([vc isKindOfClass:[LookMaintainDetailVC class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count ? _dataArr.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        LookMaintainDetailAddAppointCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailAddAppointCell2"];
        if (!cell) {
            
            cell = [[LookMaintainDetailAddAppointCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailAddAppointCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = _dataArr[indexPath.row];
        
        return cell;
    }else{
        
        LookMaintainDetailAddAppointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LookMaintainDetailAddAppointCell"];
        if (!cell) {
            
            cell = [[LookMaintainDetailAddAppointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LookMaintainDetailAddAppointCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_dataArr.count) {
            
            LookMaintainDetailAddAppointRoomModel *model = _dataArr[indexPath.row][@"model"];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.imageView.image = [UIImage imageNamed:@"default_3"];
                }
            }];
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"add"];
        }
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        
    }else{
        
        LookMaintainDetailAddAppointRoomVC *nextVC = [[LookMaintainDetailAddAppointRoomVC alloc] initWithTakeId:_takeId];
        nextVC.dataDic = self.dataDic;
        nextVC.lookMaintainDetailAddAppointRoomVCBlock = ^(NSDictionary * _Nonnull dic) {
            
            [_dataArr addObject:dic];
            [tableView reloadData];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArr.count) {
        
        return YES;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"跟进记录";
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:[UIImage imageNamed:@"add_3"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.status integerValue] == 1) {
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 47 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = UITableViewAutomaticDimension;
        _table.estimatedRowHeight = 202.5 *SIZE;
        _table.backgroundColor = self.view.backgroundColor;
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
        
        _commintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commintBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
        _commintBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
        [_commintBtn addTarget:self action:@selector(ActionCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_commintBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_commintBtn setBackgroundColor:YJBlueBtnColor];
        [self.view addSubview:_commintBtn];
    }else{
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = UITableViewAutomaticDimension;
        _table.estimatedRowHeight = 202.5 *SIZE;
        _table.backgroundColor = self.view.backgroundColor;
        _table.delegate = self;
        _table.dataSource = self;
        [self.view addSubview:_table];
    }
}

@end
