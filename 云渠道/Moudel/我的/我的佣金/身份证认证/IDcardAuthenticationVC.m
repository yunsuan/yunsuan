//
//  IDcardAuthenticationVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "IDcardAuthenticationVC.h"

@interface IDcardAuthenticationVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSInteger _index;
    NSString *_imgUrl1;
    NSString *_imgUrl2;
    NSString *_imgUrl3;
}
@property (nonatomic, strong) UITextField *nameTF;

@property (nonatomic, strong) UITextField *idCardTF;

@property (nonatomic, strong) UIImageView *img1;

@property (nonatomic, strong) UIImageView *img2;

@property (nonatomic, strong) UIImageView *img3;

@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation IDcardAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    [self initUI];
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    _index = btn.tag;
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

- (void)ActionDoneBtn:(UIButton *)btn{
    
    if ([self isEmpty:_nameTF.text]) {
        
        [self showContent:@"请填写姓名"];
        return;
    }
    
    if ([self isEmpty:_idCardTF.text]) {
        
        [self showContent:@"请填写身份证号"];
        return;
    }
    
    if (!_imgUrl1) {
        
        [self showContent:@"请上传正面人像页"];
        return;
    }
    
    if (!_imgUrl2) {
        
        [self showContent:@"请上传背面国徽页"];
        return;
    }
    
    if (!_imgUrl3) {
        
        [self showContent:@"请上传手持身份证照片"];
        return;
    }
    
    NSDictionary *dic = @{@"name":_nameTF.text,
                          @"card_id":_idCardTF.text,
                          @"card_front":_imgUrl1,
                          @"card_back":_imgUrl2,
                          @"card_hand":_imgUrl3
                          };
    [BaseRequest POST:AgentAuth_URL parameters:dic success:^(id resposeObject) {
        
//        NSLog(@"%@",resposeObject);
     
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
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
                          
                          if (_index == 0) {
                              
                              _img1.image = _image;
                              _imgUrl1 = resposeObject[@"data"];
                          }else if (_index == 1){
                              
                              _img2.image = _image;
                              _imgUrl2 = resposeObject[@"data"];
                          }else{
                              
                              _img3.image = _image;
                              _imgUrl3 = resposeObject[@"data"];
                          }
                      }else{
                          
                          [self showContent:resposeObject[@"msg"]];
                      }
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
                      
                      if (_index == 0) {
                          
                          _img1.image = _image;
                          _imgUrl1 = resposeObject[@"data"];
                      }else if (_index == 1){
                          
                          _img2.image = _image;
                          _imgUrl2 = resposeObject[@"data"];
                      }else{
                          
                          _img3.image = _image;
                          _imgUrl3 = resposeObject[@"data"];
                      }
                  }else{
                      
                      [self showContent:resposeObject[@"msg"]];
                  }
              } failure:^(NSError *error) {
//                  NSLog(@"%@",error);
                  [self showContent:@"网络错误"];
              }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.titleLabel.text = @"身份证认证";
    self.navBackgroundView.hidden = NO;
    
    for (int i = 0; i < 2; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + i *52 *SIZE, SCREEN_Width, 50 *SIZE)];
        view.backgroundColor = CH_COLOR_white;
        [self.view addSubview:view];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 18 *SIZE, 60 *SIZE, 13 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        if (i == 0) {
            
            label.text = @"姓名";
        }else{
            
            label.text = @"身份证号";
        }
        [view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(85 *SIZE, 0, 260 *SIZE, 50 *SIZE)];
        textField.font = [UIFont systemFontOfSize:13 *SIZE];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (i == 0) {
            
            textField.placeholder = @"请填写身份证上姓名";
            _nameTF = textField;
            [view addSubview:_nameTF];
        }else{
            
            textField.placeholder = @"请填写身份证号码";
            _idCardTF = textField;
            [view addSubview:_idCardTF];
        }
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 104 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 158 *SIZE)];
    view.backgroundColor = CH_COLOR_white;
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, 15 *SIZE, 100 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"身份证照片：";
    [view addSubview:label];
    
    NSArray *titleArr = @[@"上传正面人像页",@"上传背面国徽页",@"手持正面身份证"];
    NSArray *imgArr = @[@"positive",@"back",@"handheld"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13 *SIZE + i * 122 *SIZE, 132 *SIZE, 100 *SIZE, 10 *SIZE)];
        label.textColor = YJ170Color;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        label.text = titleArr[i];
        [view addSubview:label];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE + i * 123 *SIZE, 43 *SIZE, 83 *SIZE, 83 *SIZE)];
        img.layer.cornerRadius = 2 *SIZE;
        img.clipsToBounds = YES;
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.image = [UIImage imageNamed:imgArr[i]];
        if (i == 0) {
            
            _img1 = img;
            [view addSubview:_img1];
        }else if (i == 1){
            
            _img2 = img;
            [view addSubview:_img2];
        }else{
            
            _img3 = img;
            [view addSubview:_img3];
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 *SIZE + i * 123 *SIZE, 43 *SIZE, 83 *SIZE, 83 *SIZE);
        [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [view addSubview:btn];
    }
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.frame = CGRectMake(22 *SIZE, 492 *SIZE + NAVIGATION_BAR_HEIGHT, 317 *SIZE, 40 *SIZE);
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_doneBtn addTarget:self action:@selector(ActionDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_doneBtn setBackgroundColor:YJBlueBtnColor];
    
    [self.view addSubview:_doneBtn];
    
}

@end
