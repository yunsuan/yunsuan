//
//  MyTeamVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyTeamVC.h"

#import "MyTeamTableHeader.h"
#import "MyTeamTableHeader2.h"
#import "MyTeamTableCell.h"
#import "MyTeamTableCell2.h"

#import "TeamInfoView.h"

@interface MyTeamVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    NSMutableDictionary *_person;
    NSMutableDictionary *_parent;
    NSMutableDictionary *_recommend;
    
    NSString *_url;
}
@property (nonatomic, strong) TeamInfoView *teamInfoView;

@property (nonatomic, strong) UITableView *mainTable;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation MyTeamVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _parent = [@{} mutableCopy];
    _person = [@{} mutableCopy];
    _recommend = [@{} mutableCopy];
    _dataArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:PersonalMyTeamList_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self SetData:resposeObject[@"data"]];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    if ([data[@"person"] isKindOfClass:[NSDictionary class]]) {
        
        _person = [NSMutableDictionary dictionaryWithDictionary:data[@"person"]];
        [_person enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_person setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"parent"] isKindOfClass:[NSDictionary class]]) {
        
        _parent = [NSMutableDictionary dictionaryWithDictionary:data[@"parent"]];
        [_parent enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_parent setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"recommend"] isKindOfClass:[NSDictionary class]]) {
        
        _recommend = [NSMutableDictionary dictionaryWithDictionary:data[@"recommend"]];
        [_recommend enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSNull class]]) {
                
                [_recommend setObject:@"" forKey:key];
            }
        }];
    }
    
    if ([data[@"child"] isKindOfClass:[NSArray class]]) {
        
        _dataArr = [NSMutableArray arrayWithArray:data[@"child"]];
        for (int i = 0; i < _dataArr.count; i++) {
            
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i]];
            [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [tempDic setObject:@"" forKey:key];
                }
            }];
            [_dataArr replaceObjectAtIndex:i withObject:tempDic];
        }
    }
    
    [_mainTable reloadData];
}


#pragma mark -- Method --

- (void)ActionRightBtn:(UIButton *)btn{
    
    [BaseRequest GET:PersonalJoinAgentTeam_URL parameters:nil success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _url = resposeObject[@"data"];
            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        }else{
            
            [self showContent:@"分享失败"];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"分享失败"];
        NSLog(@"%@",error);
    }];
}


