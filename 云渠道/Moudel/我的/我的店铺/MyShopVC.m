//
//  MyShopVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopVC.h"

#import "MyShopProjectListVC.h"
#import "MyShopTagVC.h"
#import "MyShopRecommendVC.h"
#import "MyShopRecommendDetailVC.h"
#import "MyShopServeRegionVC.h"
#import "MyShopCustomListVC.h"

#import "BlueTitleMoreHeader.h"
#import "MyShopHeader.h"
#import "MyShopBtnHeader.h"

#import "MyShopTagView.h"


#import "MyShopRoomCell.h"
#import "MyShopCommentCell.h"

#import "STCommentEditView.h"

@interface MyShopVC ()<UITableViewDelegate,UITableViewDataSource, NFCommentEditViewDelegate>
{
    
    NSString *_comment_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_tagArr;
    NSMutableArray *_addressArr;;
    NSMutableArray *_roomArr;
    NSMutableArray *_commentArr;
}

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) STCommentEditView *editView;

@end

@implementation MyShopVC

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _dataDic = [@{} mutableCopy];
    
    _tagArr = [@[] mutableCopy];
    _addressArr = [@[] mutableCopy];
    _roomArr = [@[] mutableCopy];
    _commentArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:GetOnlineStoreInfo_URL parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            _roomArr = [NSMutableArray arrayWithArray:_dataDic[@"recommend_house_list"]];
            _commentArr = [NSMutableArray arrayWithArray:_dataDic[@"comment_list"]];
            
            for (int i = 0; i < _commentArr.count; i++) {
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:_commentArr[i]];
                [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                   
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        if (![key isEqualToString:@"comment_tags"] && ![key isEqualToString:@"replyList"]) {
                            
                            [dic setValue:@"" forKey:key];
                        }else{
                            
                            [dic setValue:@[] forKey:key];
                        }
                    }
                }];
                
                [_commentArr replaceObjectAtIndex:i withObject:dic];
            }
            
            NSArray *arr;
            if ([_dataDic[@"self_tags"] length]) {
                
                arr = [_dataDic[@"self_tags"] componentsSeparatedByString:@","];
            }else{
                
                arr = @[];
            }
            _tagArr = [NSMutableArray arrayWithArray:arr];
            
            NSArray *arr1;
            if ([_dataDic[@"service_area"] length]) {
                
                arr1 = [_dataDic[@"service_area"] componentsSeparatedByString:@","];
            }else{
                
                arr1 = @[];
            }
            _addressArr = [NSMutableArray arrayWithArray:arr1];
            
            [_table reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"endEdit" object:nil];
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    if (_tagArr.count) {
        
        NSString *str = [_tagArr componentsJoinedByString:@","];
        [tempDic setValue:str forKey:@"self_tags"];
    }else{
        
        [tempDic setValue:@"" forKey:@"self_tags"];
    }
    if (_addressArr.count) {
        
        NSString *str = [_addressArr componentsJoinedByString:@","];
        [tempDic setValue:str forKey:@"service_area"];
    }else{
        
        [tempDic setValue:@"" forKey:@"service_area"];
    }
    [BaseRequest POST:UpdateOnlineStoreInfo_URL parameters:tempDic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self showContent:@"修改成功"];
            [self RequestMethod];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}



#pragma mark - NFCommentToolViewDelegate

- (void)commentToolViewContentButtonClicked {
    NSLog(@"写评论...");
    
//    [self.editView updatePlaceholder:@"优质内容将会优先展示"];
    self.editView.hidden = NO;
    [self.editView show];
}

- (void)commentToolViewShareButtonClicked {
    NSLog(@"点击了分享");
}

- (void)commentToolViewArticleButtonClicked {
    NSLog(@"点击了文章");
}

#pragma mark - NFCommentEditViewDelegate

