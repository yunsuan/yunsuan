//
//  SecComRoomAnalyzeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecComRoomAnalyzeVC.h"
#import "AnalyzeTableCell.h"

@interface SecComRoomAnalyzeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableDictionary *_dataDic;
    NSString *_projectId;
    NSInteger _type;
}
@property (nonatomic, strong) UITableView *analyzeTable;

@end

@implementation SecComRoomAnalyzeVC

- (instancetype)initWithHouseId:(NSString *)houseId type:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _projectId = houseId;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataDic = [@{} mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:HouseHouseGetHouseAnalyse_URL parameters:@{@"house_id":_projectId,@"type":@(_type)} success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {

            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {

                _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            }else{


            }
        }else if([resposeObject[@"code"] integerValue] == 400){

        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
        [_analyzeTable reloadData];
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 40*SIZE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 39 *SIZE)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    view1.backgroundColor = YJBlueBtnColor;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 13 *SIZE, 100 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"项目分析";
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 7 *SIZE;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AnalyzeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnalyzeTableCell"];
    if (!cell) {
        
        cell = [[AnalyzeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnalyzeTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.titleL.text = @"核心卖点";
            if ([_dataDic[@"core_selling"] length]) {
                
                cell.contentL.text = _dataDic[@"core_selling"];
            }else{
                
                cell.contentL.text = @"暂无核心卖点信息";
            }
            break;
        }
        case 1:
        {
            cell.titleL.text = @"装修描述";
            if ([_dataDic[@"decoration_standard"] length]) {
                
                cell.contentL.text = _dataDic[@"decoration_standard"];
            }else{
                
                cell.contentL.text = @"暂无装修描述信息";
            }
            break;
        }
        case 2:
        {
            cell.titleL.text = @"户型介绍";
            if ([_dataDic[@"sell_point"] length]) {
                
                cell.contentL.text = _dataDic[@"sell_point"];
            }else{
                
                cell.contentL.text = @"暂无户型介绍信息";
            }
            break;
        }
        case 3:
        {
            cell.titleL.text = @"其他费项";
            if ([_dataDic[@"increase_value"] length]) {
                
                cell.contentL.text = _dataDic[@"increase_value"];
            }else{
                
                cell.contentL.text = @"暂无其他费项信息";
            }
            break;
        }
        case 4:
        {
            cell.titleL.text = @"项目优势";
            if ([_dataDic[@"advantage"] length]) {
                
                cell.contentL.text = _dataDic[@"advantage"];
            }else{
                
                cell.contentL.text = @"暂无项目优势信息";
            }
            break;
        }
        case 5:
        {
            cell.titleL.text = @"周边分析";
            if ([_dataDic[@"rim"] length]) {
                
                cell.contentL.text = _dataDic[@"rim"];
            }else{
                
                cell.contentL.text = @"暂无周边分析信息";
            }
            break;
        }
        case 6:
        {
            cell.titleL.text = @"适合人群";
            if ([_dataDic[@"fetch"] length]) {
                
                cell.contentL.text = _dataDic[@"fetch"];
            }else{
                
                cell.contentL.text = @"暂无适合人群信息";
            }
            break;
        }
        case 7:
        {
            cell.titleL.text = @"升值空间";
            if ([_dataDic[@"increase_value"] length]) {
                
                cell.contentL.text = _dataDic[@"increase_value"];
            }else{
                
                cell.contentL.text = @"暂无升值空间信息";
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)initUI{
    
    _analyzeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _analyzeTable.rowHeight = UITableViewAutomaticDimension;
    _analyzeTable.estimatedRowHeight = 214 *SIZE;
    _analyzeTable.backgroundColor = YJBackColor;;
    _analyzeTable.delegate = self;
    _analyzeTable.dataSource = self;
    _analyzeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_analyzeTable];
}

@end