#pragma mark -- Table --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_dataArr.count && _parent.count) {
        
        return 3;
    }else if(!_dataArr.count && !_parent.count){
        
        return 1;
    }else{
        
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }else if (section == 1){
        
        if (_parent.count) {
            
            return 1;
        }else{
            
            return _dataArr.count;
        }
    }else{
        
        return _dataArr.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MyTeamTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader"];
        if (!header) {
            
            header = [[MyTeamTableHeader alloc] initWithReuseIdentifier:@"MyTeamTableHeader"];
        }
        
//        header.headImg.image = [UIImage imageNamed:@"def_head"];
        if (_person.count) {
            
            header.nameL.text = _person[@"name"];
            header.levelL.text = [NSString stringWithFormat:@"等级：%@",_person[@"grade"]];
            [header.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,_person[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    header.headImg.image = [UIImage imageNamed:@"def_head"];
                }
            }];
            header.genderImg.image = [_person[@"sex"] integerValue] == 2? [UIImage imageNamed:@"girl"]:[UIImage imageNamed:@"man"];
            header.recommendL.text = [NSString stringWithFormat:@"今日推荐：%@人",_recommend[@"today"]];
            header.allL.text = [NSString stringWithFormat:@"所有成员：%@人",_recommend[@"total"]];
        }else{
            
            header.nameL.text = @"";
            header.levelL.text = [NSString stringWithFormat:@"等级：新秀"];
            header.headImg.image = [UIImage imageNamed:@"def_head"];
            header.genderImg.image = [_person[@"sex"] integerValue] == 2? [UIImage imageNamed:@"girl"]:[UIImage imageNamed:@"man"];
            header.recommendL.text = [NSString stringWithFormat:@"今日推荐：0人"];
            header.allL.text = [NSString stringWithFormat:@"所有成员：0人"];
        }
        
        
        return header;
    }else{
        
        MyTeamTableHeader2 *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MyTeamTableHeader2"];
        if (!header) {
            
            header = [[MyTeamTableHeader2 alloc] initWithReuseIdentifier:@"MyTeamTableHeader2"];
        }
        if (section == 1) {
            
            if (_parent.count) {
                
                header.titleL.text = @"我的推荐人";
            }else{
                
                header.titleL.text = @"我的团队";
            }
        }else{
            
            header.titleL.text = @"我的团队";
        }
        
        return header;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (_parent.count) {
            
            MyTeamTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell"];
            if (!cell) {
                
                cell = [[MyTeamTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,_parent[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.headImg.image = [UIImage imageNamed:@"def_head"];
                }
            }];
            
            cell.nameL.text = _parent[@"name"];
            [cell.nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.headImg.mas_right).offset(11 *SIZE);
                make.top.equalTo(cell.backView).offset(16 *SIZE);
                make.width.mas_equalTo(cell.nameL.mj_textWith + 5 *SIZE);
            }];
            cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_parent[@"grade"]];
            cell.timeL.text = _parent[@"create_time"];
           
            if ([_parent[@"sex"] integerValue] == 2){
                
                cell.genderImg.image = [UIImage imageNamed:@"girl"];
            }else{
                
                cell.genderImg.image = [UIImage imageNamed:@"man"];
            }
            
            return cell;
        }else{
            
            MyTeamTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell2"];
            if (!cell) {
                
                cell = [[MyTeamTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,_dataArr[indexPath.row][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.headImg.image = [UIImage imageNamed:@"def_head"];
                }
            }];
            
            cell.nameL.text = _dataArr[indexPath.row][@"name"];
            [cell.nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(cell.headImg.mas_right).offset(11 *SIZE);
                make.top.equalTo(cell.contentView).offset(16 *SIZE);
                make.width.mas_equalTo(cell.nameL.mj_textWith + 5 *SIZE);
            }];
            cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_dataArr[indexPath.row][@"grade"]];
            cell.timeL.text = _dataArr[indexPath.row][@"create_time"];
            
            if ([_dataArr[indexPath.row][@"sex"] integerValue] == 2){
                
                cell.genderImg.image = [UIImage imageNamed:@"girl"];
            }else{
                
                cell.genderImg.image = [UIImage imageNamed:@"man"];
            }
            cell.commissionL.text = [NSString stringWithFormat:@"奖励金：%@",_dataArr[indexPath.row][@"produce_grade"]];
            return cell;

        }
    }else{
        
        MyTeamTableCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTeamTableCell2"];
        if (!cell) {
            
            cell = [[MyTeamTableCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTeamTableCell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,_dataArr[indexPath.row][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                cell.headImg.image = [UIImage imageNamed:@"def_head"];
            }
        }];
        
        cell.nameL.text = _dataArr[indexPath.row][@"name"];
        [cell.nameL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.headImg.mas_right).offset(11 *SIZE);
            make.top.equalTo(cell.contentView).offset(16 *SIZE);
            make.width.mas_equalTo(cell.nameL.mj_textWith + 5 *SIZE);
        }];
        cell.levelL.text = [NSString stringWithFormat:@"等级：%@",_dataArr[indexPath.row][@"grade"]];
        cell.timeL.text = _dataArr[indexPath.row][@"create_time"];
        if ([_dataArr[indexPath.row][@"sex"] integerValue] == 1) {
            
            cell.genderImg.image = [UIImage imageNamed:@"man"];
        }else if ([_dataArr[indexPath.row][@"sex"] integerValue] == 2){
            
            cell.genderImg.image = [UIImage imageNamed:@"girl"];
        }else{
            
            cell.genderImg.image = [UIImage imageNamed:@""];
        }
        cell.commissionL.text = [NSString stringWithFormat:@"奖励金：%@",_dataArr[indexPath.row][@"produce_grade"]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (_parent.count) {
            
            _teamInfoView = [[TeamInfoView alloc] initWithFrame:self.view.bounds];
            [_teamInfoView.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,_parent[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    _teamInfoView.headImg.image = [UIImage imageNamed:@"def_head"];
                }
            }];
            
            _teamInfoView.nameL.text = _parent[@"name"];
            _teamInfoView.genderImg.image = [_parent[@"sex"] integerValue] == 2? [UIImage imageNamed:@"girl_2"]:[UIImage imageNamed:@"man_2"];
            _teamInfoView.YSlable.text = [NSString stringWithFormat:@"云算号:%@",_parent[@"account"]];
            _teamInfoView.companyL.text = [NSString stringWithFormat:@"任职公司:%@",_parent[@"company_name"]];
            _teamInfoView.phoneL.text = [NSString stringWithFormat:@"电话号码:%@",_parent[@"tel"]];
            _teamInfoView.yearL.text = [NSString stringWithFormat:@"入职年限:%@",_parent[@"work_year"]];
            [self.view addSubview:_teamInfoView];
        }else{
            
            NSDictionary *dic = _dataArr[indexPath.row];
            _teamInfoView = [[TeamInfoView alloc] initWithFrame:self.view.bounds];
            [_teamInfoView.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,dic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    _teamInfoView.headImg.image = [UIImage imageNamed:@"def_head"];
                }
            }];
            
            _teamInfoView.nameL.text = dic[@"name"];
            _teamInfoView.genderImg.image = [dic[@"sex"] integerValue] == 2? [UIImage imageNamed:@"girl_2"]:[UIImage imageNamed:@"man_2"];
            _teamInfoView.YSlable.text = [NSString stringWithFormat:@"运算编号:%@",dic[@"account"]];
            _teamInfoView.companyL.text = [NSString stringWithFormat:@"任职公司:%@",dic[@"company_name"]];
            _teamInfoView.phoneL.text = [NSString stringWithFormat:@"电话号码:%@",dic[@"tel"]];
            _teamInfoView.yearL.text = [NSString stringWithFormat:@"入职年限:%@",dic[@"work_year"]];
            [self.view addSubview:_teamInfoView];
        }
    }else{
        
        NSDictionary *dic = _dataArr[indexPath.row];
        _teamInfoView = [[TeamInfoView alloc] initWithFrame:self.view.bounds];
        [_teamInfoView.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",TestBase_Net,dic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (error) {
                
                _teamInfoView.headImg.image = [UIImage imageNamed:@"def_head"];
            }
        }];
        
        _teamInfoView.nameL.text = dic[@"name"];
        _teamInfoView.genderImg.image = [dic[@"sex"] integerValue] == 2? [UIImage imageNamed:@"girl_2"]:[UIImage imageNamed:@"man_2"];
        _teamInfoView.YSlable.text = [NSString stringWithFormat:@"运算编号:%@",dic[@"account"]];
        _teamInfoView.companyL.text = [NSString stringWithFormat:@"任职公司:%@",dic[@"company_name"]];
        _teamInfoView.phoneL.text = [NSString stringWithFormat:@"电话号码:%@",dic[@"tel"]];
        _teamInfoView.yearL.text = [NSString stringWithFormat:@"入职年限:%@",dic[@"work_year"]];
        [self.view addSubview:_teamInfoView];
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的团队";
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _mainTable.rowHeight = UITableViewAutomaticDimension;
    _mainTable.estimatedRowHeight = 67 *SIZE;
    _mainTable.estimatedSectionHeaderHeight = 100 *SIZE;
    _mainTable.backgroundColor = self.view.backgroundColor;
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTable];
}

