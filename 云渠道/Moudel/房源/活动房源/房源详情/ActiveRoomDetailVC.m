//
//  ActiveRoomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "ActiveRoomDetailVC.h"

#import "ActiveRoomDetailHeader.h"
#import "BaseHeader.h"

#import "ActionRoomDetailThreeCell.h"
#import "ActionRoomDetailTwoCell.h"
#import "SingleContentCell.h"

#import "YBImageBrowser.h"

@interface ActiveRoomDetailVC ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDelegate>
{
    
    NSString *_house_id;
    NSString *_info_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_imgArr;
}

@property (nonatomic, strong) UITableView *houseTable;

@property (nonatomic, strong) YBImageBrowser *browser;

@property (nonatomic, strong) UIButton *recommendBtn;

@end

@implementation ActiveRoomDetailVC

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
        _house_id = house_id;
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
    
    _dataDic = [@{} mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetHouseDetail_URL parameters:@{@"house_id":_house_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setValue:@"" forKey:key];
                }
            }];
            [_houseTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1 *SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        ActiveRoomDetailHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ActiveRoomDetailHeader"];
        if (!header) {
            
            header = [[ActiveRoomDetailHeader alloc] initWithReuseIdentifier:@"ActiveRoomDetailHeader"];
        }
        header.imgArr = [NSMutableArray arrayWithArray:_imgArr];
        header.activeRoomDetailHeaderImgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
            
            NSMutableArray *tempArr = [NSMutableArray array];
            
            NSMutableArray *tempArr1 = [NSMutableArray array];
            for (NSDictionary *dic in imgArr) {
                
                for (NSDictionary *subDic in dic[@"list"]) {
                    
                    [tempArr1 addObject:subDic];
                }
            }
            [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                YBImageBrowserModel *model = [YBImageBrowserModel new];
                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
                if ([obj[@"img_url_3d"] length]) {
                    
                    model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
                }
                
                [tempArr addObject:model];
            }];
            
            [_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
                [tempDic setObject:obj[@"type"] forKey:@"name"];
                
                [tempDic setObject:obj[@"list"] forKey:@"data"];
                [_imgArr replaceObjectAtIndex:idx withObject:tempDic];
                
            }];
            
             YBImageBrowserModel *YBmodel = tempArr[num];
            if (YBmodel.third_URL.length) {
                
                BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
                nextVC.weburl = YBmodel.third_URL;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else{
            YBImageBrowser *browser = [YBImageBrowser new];
            browser.delegate = self;
            browser.dataArray = tempArr;
            browser.albumArr = _imgArr;
            browser.infoid = _info_id;
            browser.currentIndex = num;
            [browser show];
            }
        };
        return header;
    }else{
        
        BaseHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseHeader"];
        if (!header) {
            
            header = [[BaseHeader alloc] initWithReuseIdentifier:@"BaseHeader"];
        }
        
        if (section == 1) {
            
            header.titleL.text = @"房号：";
            if ([_dataDic count]) {
                
                header.titleL.text = [NSString stringWithFormat:@"房号：%@",_dataDic[@"house_name"]];
            }
        }else if (section == 2){
            
            header.titleL.text = @"价格：";
            if ([_dataDic count]) {
                
                header.titleL.text = [NSString stringWithFormat:@"价格：%@万",_dataDic[@"total_price"]];
            }
        }else if (section == 3){
            
            header.titleL.text = @"物业：";
            if ([_dataDic count]) {
                
                header.titleL.text = [NSString stringWithFormat:@"物业：%@",_dataDic[@"property_type"]];
            }
        }else{
            
            header.titleL.text = @"房源推荐：";
            
        }
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = CLBackColor;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return nil;
    }else{
        
        if (indexPath.section == 2) {
            
            ActionRoomDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionRoomDetailTwoCell"];
            if (!cell) {
                
                cell = [[ActionRoomDetailTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActionRoomDetailTwoCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.oneL.text = [NSString stringWithFormat:@"计价规则：%@",_dataDic[@""]];
            cell.twoL.text = [NSString stringWithFormat:@"单价：%@元/㎡",_dataDic[@"unit_price"]];
            return cell;
        }else if (indexPath.section == 4){
            
            SingleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleContentCell"];
            if (!cell) {
                
                cell = [[SingleContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SingleContentCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentL.text = @"121231231231123123123123123123";
            return cell;
        }else{
            
            ActionRoomDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionRoomDetailThreeCell"];
            if (!cell) {
                
                cell = [[ActionRoomDetailThreeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ActionRoomDetailThreeCell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.section == 1) {
                
                cell.oneL.text = [NSString stringWithFormat:@"楼栋：%@",_dataDic[@"build_name"]];
                cell.twoL.text = [NSString stringWithFormat:@"单元：%@",_dataDic[@"unit_name"]];
                cell.threeL.text= [NSString stringWithFormat:@"楼层：%@层",_dataDic[@"floor_num"]];
            }else{
                
                cell.oneL.text = [NSString stringWithFormat:@"建筑面积：%@㎡",_dataDic[@"build_size"]];
                cell.twoL.text = [NSString stringWithFormat:@"套内面积：%@㎡",_dataDic[@"indoor_size"]];
                cell.threeL.text= [NSString stringWithFormat:@"公摊面积：%@㎡",_dataDic[@"public_size"]];
            }
            return cell;
        }
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房间详情";
    
    _houseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _houseTable.estimatedRowHeight = 150 *SIZE;
    _houseTable.rowHeight = UITableViewAutomaticDimension;
    _houseTable.backgroundColor = self.view.backgroundColor;
    _houseTable.delegate = self;
    _houseTable.dataSource = self;
    _houseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_houseTable];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"一键保存到我的店铺" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_recommendBtn];
}

@end
