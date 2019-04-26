//
//  AuthenticationVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "AuthenticationVC.h"
#import "AuthenTableCell.h"
#import "AuthenCollCell.h"
#import "SelectCompanyVC.h"
#import "AuditStatusVC.h"
#import "ApplyProjectVC.h"
#import "DateChooseView.h"
#import "MineVC.h"

@interface AuthenticationVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    NSArray *_titleArr;
    NSMutableArray *_contentArr;
    //    NSMutableArray *_imgArr;
    //    NSString *_imgUrl;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSInteger _index;
    NSString *_companyId;
    NSString *_workCode;
    NSString *_role;
    NSString *_projectId;
    NSString *_department;
    NSString *_position;
    NSString *_entryTime;
    NSString *_imgUrl;
}
@property (nonatomic, strong) UIView *collView;

@property (nonatomic, strong) UICollectionView *authenColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UILabel *numTL;

@property (nonatomic, strong) UIView *numLine;

@property (nonatomic, strong) UITextField *numTextField;

@property (nonatomic, strong) UILabel *companyTL;

@property (nonatomic, strong) UIView *compantLine;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UIButton *companyBtn;

@property (nonatomic, strong) UILabel *roleTL;

@property (nonatomic, strong) UIView *roleLine;

@property (nonatomic, strong) UILabel *roleL;

@property (nonatomic, strong) UIButton *roleBtn;

@property (nonatomic, strong) UILabel *projectTL;

@property (nonatomic, strong) UIView *projectLine;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UIButton *projectBtn;

@property (nonatomic, strong) UILabel *departTL;

@property (nonatomic, strong) UIView *departLine;

@property (nonatomic, strong) UITextField *departTextField;

@property (nonatomic, strong) UILabel *positionTL;

@property (nonatomic, strong) UIView *positionLine;

@property (nonatomic, strong) UITextField *positionTextField;

@property (nonatomic, strong) UILabel *timeTL;

@property (nonatomic, strong) UIView *timeLine;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *timeBtn;

@property (nonatomic, strong) DateChooseView *dateView;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation AuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    _contentArr = [[NSMutableArray alloc] init];
    _titleArr = @[@"所属公司",@"工号",@"角色",@"申请项目",@"所属部门",@"职位",@"入职/申请时间"];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}



- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self.authenColl reloadData];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (!_companyId) {
        
        [self showContent:@"请选择公司"];
        return;
    }
    
    if (!_numTextField.text) {
        
        [self showContent:@"请输入工号"];
        return;
    }
    
    //    if (!_role) {
    //
    //        [self showContent:@"请选择角色"];
    //        return;
    //    }
    
    if ([_roleL.text isEqualToString:@"到访确认人"] || [_roleL.text isEqualToString:@"确认单签字人"]) {
        
        if ([_projectId isEqual:@""]) {
            
            [self showContent:@"请选择申请项目"];
            return;
        }
    }
    
    if (!_departTextField.text) {
        
        [self showContent:@"请输入所属部门"];
        return;
    }
    
    if (!_positionTextField.text) {
        
        [self showContent:@"请输入职位"];
        return;
    }
    
    //    if (!_timeL.text) {
    //
    //        [self showContent:@"请选择入职时间"];
    //        return;
    //    }
    //
    //    if (!_imgUrl) {
    //
    //        [self showContent:@"请选择工牌照片"];
    //        return;
    //    }
    
    [dic setObject:_companyId forKey:@"company_id"];
    [dic setObject:_role forKey:@"role"];
    [dic setObject:_numTextField.text forKey:@"work_code"];
    if ([_roleL.text isEqualToString:@"到访确认人"] || [_roleL.text isEqualToString:@"确认单签字人"]) {
        
        [dic setObject:_projectId forKey:@"project_id"];
    }
    [dic setObject:_departTextField.text forKey:@"department"];
    [dic setObject:_positionTextField.text forKey:@"position"];
    if (_timeL.text.length == 0) {
        
//        [dic setObject:@"" forKey:@"entry_time"];
    }
    else
    {
        [dic setObject:_timeL.text forKey:@"entry_time"];
    }
    if (_imgUrl.length==0) {
        
    }
    else{
        [dic setObject:_imgUrl forKey:@"img_url"];
    }
    
    if ([self.status isEqualToString:@"重新认证"]) {
        
        [dic setObject:self.beforeId forKey:@"before_id"];
        [BaseRequest POST:@"agent/personal/reAuth" parameters:dic success:^(id resposeObject) {
            
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"提交成功" And:@"请等待审核" WithDefaultBlack:^{
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[MineVC class]]) {
                            
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                    }
                }];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }else{
        
        [BaseRequest POST:AddAuthInfo_URL parameters:dic success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self alertControllerWithNsstring:@"提交成功" And:@"请等待审核" WithDefaultBlack:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
            else{
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    [_numTextField endEditing:YES];
    switch (btn.tag) {
        case 0:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            nextVC.selectCompanyVCBlock = ^(NSString *companyId, NSString *name) {
                
                self->_companyId = companyId;
                self->_companyL.text = name;
                self->_projectL.text = @"";
                self->_projectId = @"";
            };
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 1:
        {
            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 2:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择角色" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *agent = [UIAlertAction actionWithTitle:@"经纪人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self->_role = @"1";
                self->_roleL.text = @"经纪人";
                self->_projectL.text = @"";
                self->_projectId = @"";
            }];
            
            UIAlertAction *comfirm = [UIAlertAction actionWithTitle:@"到访确认人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self->_role = @"2";
                self->_roleL.text = @"到访确认人";
            }];
            
            UIAlertAction *sign = [UIAlertAction actionWithTitle:@"确认单签字人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self->_role = @"3";
                self->_roleL.text = @"确认单签字人";
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:agent];
            [alert addAction:comfirm];
            [alert addAction:sign];
            [alert addAction:cancel];
            [self.navigationController presentViewController:alert animated:YES completion:^{
                
            }];
            break;
        }
        case 3:
        {
            if ([_role isEqualToString:@"2"] || [_role isEqualToString:@"3"]) {
                
                if (_companyId) {
                    
                    ApplyProjectVC *nextVC = [[ApplyProjectVC alloc] initWithCompanyId:_companyId];
                    nextVC.applyProjectVCBlock = ^(NSString *projectId, NSString *name) {
                        
                        self->_projectL.text = name;
                        self->_projectId = [NSString stringWithFormat:@"%@",projectId];
                        [self->_projectLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(self->_whiteView).offset(0 *SIZE);
                            make.top.equalTo(self->_projectL.mas_bottom).offset(16 *SIZE);
                            make.width.mas_equalTo(360 *SIZE);
                            make.height.mas_equalTo(SIZE);
                        }];
                    };
                    [self.navigationController pushViewController:nextVC animated:YES];
                }else{
                    
                    [self showContent:@"请先选择公司"];
                }
            }else{
                
                [self showContent:@"只有到访确认人才能申请固定项目"];
            }
            break;
        }
            //        case 4:
            //        {
            //            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            //            [self.navigationController pushViewController:nextVC animated:YES];
            //            break;
            //        }
            //        case 5:
            //        {
            ////            SelectCompanyVC *nextVC = [[SelectCompanyVC alloc] init];
            ////            [self.navigationController pushViewController:nextVC animated:YES];
            //            break;
            //        }
        case 6:
        {
//            [[[UIApplication sharedApplication] keyWindow] addSubview:self.dateView];
            
            DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
            __weak __typeof(&*self)weakSelf = self;
            view.dateblock = ^(NSDate *date) {
                
                weakSelf.timeL.text = [weakSelf.formatter stringFromDate:date];
            };
            [[[UIApplication sharedApplication] keyWindow] addSubview:view];
            break;
        }
        default:
            break;
    }
}