- (void)commentEditView:(STCommentEditView *)commentEditView didRequsetStatus:(BOOL)success {
    if (success) {
        NSLog(@"发送成功！");
        
        [BaseRequest POST:AddRelyComment_URL parameters:@{@"reply_comment":commentEditView.inputView.text,@"comment_id":_comment_id} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue]) {
                
                [self RequestMethod];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
    
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    } else {
        NSLog(@"发送失败");
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        return _roomArr.count;
    }else{
        
        return _commentArr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MyShopHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyShopHeader"];
        if (!header) {
            
            header = [[MyShopHeader alloc] initWithReuseIdentifier:@"MyShopHeader"];
        }
        
        header.dataDic = _dataDic;
        header.tagArr = _tagArr;
        header.addressArr = _addressArr;
        header.myShopHeaderAddBlock = ^{

            MyShopTagView *view = [[MyShopTagView alloc] initWithFrame:self.view.bounds];
            view.myShopTagViewBlock = ^{
                
                if (![self isEmpty:view.tagTF.textfield.text]) {
                    
                    [_tagArr addObject:view.tagTF.textfield.text];
                }
                [_table reloadData];
                [self ActionSaveBtn:self.rightBtn];
            };
            [self.view addSubview:view];
        };
        
        header.myShopHeaderAddressBtnBlock = ^{
            
            self.editView.delegate = nil;
            [self.editView removeFromSuperview];
            MyShopServeRegionVC *nextVC = [[MyShopServeRegionVC alloc] init];
            nextVC.myShopServeRegionVCBlock = ^(NSString * _Nonnull city) {
                
                [_addressArr addObject:city];
                [_table reloadData];
                [self ActionSaveBtn:self.rightBtn];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        
        header.myShopHeaderAddressEditBlock = ^(NSInteger idx) {
        
            [_addressArr removeObjectAtIndex:idx];
            [_table reloadData];
            [self ActionSaveBtn:self.rightBtn];
        };
        
        header.myShopHeaderDeleteBlock = ^(NSInteger idx) {
        
            [_tagArr removeObjectAtIndex:idx];
            [_table reloadData];
            [self ActionSaveBtn:self.rightBtn];
        };
        
        return header;
    }else{
        
        MyShopBtnHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyShopBtnHeader"];
        if (!header) {
            
            header = [[MyShopBtnHeader alloc] initWithReuseIdentifier:@"MyShopBtnHeader"];
        }
        
        if (section == 1) {
            
            header.titleL.text = @"新房推荐";
            header.moreBtn.hidden = NO;
            header.addBtn.hidden = NO;
            [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
            [header.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(header.contentView).offset(-45 *SIZE);
            }];
        }else{
            
            header.titleL.text = @"客户评论";
            header.moreBtn.hidden = NO;
            header.addBtn.hidden = YES;
            [header.moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
            [header.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(header.contentView).offset(-10 *SIZE);
            }];
        }
        
        header.myShopBtnHeaderAddBlock = ^{
          
            self.editView.delegate = nil;
            [self.editView removeFromSuperview];
            MyShopProjectListVC *nextVC = [[MyShopProjectListVC alloc] init];
            nextVC.myShopProjectListVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        header.myShopBtnHeaderMoreBlock = ^{
            
            if (section == 1) {
                
                self.editView.delegate = nil;
                [self.editView removeFromSuperview];
                MyShopRecommendVC *nextVC = [[MyShopRecommendVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
                
                self.editView.delegate = nil;
                [self.editView removeFromSuperview];
                MyShopCustomListVC *nextVC = [[MyShopCustomListVC alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
            
        };
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return nil;
    }else if (indexPath.section == 1){
        
        MyShopRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopRoomCell"];
        if (!cell) {
            
            cell = [[MyShopRoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopRoomCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.tag = indexPath.row;
        
        cell.dataDic = _roomArr[indexPath.row];
        if (indexPath.row == 0) {
            
            cell.upBtn.hidden = YES;
        }else{
            
            cell.upBtn.hidden = NO;
        }
        
        cell.myShopRoomCellBlock = ^(NSInteger index, NSInteger btn) {
          
            [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_roomArr[index][@"recommend_id"]],@"house_id":[NSString stringWithFormat:@"%@",_roomArr[index][@"house_id"]],@"top_sort":@"1"} success:^(id resposeObject) {

                if ([resposeObject[@"code"] integerValue] == 200) {

                    [self RequestMethod];
                }else{

                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {

                [self showContent:@"网络错误"];
            }];
        };
        return cell;
    }else{
        
        MyShopCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyShopCommentCell"];
        if (!cell) {
            
            cell = [[MyShopCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyShopCommentCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.dataDic = _commentArr[indexPath.row];
        
        cell.myShopCommentCellBlock = ^{
            
            _comment_id = [NSString stringWithFormat:@"%@",_commentArr[indexPath.row][@"comment_id"]];
            [self.editView updatePlaceholder:[NSString stringWithFormat:@"回复%@：",_commentArr[indexPath.row][@"nick_name"]]];
            self.editView.hidden = NO;
            [self.editView show];
        };
        
        cell.myShopCommentCellLabelBlock = ^{
            
            self.editView.delegate = nil;
            [self.editView removeFromSuperview];
            MyShopRecommendDetailVC *nextVC = [[MyShopRecommendDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"house_id"]] info_id:@""];
            nextVC.projectName = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"project_name"]];
            nextVC.config_id = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"config_id"]];
            nextVC.myShopRecommendDetailVCBlock = ^{
                
                [self RequestMethod];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
     
        self.editView.delegate = nil;
        [self.editView removeFromSuperview];
        MyShopRecommendDetailVC *nextVC = [[MyShopRecommendDetailVC alloc] initWithHouseId:[NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"house_id"]] info_id:@""];
        nextVC.projectName = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"project_name"]];
        nextVC.config_id = [NSString stringWithFormat:@"%@",_roomArr[indexPath.row][@"config_id"]];
        nextVC.myShopRecommendDetailVCBlock = ^{
            
            [self RequestMethod];
        };
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.section == 2){
        
        _comment_id = [NSString stringWithFormat:@"%@",_commentArr[indexPath.row][@"comment_id"]];
        [self.editView updatePlaceholder:[NSString stringWithFormat:@"回复%@：",_commentArr[indexPath.row][@"nick_name"]]];
        self.editView.hidden = NO;
        [self.editView show];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的店铺";
    

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.backgroundColor = CLBackColor;
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    [self.view addSubview:_table];
    
    self.editView = [[STCommentEditView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.editView.delegate = self;
    [self.view addSubview:self.editView];
    self.editView.hidden = YES;
}

@end
