//
//  MyCodeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MyCodeVC.h"

@interface MyCodeVC ()
{
    
    NSString *_url;
}
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UIImageView *tagImg;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *codeImg;

@property (nonatomic , strong) UILabel *YSlable;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) TransmitView *transmitView;

@end

@implementation MyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self post];
}


-(void)post
{
    [BaseRequest GET:QRCode_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue]==200) {
            [self creatQRCodeWith:resposeObject[@"data"][@"url"]];
        }
        else{
            [self creatQRCodeWith:@"http://wwww.ccsoft.com.cn"];
        }
    } failure:^(NSError *error) {
        [self creatQRCodeWith:@"http://wwww.ccsoft.com.cn"];
    }];
    
}

- (void)ActionRightBtn:(UIButton *)btn{
    
    [BaseRequest GET:@"user/project/shareAgent" parameters:@{@"agent_id":[UserModel defaultModel].agent_id} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _url = resposeObject[@"data"][@"url"];
            [[UIApplication sharedApplication].keyWindow addSubview:self.transmitView];
        }else{
            
            [self showContent:@"分享失败"];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"分享失败"];
        NSLog(@"%@",error);
    }];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"我的二维码";
    self.rightBtn.hidden = NO;
    [self.rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.rightBtn setTitleColor:YJTitleLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = COLOR(67, 67, 67, 1);
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(46 *SIZE, 100 *SIZE + NAVIGATION_BAR_HEIGHT, 267 *SIZE, 350 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_whiteView];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(100 *SIZE, 24 *SIZE, 67 *SIZE, 67 *SIZE)];
    _headImg.backgroundColor = [UIColor greenColor];
    _headImg.layer.cornerRadius = 33.5 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            _headImg.image = [UIImage imageNamed:@"def_head"];
        }
    }];
    [_whiteView addSubview:_headImg];
    
    
    _tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(90 *SIZE, 101 *SIZE, 88 *SIZE, 34 *SIZE)];
    _tagImg.image = [UIImage imageNamed:@"label"];
    [_whiteView addSubview:_tagImg];
    
    _genderImg = [[UIImageView alloc] initWithFrame:CGRectMake(19 *SIZE, 11 *SIZE, 12 *SIZE, 12 *SIZE)];
    //    _genderImg.image = [UIImage imageNamed:@"man"];
    if ([[UserInfoModel defaultModel].sex integerValue] == 1) {
        
        _genderImg.image = [UIImage imageNamed:@"man_2"];
    }else if ([[UserInfoModel defaultModel].sex integerValue] == 2){
        
        _genderImg.image = [UIImage imageNamed:@"girl_2"];
    }else{
        
        _genderImg.image = nil;
    }
    [_tagImg addSubview:_genderImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(36 *SIZE, 11 *SIZE, 50 *SIZE, 14 *SIZE)];
    _nameL.textColor = [UIColor whiteColor];
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    if ([UserInfoModel defaultModel].name) {
        
        _nameL.text = [UserInfoModel defaultModel].name;
    }else{
        
        _nameL.text = [UserInfoModel defaultModel].account;
    }
    [_tagImg addSubview:_nameL];
    
    _YSlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 145*SIZE, 267 *SIZE, 15*SIZE)];
    _YSlable.font = [UIFont systemFontOfSize:12*SIZE];
    _YSlable.text = [NSString stringWithFormat:@"云算号：%@",[UserModelArchiver InfoUnarchive].account];
    _YSlable.textColor =YJContentLabColor;
    _YSlable.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:_YSlable];
    _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(50 *SIZE, 168 *SIZE, 167 *SIZE, 167 *SIZE)];
    //    _codeImg.backgroundColor = [UIColor blackColor];
    
    [_whiteView addSubview:_codeImg];
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
    UMShareWebpageObject *shareObject;
    if ([UserInfoModel defaultModel].head_img.length) {
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]]]]];
    }else{
        
        shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云渠道" descr:[NSString stringWithFormat:@"%@的名片",[UserInfoModel defaultModel].name] thumImage:[UIImage imageNamed:@"shareimg"]];
    }
    //设置网页地址
    shareObject.webpageUrl = _url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (platformType == UMSocialPlatformType_WechatTimeLine) {
        shareObject.title = [NSString stringWithFormat:@"【云渠道】%@的名片",[UserInfoModel defaultModel].name];
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
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5.生成二维码
    CIImage *outputImage = filter.outputImage;
    CGFloat scale = _codeImg.frame.size.width/ CGRectGetWidth(outputImage.extent);
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale); // scale 为放大倍数
    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
    
    // 保存
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];
    UIImage *qrCodeImage = [UIImage imageWithCGImage:imageRef];
    
    // 6.设置生成好得二维码到imageView上
    _codeImg.image  = qrCodeImage;
    
}


@end