- (TransmitView *)transmitView{
    
    if (!_transmitView) {
        
        _transmitView = [[TransmitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        WS(weakSelf);
        _transmitView.transmitTagBtnBlock = ^(NSInteger index) {
            
            if (index == 0) {
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_QQ];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 1){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装手机QQ"];
                }
            }else if (index == 2){
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }else{
                
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    
                    [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                }else{
                    
                    [weakSelf alertControllerWithNsstring:@"温馨提示" And:@"请先安装微信"];
                }
            }
        };
    }
    return _transmitView;
}

//
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //    //创建网页内容对象
    //    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_nameL.text descr:@"" thumImage:[NSString stringWithFormat:@"%@%@",Base_Net,[UserInfoModel defaultModel].head_img]];
    //    //设置网页地址
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"%@邀请你加入他的团队",[UserInfoModel defaultModel].name] descr:@"加入云渠道，享受便捷佣金赚取之道" thumImage:[UIImage imageNamed:@"shareimg"]];
    //设置网页地址
    shareObject.webpageUrl = _url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (platformType == UMSocialPlatformType_WechatTimeLine) {
        shareObject.title = [NSString stringWithFormat:@"【%@邀请你加入他的团队】加入云渠道，享受便捷佣金赚取之道",[UserInfoModel defaultModel].name];
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            [self alertControllerWithNsstring:@"分享失败" And:nil];
        }else{
            NSLog(@"response data is %@",data);
            [self showContent:@"分享成功"];
            [self.transmitView removeFromSuperview];
        }
    }];
}

-(void)creatQRCodeWith:(NSString *)urlString
{
    // 1.实例化二维码滤镜
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//
//    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
//    [filter setDefaults];
//
//    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
//
//    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
//    [filter setValue:data forKey:@"inputMessage"];
//
//    // 5.生成二维码
//    CIImage *outputImage = filter.outputImage;
//    CGFloat scale = _codeImg.frame.size.width/ CGRectGetWidth(outputImage.extent);
//    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale); // scale 为放大倍数
//    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
//
//    // 保存
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];
//    UIImage *qrCodeImage = [UIImage imageWithCGImage:imageRef];
//
//    // 6.设置生成好得二维码到imageView上
//    _codeImg.image  = qrCodeImage;
    
}


@end
