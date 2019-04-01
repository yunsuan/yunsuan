//
//  MineVC.m
//  云渠道
//
//  Created by xiaoq on 2018/3/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MineVC.h"

#import "PersonalVC.h"
#import "AuditStatusVC.h"
#import "AuthenedVC.h"
#import "AuthenticationVC.h"
#import "StoreAuthVC.h"
#import "StoreAuthStatusVC.h"
#import "StoreAuthedVC.h"
#import "MyBrokerageVC.h"
#import "MyAttentionVC.h"
#import "FeedbackVC.h"
#import "ExperienceVC.h"
#import "WebViewVC.h"
#import "MySubscripVC.h"
#import "MyTeamVC.h"
#import "CloudCodeVC.h"
//#import <StoreKit/StoreKit.h>

#import "MineCell.h"


@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController; /**< 相册拾取器 */
    NSArray *_namelist;
    NSArray *_imageList;
    NSArray *_contentList;
    
}
@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *codeImg;

@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic , strong) UITableView *Mytableview;
@end

@implementation MineVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self InitDataSouce];
    [self InitUI];
    [self RequestMethod];
    [self LoadRequest];
}

- (void)LoadRequest{
    
    if (![UserModel defaultModel].comment) {
        [UserModel defaultModel].comment = 0;
        [UserModelArchiver archive];
    }
    else{
        [UserModel defaultModel].comment += 1;
        [UserModelArchiver archive];
        if ([UserModel defaultModel].comment%50==0) {
            if (@available(iOS 10.3, *)) {
                [SKStoreReviewController requestReview];
            }
            else{
                [self alertControllerWithNsstring:@"温馨提示" And:@"是否去APPStore进行评分？" WithCancelBlack:^{
                    
                } WithDefaultBlack:^{
                    NSString *str = @"itms-apps://itunes.apple.com/app/id1371978352?mt=8";
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
                    
                }];
            }
            
        }
    }
}

-(void)InitUI{
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, STATUS_BAR_HEIGHT+114*SIZE)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(14 *SIZE, STATUS_BAR_HEIGHT+24 *SIZE, 60 *SIZE, 60 *SIZE)];
    _headImg.layer.masksToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = 30 *SIZE;
    if ([UserInfoModel defaultModel].head_img) {
        
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image = [UIImage imageNamed:@"def_head"];
            }
        }];
    }else{
        
        _headImg.image = [UIImage imageNamed:@"def_head"];
    }
    [self.view addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(91 *SIZE, STATUS_BAR_HEIGHT+48.7 *SIZE, 160 *SIZE, 12 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];

    if ([UserInfoModel defaultModel].name) {
        
        _nameL.text = [UserInfoModel defaultModel].name;
    }else{
        
        _nameL.text = [UserInfoModel defaultModel].account;
    }
    [self.view addSubview:_nameL];

    
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.frame = CGRectMake(9 *SIZE, STATUS_BAR_HEIGHT+19 *SIZE, 70 *SIZE, 70*SIZE);
    [_codeBtn addTarget:self action:@selector(ActionCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeBtn];
    
    [self.view addSubview:self.Mytableview];
}

-(void)InitDataSouce
{
    _namelist = @[@[@"个人资料",@"公司认证",@"门店认证",@"工作经历"],@[@"我的佣金",@"我的关注"/*,@"云算号"*/,@"我的订阅",@"我的团队"],@[@"意见反馈",@"关于云算",@"操作指南"]];
    _imageList = @[@[@"personaldata",@"certification",@"stores",@"work"],@[@"commission",@"focus"/*,@"focus"*/,@"subs",@"team"],@[@"opinion",@"about",@"operation"]];
    _contentList= @[@[@"",@"",@"",@""],@[@"",@"",@"",@"",@""],@[@" ",YQDversion,@""]];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;

}

- (void)RequestMethod{
    
    [BaseRequest POST:GetPersonalBaseInfo_URL parameters:nil success:^(id resposeObject) {
        
        [self.Mytableview.mj_header endRefreshing];
//        NSLog(@"%@",resposeObject);

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
                [self showContent:@"暂时没有用户资料"];
            }
            [self.Mytableview reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self.Mytableview.mj_header endRefreshing];
        [self showContent:@"网络错误"];
//        NSLog(@"%@",error);
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    [UserInfoModel defaultModel].absolute_address = tempDic[@"absolute_address"];
    [UserInfoModel defaultModel].account = tempDic[@"account"];
    [UserInfoModel defaultModel].birth = tempDic[@"birth"];
    [UserInfoModel defaultModel].city = tempDic[@"city"];
    [UserInfoModel defaultModel].district = tempDic[@"district"];
    [UserInfoModel defaultModel].head_img = tempDic[@"head_img"];
    [UserInfoModel defaultModel].name = tempDic[@"name"];
    [UserInfoModel defaultModel].province = tempDic[@"province"];
    [UserInfoModel defaultModel].sex = [NSString stringWithFormat:@"%@",tempDic[@"sex"]];
    [UserInfoModel defaultModel].tel = tempDic[@"tel"];
    [UserInfoModel defaultModel].is_accept_msg = [NSString stringWithFormat:@"%@",tempDic[@"is_accept_msg"]];
    [UserInfoModel defaultModel].is_accept_grab = [NSString stringWithFormat:@"%@",tempDic[@"is_accept_grab"]];
    [UserModelArchiver infoArchive];
    
    if ([UserInfoModel defaultModel].head_img.length>0) {
        
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,[UserInfoModel defaultModel].head_img]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image = [UIImage imageNamed:@"def_head"];
            }
        }];
    }else{
        _headImg.image = [UIImage imageNamed:@"def_head"];

    }
    
    if ([UserInfoModel defaultModel].name) {
        
        _nameL.text = [UserInfoModel defaultModel].name;
    }else{
        
        _nameL.text = [UserInfoModel defaultModel].account;
    }
}

