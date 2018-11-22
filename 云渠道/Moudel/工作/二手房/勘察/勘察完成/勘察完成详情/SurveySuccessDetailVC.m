//
//  SurveySuccessDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessDetailVC.h"
#import "SurveySuccessRoomDetailVC.h"
#import "SurveySuccessOwnerDetailVC.h"

#import "SingleContentCell.h"
#import "BlueTitleMoreHeader.h"
#import "SurveySuccessDetailHeader.h"
#import "SurveySuccessImgCell.h"

@interface SurveySuccessDetailVC ()<UITableViewDataSource,UITableViewDelegate,SurveySuccessDetailHeaderDelegate>
{
    NSInteger _item;
    NSArray *_titleArr;
    NSArray *_titleArr2;
    NSArray *_contentArr;
    NSArray *_contentArr2;
    NSArray *_headerArr;
}
@property (nonatomic, strong) UITableView *mainTable;

@end

@implementation SurveySuccessDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"",@"联系信息",@"业主信息",@"房源信息",@"房源真实图片"];
    _titleArr2 = @[@"",@"参考信息",@"项目分析",@"优势标签"];
    _headerArr = @[@"挂牌标题：张三",@"对外报价：75",@"付款方式：一次性付款",@"产权所属：张三",@"抵押信息：无",@"产权年限：60",@"看房方式：带看",@"卖房意愿度：45",@"卖房急迫度：45",@"出售原由：业主诚心出售此房  看房方便  可按揭                        支持商贷、公积金"];
    _contentArr2 = @[@[],@[@"预估价格：80",@"意向客源数量：23",@"预估卖出周期：3周"],@[@"房源优势：",@"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。",@"房源优势：",@"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。"]];
    _contentArr = @[@[],@[@"联系人：张三",@"联系电话：15201234567"],@[@"联系人：张三",@"联系电话：15201234567"],@[@"物业类型：住宅",@"户型：三室一厅一卫、两室一厅一卫",@"产权面积：80㎡-120㎡",@"朝向：东南"]];
}


- (void)ActionRightBtn:(UIButton *)btn{
    
    
}

#pragma mark -- tableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_item == 0) {
        
        return 5;
    }else{
        
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }
    return 40 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        SurveySuccessDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SurveySuccessDetailHeader"];
        if (!header) {
            
            header = [[SurveySuccessDetailHeader alloc] initWithReuseIdentifier:@"SurveySuccessDetailHeader"];
            
        }
        if (_item == 0) {
            
            [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }else{
            
            [header.headerColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }
        header.delegate = self;
        
        header.baseHeader.titleL.text = @"房源编号：SCCDPDHPXQ-0302102";
        header.titleL.text = _headerArr[0];
        header.priceL.text = _headerArr[1];
        header.payWayL.text = _headerArr[2];
        header.propertyL.text = _headerArr[3];
        header.mortgageL.text = _headerArr[4];
        header.yearL.text = _headerArr[5];
        header.seeWayL.text = _headerArr[6];
        header.intentL.text = _headerArr[7];
        header.urgentL.text = _headerArr[8];
        header.reasonL.text = _headerArr[9];
        return header;
    }else{
        
        if (_item == 0) {
            
            if (section == 1 || section == 4){
                
                BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
                if (!header) {
                    
                    header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
                }
                
                header.titleL.text = _titleArr[section];
                header.lineView.backgroundColor = [UIColor whiteColor];
                return header;
            }else{
                
                BlueTitleMoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BlueTitleMoreHeader"];
                if (!header) {
                    
                    header = [[BlueTitleMoreHeader alloc] initWithReuseIdentifier:@"BlueTitleMoreHeader"];
                }
                header.blueTitleMoreHeaderBlock = ^{
                    
                    if (section == 2) {
                        
                        SurveySuccessOwnerDetailVC *nextVC = [[SurveySuccessOwnerDetailVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }else{
                        
                        SurveySuccessRoomDetailVC *nextVC = [[SurveySuccessRoomDetailVC alloc] init];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                };
                header.titleL.text = _titleArr[section];
                header.lineView.backgroundColor = [UIColor whiteColor];
                return header;
            }
        }else{
            
            BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
            if (!header) {
                
                header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
            }
            
            header.titleL.text = _titleArr2[section];
            header.lineView.backgroundColor = [UIColor whiteColor];
            return header;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_item == 0) {
        
        if (section == 0) {
            
            return 0;
        }else if (section == 3){
            
            return 4;
        }else if (section == 4){
            
            return 1;
        }else{
            
            return 2;
        }
    }else{
        
        if (section == 0) {
            
            return 0;
        }else if (section == 2){
            
            return 4;
        }else if (section == 3){
            
            return 1;
        }else{
            
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 4) {
        
        SurveySuccessImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SurveySuccessImgCell"];
        if (!cell) {
            
            cell = [[SurveySuccessImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SurveySuccessImgCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.numL.text = @"客厅1/5";
        return cell;
    }else{
        
        if (_item == 0) {
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentL.text = _contentArr[indexPath.section][indexPath.row];
            cell.lineView.hidden = YES;
            return cell;
        }else{
            
            if (indexPath.section == 3) {
                
                SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
                if (!cell) {
                    
                    cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.lineView.hidden = YES;
                return cell;
            }else{
                
                SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
                if (!cell) {
                    
                    cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleContentCell"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentL.text = _contentArr2[indexPath.section][indexPath.row];
                cell.lineView.hidden = YES;
                return cell;
            }
        }
    }
}


#pragma mark -- surveySuccessDetailHeaderDelegate;
- (void)surveySuccessDetailHeaderCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _item = indexPath.item;
    [_mainTable reloadData];
}

- (void)initUI{
    
    self.titleLabel.text = @"房源详情";
    self.navBackgroundView.hidden = NO;
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setImage:[UIImage imageNamed:@"add_1"] forState:UIControlStateNormal];
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 260 *SIZE;
    _mainTable.estimatedSectionHeaderHeight = 476 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_mainTable];
}

@end