- (void)ActionTap{
    
    if ([_role isEqualToString:@"2"] || [_role isEqualToString:@"3"]) {
        
        if (_companyId) {
            
            ApplyProjectVC *nextVC = [[ApplyProjectVC alloc] initWithCompanyId:_companyId];
            nextVC.applyProjectVCBlock = ^(NSString *projectId, NSString *name) {
                
                self->_projectL.text = name;
                self->_projectId = [NSString stringWithFormat:@"%@",projectId];
                [self->_projectLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(self->_whiteView).offset(0 *SIZE);
                    make.top.equalTo(self->_projectL.mas_bottom).offset(16 *SIZE);
                    make.width.mas_equalTo(360 *SIZE);
                    make.height.mas_equalTo(SIZE);
                }];
            };
            [self.navigationController pushViewController:nextVC animated:YES];
        }else{
            
            [self showContent:@"请先选择公司"];
        }
    }else{
        
        [self showContent:@"只有到访确认人才能申请固定项目"];
    }
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = YES;
    //    [cell.cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_imgUrl) {
        
        cell.imageView.image = _image;
        //        cell.cancelBtn.hidden = YES;
    }else{
        
        cell.imageView.image =[UIImage imageNamed:@"uploadphotos"];
        //        cell.cancelBtn.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectPhotoAlbumPhotos];
    }];
    UIAlertAction *takePic = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self takingPictures];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePic];
    [alertController addAction:photo];
    [alertController addAction:cancel];
    [self.navigationController presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark - 选择头像

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
                                                              //                                                       _uploadButton.hidden = NO;
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            
            _image = info[UIImagePickerControllerOriginalImage];;
            
            NSData *data = [self resetSizeOfImageData:_image maxSize:150];
            
            [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"id_card"
                                                               }
                  constructionBody:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:data name:@"id_card" fileName:@"id_card.jpg" mimeType:@"image/jpg"];
                  } success:^(id resposeObject) {
                      //                      NSLog(@"%@",resposeObject);
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          self->_imgUrl = resposeObject[@"data"];
                      }else{
                          
                          [self showContent:resposeObject[@"msg"]];
                      }
                      [self.authenColl reloadData];
                  } failure:^(NSError *error) {
                      //                      NSLog(@"%@",error);
                      [self showContent:@"网络错误"];
                  }];
            
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        _image = info[UIImagePickerControllerOriginalImage];
        NSData *data = [self resetSizeOfImageData:_image maxSize:150];
        
        [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"id_card"
                                                           }
              constructionBody:^(id<AFMultipartFormData> formData) {
                  [formData appendPartWithFileData:data name:@"id_card" fileName:@"id_card.jpg" mimeType:@"image/jpg"];
              } success:^(id resposeObject) {
                  //                  NSLog(@"%@",resposeObject);
                  
                  if ([resposeObject[@"code"] integerValue] == 200) {
                      
                      self->_imgUrl = resposeObject[@"data"];
                  }else{
                      
                      [self showContent:resposeObject[@"msg"]];
                  }
                  [self.authenColl reloadData];
              } failure:^(NSError *error) {
                  //                  NSLog(@"%@",error);
                  [self showContent:@"网络错误"];
              }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.authenColl reloadData];
        
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.titleLabel.text = @"认证信息填写";
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _scrollView.backgroundColor = self.view.backgroundColor;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width, 672 *SIZE);
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _whiteView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_Width, 361 *SIZE)];
    _whiteView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_whiteView];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_scrollView).offset(0);
        make.top.equalTo(self->_scrollView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
    }];
    
    for (int i = 0; i < 7; i++) {
        
        UILabel *label = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 16 *SIZE + i * 50 *SIZE, 100 *SIZE, 12 *SIZE)];
        label.textColor = YJContentLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _titleArr[i];
        
        UIView *line = [[UIView alloc] init];//WithFrame:CGRectMake(0, 49 *SIZE * (i + 1), SCREEN_Width, SIZE)];
        line.backgroundColor = YJBackColor;
        
        UILabel *label1 = [[UILabel alloc] init];//WithFrame:CGRectMake(100 *SIZE, 18 *SIZE + i * 50 *SIZE, 230 *SIZE, 12 *SIZE)];
        label1.textColor = YJContentLabColor;
        label1.textAlignment = NSTextAlignmentRight;
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        
        UIImageView *img = [[UIImageView alloc] init];//WithFrame:CGRectMake(343 *SIZE, 19 *SIZE + i * 50*SIZE, 12 *SIZE, 12 *SIZE)];
        img.image = [UIImage imageNamed:@"rightarrow"];
        [_whiteView addSubview:img];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(0, i * 50 *SIZE, SCREEN_Width, 50 *SIZE);
        [button addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        switch (i) {
            case 0:
            {
                _companyTL = label;
                [_whiteView addSubview:_companyTL];
                _compantLine = line;
                [_whiteView addSubview:_compantLine];
                
                _companyL = label1;
                [_whiteView addSubview:_companyL];
                _companyBtn = button;
                [_whiteView addSubview:_companyBtn];
                break;
            }
            case 1:
            {
                UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
                textFiled.textAlignment = NSTextAlignmentRight;
                _numTextField = textFiled;
                _numTextField.keyboardType = UIKeyboardTypeNumberPad;
                [_whiteView addSubview:_numTextField];
                
                _numTL = label;
                [_whiteView addSubview:_numTL];
                _numLine = line;
                [_whiteView addSubview:_numLine];
                
                break;
            }
            case 2:
            {
                _roleTL = label;
                [_whiteView addSubview:_roleTL];
                _roleLine = line;
                [_whiteView addSubview:_roleLine];
                
                _roleL = label1;
                [_whiteView addSubview:_roleL];
                _role = @"1";
                _roleL.text = @"经纪人";
                
                _roleBtn = button;
                [_whiteView addSubview:_roleBtn];
                break;
            }
            case 3:
            {
                _projectTL = label;
                [_whiteView addSubview:_projectTL];
                _projectLine = line;
                [_whiteView addSubview:_projectLine];
                
                _projectL = label1;
//                _projectL.textAlignment = NSTextAlignmentLeft;
                _projectL.numberOfLines = 0;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
                _projectL.userInteractionEnabled = YES;
                [_projectL addGestureRecognizer:tap];
                [_whiteView addSubview:_projectL];
                
                _projectBtn = button;
                [_whiteView addSubview:_projectBtn];
                break;
            }
            case 4:
            {
                
                UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
                textFiled.textAlignment = NSTextAlignmentRight;
                _departTextField = textFiled;
                [_whiteView addSubview:_departTextField];
                
                _departTL = label;
                [_whiteView addSubview:_departTL];
                _departLine = line;
                [_whiteView addSubview:_departLine];
                break;
            }
            case 5:
            {
                
                UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(100 *SIZE, 50 *SIZE * i, 230 *SIZE, 49 *SIZE)];
                textFiled.textAlignment = NSTextAlignmentRight;
                _positionTextField = textFiled;
                [_whiteView addSubview:_positionTextField];
                
                _positionTL = label;
                [_whiteView addSubview:_positionTL];
                _positionLine = line;
                [_whiteView addSubview:_positionLine];
                break;
            }
            case 6:
            {
                _timeTL = label;
                [_whiteView addSubview:_timeTL];
                _timeLine = line;
                [_whiteView addSubview:_timeLine];
                
                _timeL = label1;
                [_whiteView addSubview:_timeL];
                
                _timeBtn = button;
                [_whiteView addSubview:_timeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    [_companyTL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_companyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_whiteView).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_compantLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_companyBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_numTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_compantLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_numLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_numTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_roleTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_numLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_roleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_numLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_roleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_numLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_roleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_roleBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_projectTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_roleLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_roleLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_projectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_roleLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_projectLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_projectBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_departTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_projectLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_departTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_projectLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_departLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_departTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_positionTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_positionTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_departLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_positionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_positionTextField.mas_bottom).offset(SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
    }];
    
    [_timeTL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(9 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(110 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(220 *SIZE);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_positionLine.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(49 *SIZE);
    }];
    
    [_timeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_whiteView).offset(0 *SIZE);
        make.top.equalTo(self->_timeBtn.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self->_whiteView).offset(0 *SIZE);
    }];

    _collView = [[UIView alloc] init];//WithFrame:CGRectMake(0, CGRectGetMaxY(_whiteView.frame), SCREEN_Width, 174 *SIZE)];
    _collView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_collView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 100 *SIZE, 13 *SIZE)];
    label1.textColor = YJContentLabColor;
    label1.font = [UIFont systemFontOfSize:13 *SIZE];
    label1.text = @"工牌照片";
    [_collView addSubview:label1];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl.backgroundColor = [UIColor whiteColor];
    _authenColl.delegate = self;
    _authenColl.dataSource = self;
    
    [_authenColl registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [_collView addSubview:_authenColl];
    
    [_collView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(0 *SIZE);
        make.top.equalTo(self->_whiteView.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
        make.height.mas_equalTo(174 *SIZE);
    }];
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _commitBtn.frame = CGRectMake(21 *SIZE, 37 *SIZE + CGRectGetMaxY(whiteView.frame), 317 *SIZE, 40 *SIZE);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 2 *SIZE;
    _commitBtn.backgroundColor = YJLoginBtnColor;
    [_commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16 *SIZE];
    [_commitBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_commitBtn];
    
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_scrollView).offset(21 *SIZE);
        make.top.equalTo(self->_collView.mas_bottom).offset(37 *SIZE);
        make.width.mas_equalTo(317 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self->_scrollView.mas_bottom).offset(-37 *SIZE);
    }];
}

- (DateChooseView *)dateView{
    
    if (!_dateView) {
        
        _dateView = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        __weak __typeof(&*self)weakSelf = self;
        _dateView.dateblock = ^(NSDate *date) {
            
            weakSelf.timeL.text = [weakSelf.formatter stringFromDate:date];
        };
    }
    return _dateView;
}

@end