- (void)ActionCodeBtn:(UIButton *)btn{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传头像"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    // 相册选择
    [alertController addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectPhotoAlbumPhotos];
    }]];
    // 拍照
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self takingPictures];
    }]];
    // 取消
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    // 推送
    [self presentViewController:alertController animated:YES completion:^{
    }];
}

#pragma mark -- 选择头像

- (void)selectPhotoAlbumPhotos {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        _imagePickerController.allowsEditing = YES; // 如果设置为NO，当用户选择了图片之后不会进入图像编辑界面。
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

// 拍照
- (void)takingPictures {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        // 设置相机模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置摄像头：前置/后置
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置闪光模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    } else {
//        NSLog(@"当前设备不支持拍照");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //                                                              _uploadButton.hidden = NO;
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@",info);
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
            [self updateheadimgbyimg:originalImage];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerEditedImage]];
        [self updateheadimgbyimg:originalImage];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateheadimgbyimg:(UIImage *)img
{
    NSData *data = [self resetSizeOfImageData:img maxSize:150];
    
    [BaseRequest Updateimg:UploadFile_URL parameters:@{
                                                @"file_name":@"headimg"
                                                    }
          constructionBody:^(id<AFMultipartFormData> formData) {
              [formData appendPartWithFileData:data name:@"headimg" fileName:@"headimg.jpg" mimeType:@"image/jpg"];
    } success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            NSDictionary *dic = @{@"head_img":resposeObject[@"data"]};
            [BaseRequest POST:UpdatePersonal_URL parameters:dic success:^(id resposeObject) {
                
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    _headImg.image = img;
                    [UserInfoModel defaultModel].head_img = dic[@"head_img"];
                    [UserModelArchiver infoArchive];
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
               
//                NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
        
    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  ---  delegate  ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
        return 2;
    else
        return 4;//[_imageList[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43.3*SIZE;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (!section) {
        
        return 2 *SIZE;
    }
    return 7 *SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 10*SIZE)];
    view.backgroundColor = YJBackColor;
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MineCell";
    
    MineCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell SetTitle:_namelist[indexPath.section][indexPath.row] icon:_imageList[indexPath.section][indexPath.row] contentlab:_contentList[indexPath.section][indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            
            PersonalVC *nextVC = [[PersonalVC alloc] init];
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else if (indexPath.row == 1) {
            
            [BaseRequest GET:GetAuthInfo_URL parameters:nil success:^(id resposeObject) {
                
//                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                        
                        NSDictionary *dic = resposeObject[@"data"];
                        if ([dic[@"state"] isEqualToString:@"认证中"]) {
                            
                            AuditStatusVC *nextVC = [[AuditStatusVC alloc] initWithData:dic];
                            nextVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else if([dic[@"state"] isEqualToString:@"认证不通过"]){
                            
                            AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
                            nextVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }else{
                            
                            AuthenedVC *nextVC = [[AuthenedVC alloc] initWithData:dic];
                            nextVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }
                    }else{
                        
                        AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
                        nextVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }else{
                    
                    AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            } failure:^(NSError *error) {
                
                AuthenticationVC *nextVC = [[AuthenticationVC alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
//                NSLog(@"%@",error);
            }];
            
        }else if(indexPath.row == 2){
            
            [BaseRequest GET:StoreAuthState_URL parameters:nil success:^(id resposeObject) {
                
                //                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                        
                        if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                            
                            NSDictionary *dic = resposeObject[@"data"];
                            if ([dic[@"state"] isEqualToString:@"审核中"]) {
                                
                                StoreAuthStatusVC *nextVC = [[StoreAuthStatusVC alloc] initWithData:dic];
                                nextVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:nextVC animated:YES];
                            }else if([dic[@"state"] isEqualToString:@"审核通过"]){
                                
                                StoreAuthedVC *nextVC = [[StoreAuthedVC alloc] initWithData:dic];
                                nextVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:nextVC animated:YES];
                            }else{
                                
                                StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
                                nextVC.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:nextVC animated:YES];
                            }
                        }else{
                            
                            StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
                            nextVC.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:nextVC animated:YES];
                        }
                    }else{
                        
                        StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
                        nextVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                }else{
                    
                    StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
                    nextVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:nextVC animated:YES];
                }
            } failure:^(NSError *error) {
                
                StoreAuthVC *nextVC = [[StoreAuthVC alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            }];
        }else{
            
            ExperienceVC *nextVC = [[ExperienceVC alloc] init];
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }
    else if (indexPath.section ==1)
    {
        
        if (indexPath.row == 0) {
            
            MyBrokerageVC *nextVC = [[MyBrokerageVC alloc] init];
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            if (indexPath.row == 1) {
                
                MyAttentionVC *nextVC = [[MyAttentionVC alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else if (indexPath.row == 2){
                
//                CloudCodeVC *nextVC = [[CloudCodeVC alloc] init];
//                [self.navigationController pushViewController:nextVC animated:YES];
//            }else if(indexPath.row ==3)
//            {
                
                MySubscripVC *nextVC = [[MySubscripVC alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            }else
            {
                MyTeamVC *nextVC = [[MyTeamVC alloc] init];
                nextVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }else
    {
        if (indexPath.row == 0) {
            
            FeedbackVC *nextVC = [[FeedbackVC alloc] init];
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        else if(indexPath.row ==1)
        {
            
        }else{
            
            WebViewVC *next_vc = [[WebViewVC alloc]init];
            [self.navigationController pushViewController:next_vc animated:YES];
        }
        
    }
}

#pragma mark  ---  懒加载   ---

-(UITableView *)Mytableview
{
    if(!_Mytableview)
    {
        _Mytableview =   [[UITableView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+115*SIZE, 360*SIZE, SCREEN_Height-STATUS_BAR_HEIGHT-115*SIZE) style:UITableViewStylePlain];
        _Mytableview.backgroundColor = YJBackColor;
        _Mytableview.delegate = self;
        _Mytableview.dataSource = self;
        [_Mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _Mytableview.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
           
            [self RequestMethod];
        }];
    }
    return _Mytableview;
}


@end
