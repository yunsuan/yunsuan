//
//  RecommendedStatusVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RecommendedStatusVC.h"

#import "UploadImageVC.h"

#import "ReStatusTableCell.h"

#import "CodeView.h"

@interface RecommendedStatusVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
    
    UIImage *_image;
}
@property (nonatomic, strong) UITableView *reStatusTable;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation RecommendedStatusVC

- (instancetype)initWithData:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initDataSource];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReStatusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReStatusTableCell"];
    if (!cell) {
        
        cell = [[ReStatusTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReStatusTableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.dataDic = _dataArr[indexPath.section];

//    cell.titleL.text = _dataArr[indexPath.row][@"project_name"];
    cell.reStatusTableCellVisitBlock = ^{
        
        UploadImageVC *nextVC = [[UploadImageVC alloc] initWithProjectClientId:_dataArr[indexPath.section][@"client_id"] type:@"2"];
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    cell.reStatusTableCellDealBlock = ^{
        
        UploadImageVC *nextVC = [[UploadImageVC alloc] initWithProjectClientId:_dataArr[indexPath.section][@"client_id"] type:@"5"];
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    cell.reStatusTableCellCodeBlock = ^{
      
        CodeView *view = [[CodeView alloc] initWithFrame:self.view.bounds];
        view.customL.text = [NSString stringWithFormat:@"推荐客户：%@",self.custom];
        view.recommendL.text = [NSString stringWithFormat:@"报备人员：%@/%@",[UserInfoModel defaultModel].name,[UserInfoModel defaultModel].tel];
        view.projectL.text = [NSString stringWithFormat:@"推荐项目：%@",_dataArr[indexPath.section][@"project_name"]];
        [view setErWeiMaWithUrl:[self base64EncodeString:[NSString stringWithFormat:@"%@",_dataArr[indexPath.section][@"client_id"]]] AndView:view];
        _image = view.codeImg.image;
        view.codeViewSaveBlock = ^{
            
            UIImageWriteToSavedPhotosAlbum(self->_image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        };
        
        view.codeViewShareBlock = ^{
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        };
        [self.view addSubview:view];
    };
    
    return cell;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error  contextInfo:(void *)contextInfo{
    
    if (error) {
        
        [self showContent:@"保存失败"];
        
    }else{
        
        [self showContent:@"保存成功"];
        
    }
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"已推荐项目状态";
    

    _reStatusTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
    _reStatusTable.rowHeight = UITableViewAutomaticDimension;
    _reStatusTable.estimatedRowHeight = 113 *SIZE;
    _reStatusTable.backgroundColor = self.view.backgroundColor;
    _reStatusTable.delegate = self;
    _reStatusTable.dataSource = self;
    _reStatusTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_reStatusTable];
}

-(void)creatQRCodeWith:(NSString *)urlString
{
//    // 1.实例化二维码滤镜
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
    UMShareImageObject *shareObject;
    shareObject = [UMShareImageObject shareObjectWithTitle:@"云渠道" descr:@"" thumImage:_image];
//    if ([UserInfoModel defaultModel].head_img.length) {
//
//        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]]]]];
//    }else{
//
//        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageNamed:@"shareimg"]];
//    }
    //设置网页地址
    shareObject.shareImage = _image;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
//    if (platformType == UMSocialPlatformType_WechatTimeLine) {
//        shareObject.title = [NSString stringWithFormat:@"【云渠道】%@的名片",[UserInfoModel defaultModel].name];
//    }
    
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
@end
