//
//  UploadImageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/8/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UploadImageVC.h"

#import "YBImageBrowser.h"

#import "AuthenCollCell.h"

@interface UploadImageVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,YBImageBrowserDelegate>
{
    
    NSInteger _index;
    
    NSString *_project_client_id;
    NSString *_type;
    NSString *_imageUrl;
    
    NSMutableArray *_dataArr;
    
    UIImage *_image;
    
    UIImagePickerController *_imagePickerController;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;
@end

@implementation UploadImageVC

- (instancetype)initWithProjectClientId:(NSString *)project_client_id type:(NSString *)type
{
    self = [super init];
    if (self) {
        
        _project_client_id = project_client_id;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _dataArr = [@[] mutableCopy];
    
    [self initUI];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:@"agent/client/img/list" parameters:@{@"project_client_id":_project_client_id,@"type":_type} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [_coll reloadData];
        }else{
            
//            [_dataArr removeAllObjects];
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (_dataArr.count < 6) {
        
        return _dataArr.count + 1;
    }else{
        
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    [cell.cancelBtn setImage:[UIImage imageNamed:@"ibde"] forState:UIControlStateNormal];
    cell.cancelBtn.tag = indexPath.item;
    if (indexPath.item < _dataArr.count) {
        
        cell.cancelBtn.hidden = NO;
    }else{
        
        cell.cancelBtn.hidden = YES;
    }
    
    if (_dataArr.count) {
        
        if (indexPath.item < _dataArr.count) {
            
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"uploadphotos"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               
                if (error) {
                    
                    cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
                }
            }];
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
        cell.cancelBtn.hidden = YES;
    }
    
    cell.authenCollCellDeleteBlock = ^{
      
        [BaseRequest POST:@"agent/client/img/delete" parameters:@{@"img_id":[NSString stringWithFormat:@"%@",_dataArr[indexPath.item][@"img_id"]],@"type":_type} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_dataArr removeObjectAtIndex:indexPath.item];
                [_coll reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.item == _dataArr.count) {
        
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
    }else{
        
        NSMutableArray *tempArr = [NSMutableArray array];
        [_dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            YBImageBrowserModel *model = [YBImageBrowserModel new];
            model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
            [tempArr addObject:model];
        }];
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.delegate = self;
        browser.dataArray = tempArr;
        if ([_type isEqualToString:@"2"]) {
            
            browser.albumArr = @[@{@"name":@"到访凭证"}];
            browser.title = @"到访凭证";
        }else{
            
            browser.albumArr = @[@{@"name":@"成交凭证"}];
            browser.title = @"成交凭证";
        }
        
        
        browser.infoid = @"";
        browser.currentIndex = indexPath.item;
        [browser show];
    }
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
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            
            _image = info[UIImagePickerControllerOriginalImage];;
            NSData *data = [self resetSizeOfImageData:_image maxSize:150];
            
            [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                               }
                  constructionBody:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
                  } success:^(id resposeObject) {
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          _imageUrl = resposeObject[@"data"];
                          [BaseRequest POST:@"agent/client/img/add" parameters:@{@"project_client_id":_project_client_id,@"type":_type,@"img_url":_imageUrl} success:^(id resposeObject) {
                              
                              if ([resposeObject[@"code"] integerValue] == 200) {
                                  
                                  if (_index < _dataArr.count) {
                                      
                                      [_dataArr replaceObjectAtIndex:_index withObject:@{@"img_id":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"img_url":_imageUrl}];
                                  }else{
                                      
                                      
                                      [_dataArr addObject:@{@"img_id":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"img_url":_imageUrl}];
                                  }
                                  [self.coll reloadData];
                              }else{
                                  
                                  [self showContent:resposeObject[@"msg"]];
                              }
                          } failure:^(NSError *error) {
                              
                              [self showContent:@"网络错误"];
                          }];
                          
                      }else{
                          
                          [self showContent:resposeObject[@"msg"]];
                      }
                      
                  } failure:^(NSError *error) {
                      
                      [self showContent:@"网络错误"];
                  }];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        _image = info[UIImagePickerControllerOriginalImage];
        NSData *data = [self resetSizeOfImageData:_image maxSize:150];
        
        [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                           }
              constructionBody:^(id<AFMultipartFormData> formData) {
                  [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
              } success:^(id resposeObject) {
                  
                  if ([resposeObject[@"code"] integerValue] == 200) {
                      
                      _imageUrl = resposeObject[@"data"];
                      [BaseRequest POST:@"agent/client/img/add" parameters:@{@"project_client_id":_project_client_id,@"type":_type,@"img_url":_imageUrl} success:^(id resposeObject) {
                          
                          if ([resposeObject[@"code"] integerValue] == 200) {
                              
                              if (_index < _dataArr.count) {
                                  
                                  [_dataArr replaceObjectAtIndex:_index withObject:@{@"img_id":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"img_url":_imageUrl}];
                              }else{
                                  
                                  [_dataArr addObject:@{@"img_id":[NSString stringWithFormat:@"%@",resposeObject[@"data"]],@"img_url":_imageUrl}];
                              }
                              [self.coll reloadData];
                          }else{
                              
                              [self showContent:resposeObject[@"msg"]];
                          }
                      } failure:^(NSError *error) {
                          
                          [self showContent:@"网络错误"];
                      }];
                  }else{
                      
                      [self showContent:resposeObject[@"msg"]];
                  }
                  
                  
              } failure:^(NSError *error) {
                  
                  [self showContent:@"网络错误"];
              }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_coll reloadData];
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    
    if ([_type isEqualToString:@"2"]) {
        
        self.titleLabel.text = @"上传到访凭证";
    }else{
        
        self.titleLabel.text = @"上传成交凭证";
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    
    [_coll registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [self.view addSubview:_coll];
}
@end
