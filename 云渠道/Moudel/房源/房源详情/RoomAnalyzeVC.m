//
//  RoomAnalyzeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomAnalyzeVC.h"
#import "AnalyzeTableCell.h"

@interface RoomAnalyzeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableDictionary *_dataDic;
    NSString *_info_id;

}
@property (nonatomic, strong) UITableView *analyzeTable;

@end

@implementation RoomAnalyzeVC

- (instancetype)initWithinfo_Id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
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
    
    [BaseRequest GET:ProjectBuildInfo_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {
        
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
    
    return 4;
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
            cell.titleL.text = @"项目优势";
            if (_dataDic[@"advantage"]) {
                
                cell.contentL.text = _dataDic[@"advantage"];
            }else{
                
                cell.contentL.text = @"项目很懒，没有优势";
            }
            break;
        }
        case 1:
        {
            cell.titleL.text = @"周边分析";
            if (_dataDic[@"rim"]) {
                
                cell.contentL.text = _dataDic[@"rim"];
            }else{
                
                cell.contentL.text = @"项目很懒，没有分析";
            }
            break;
        }
        case 2:
        {
            cell.titleL.text = @"适合人群";
            if (_dataDic[@"fetch"]) {
                
                cell.contentL.text = _dataDic[@"fetch"];
            }else{
                
                cell.contentL.text = @"项目很懒，没有适合人群";
            }
            break;
        }
        case 3:
        {
            cell.titleL.text = @"升值空间";
            if (_dataDic[@"increase_value"]) {
                
                cell.contentL.text = _dataDic[@"increase_value"];
            }else{
                
                cell.contentL.text = @"项目很懒，没有升值空间";
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
