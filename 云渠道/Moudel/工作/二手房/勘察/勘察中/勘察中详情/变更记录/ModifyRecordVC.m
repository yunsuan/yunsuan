//
//  ModifyRecordVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyRecordVC.h"

#import "TitleContentBaseCell.h"

@interface ModifyRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_surveyId;
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation ModifyRecordVC

- (instancetype)initWithSurveyId:(NSString *)surveyId
{
    self = [super init];
    if (self) {
        
        _surveyId = surveyId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseSurveyChangeReserveTimeHis_URL parameters:@{@"survey_id":_surveyId} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleContentBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleContentBaseCell"];
    if (!cell) {
        
        cell = [[TitleContentBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleContentBaseCell"];
    }
    cell.contentL.textAlignment = NSTextAlignmentRight;
    cell.contentL.textColor = YJContentLabColor;
    cell.titleL.textColor = YJTitleLabColor;
    [cell.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(110*SIZE);
        make.top.equalTo(cell.contentView).offset(14*SIZE);
        make.right.mas_equalTo(-10*SIZE);
        
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        cell.titleL.text = [NSString stringWithFormat:@"初始时间：%@",_dataArr[indexPath.row][@"old_time"]];
        cell.contentL.text = [NSString stringWithFormat:@"变更时间：%@",_dataArr[indexPath.row][@"create_time"]];
    }else{
        
        cell.titleL.text = [NSString stringWithFormat:@"第%ld次时间：%@",(long)indexPath.row,_dataArr[indexPath.row][@"old_time"]];
        cell.contentL.text = [NSString stringWithFormat:@"变更时间：%@",_dataArr[indexPath.row][@"create_time"]];
    }
    [cell.titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(10*SIZE);
        make.top.equalTo(cell.contentView).offset(14 *SIZE);
        make.width.mas_equalTo(160 *SIZE);
    }];
    
    [cell.contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(cell.contentView).offset(190*SIZE);
        make.top.equalTo(cell.contentView).offset(14*SIZE);
        make.width.mas_equalTo(160*SIZE);
        
    }];
    
    
    return cell;
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"变更记录";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
