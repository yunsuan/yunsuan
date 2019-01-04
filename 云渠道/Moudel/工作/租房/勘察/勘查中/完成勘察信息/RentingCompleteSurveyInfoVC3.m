//
//  RentingCompleteSurveyInfoVC3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyInfoVC3.h"

#import "RentingSurveyVC.h"
#import "SecDistributVC.h"
#import "SystemoWorkVC.h"

#import "TextFieldImgCell.h"
#import "ChangeImgNameView.h"

#import "DropDownBtn.h"

@interface RentingCompleteSurveyInfoVC3 ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_ImgArr;
    NSMutableArray *_titleArr;
    NSMutableArray *_NameUrlArr;
    //    NSInteger _section;
    NSInteger _index;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSString *_imgUrl;
}
@property (nonatomic, strong) DropDownBtn *selectBtn;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UITableView *imgTable;

@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation RentingCompleteSurveyInfoVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _ImgArr = [@[] mutableCopy];
    _titleArr = [@[] mutableCopy];
    _NameUrlArr = [@[] mutableCopy];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}

- (void)ActionDoneBtn:(UIButton *)btn{
    
    [_NameUrlArr removeAllObjects];
    for (int i = 0; i < _ImgArr.count; i++) {
        
        NSDictionary *tempDic = @{@"name":_titleArr[i],
                                  @"img_url":_ImgArr[i][@"img_url"]
                                  };
        [_NameUrlArr addObject:tempDic];
    }
    
    if (_NameUrlArr.count) {
        
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_NameUrlArr
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self.dic setObject:jsonResult forKey:@"img_group"];
    }
    
    NSString *urlStr;
    if (self.dic[@"survey_id"]) {
        
        urlStr = RentSurveySuccess_URL;
    }else{
        
        urlStr = @"agent/house/recordAndSurvey";
    }
    [BaseRequest POST:urlStr parameters:self.dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"勘察成功" WithDefaultBlack:^{
                
                if (self.rentCompleteSurveyInfoVCBlock3) {
                    
                    self.rentCompleteSurveyInfoVCBlock3();
                }
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[RentingSurveyVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                    if ([vc isKindOfClass:[SecDistributVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                    
                    if ([vc isKindOfClass:[SystemoWorkVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _ImgArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 223 *SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TextFieldImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldImgCell"];
    if (!cell) {
        
        cell = [[TextFieldImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextFieldImgCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textFieldImgCellBlock = ^(NSString *str) {
        
        if (indexPath.row < _ImgArr.count) {
            
            ChangeImgNameView *view = [[ChangeImgNameView alloc] initWithFrame:self.view.frame];
            view.changeImgNameViewBlock = ^(NSString *str) {
                
                [_titleArr replaceObjectAtIndex:indexPath.row withObject:str];
                [tableView reloadData];
            };
            [self.view addSubview:view];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"请选择图片"];
        };
    };
    
    if (indexPath.item < _ImgArr.count) {
        NSString *imageurl = _ImgArr[indexPath.item][@"img_url"];
        
        if (imageurl.length>0) {
            [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_ImgArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    cell.bigImg.image = [UIImage imageNamed:@"default_3"];
                }
            }];
        }
        else{
            cell.bigImg.image = [UIImage imageNamed:@"default_3"];
        }
        cell.nameL.text = _titleArr[indexPath.item];
    }else{
        
        cell.bigImg.image = [UIImage imageNamed:@"add20"];
        cell.nameL.text = @"输入图片名称";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    _section = indexPath.section;
    _index = indexPath.item;
    
    BOOL Name = false;
    for (NSString *str in _titleArr) {
        
        if ([str isEqualToString:@"输入图片名称"]) {
            
            Name = YES;
            break;
        }
    }
    if (Name) {
        
        [self alertControllerWithNsstring:@"温馨提示" And:@"请输入图片名称"];
    }else{
        
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
            
            if (_index < [_ImgArr count]) {
                
                NSData *data = [self resetSizeOfImageData:_image maxSize:150];
                
                [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                                   }
                      constructionBody:^(id<AFMultipartFormData> formData) {
                          [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
                      } success:^(id resposeObject) {
                          
                          if ([resposeObject[@"code"] integerValue] == 200) {
                              
                              _imgUrl = resposeObject[@"data"];
                              NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
                              [tempDic setObject:_imgUrl forKey:@"img_url"];
                              [_ImgArr replaceObjectAtIndex:_index withObject:tempDic];
                          }else{
                              
                              [self showContent:resposeObject[@"msg"]];
                          };
                          [_imgTable reloadData];
                      } failure:^(NSError *error) {
                          
                          [self showContent:@"网络错误"];
                      }];
                
            }else{
                
                NSData *data = [self resetSizeOfImageData:_image maxSize:150];
                
                [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                                   }
                      constructionBody:^(id<AFMultipartFormData> formData) {
                          [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
                      } success:^(id resposeObject) {
                          
                          if ([resposeObject[@"code"] integerValue] == 200) {
                              
                              _imgUrl = resposeObject[@"data"];
                              NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
                              [tempDic setObject:_imgUrl forKey:@"img_url"];
                              [_ImgArr addObject:tempDic];
                              [_titleArr addObject:@"输入图片名称"];
                          }else{
                              
                              [self showContent:resposeObject[@"msg"]];
                          };
                          [_imgTable reloadData];
                      } failure:^(NSError *error) {
                          
                          [self showContent:@"网络错误"];
                      }];
                
            }
            [self.imgTable reloadData];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        
        _image = info[UIImagePickerControllerOriginalImage];;
        
        if (_index < [_ImgArr count]) {
            
            NSData *data = [self resetSizeOfImageData:_image maxSize:150];
            
            [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                               }
                  constructionBody:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
                  } success:^(id resposeObject) {
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          _imgUrl = resposeObject[@"data"];
                          NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
                          [tempDic setObject:_imgUrl forKey:@"img_url"];
                          [_ImgArr replaceObjectAtIndex:_index withObject:tempDic];
                      }else{
                          
                          [self showContent:resposeObject[@"msg"]];
                      };
                      [_imgTable reloadData];
                  } failure:^(NSError *error) {
                      
                      [self showContent:@"网络错误"];
                  }];
            
        }else{
            
            NSData *data = [self resetSizeOfImageData:_image maxSize:150];
            
            [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"img"
                                                               }
                  constructionBody:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
                  } success:^(id resposeObject) {
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          _imgUrl = resposeObject[@"data"];
                          NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
                          [tempDic setObject:_imgUrl forKey:@"img_url"];
                          [_ImgArr addObject:tempDic];
                          [_titleArr addObject:@"输入图片名称"];
                      }else{
                          
                          [self showContent:resposeObject[@"msg"]];
                      };
                      [_imgTable reloadData];
                  } failure:^(NSError *error) {
                      
                      [self showContent:@"网络错误"];
                  }];
            
        }
        [self.imgTable reloadData];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.imgTable reloadData];
        
    }];
}


// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.titleLabel.text = @"完成勘察信息";
    self.navBackgroundView.hidden = NO;
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 50 *SIZE)];
    _titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_titleView];
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 19 *SIZE, 7 *SIZE, 13 *SIZE)];
    _blueView.backgroundColor = YJBlueBtnColor;
    [_titleView addSubview:_blueView];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(27 *SIZE, 19 *SIZE, 300 *SIZE, 14 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.text = @"房源实拍图片";
    [_titleView addSubview:_titleL];
    
    
    _imgTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT + 51 *SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 91 *SIZE - TAB_BAR_MORE) style:UITableViewStylePlain];
    _imgTable.backgroundColor = self.view.backgroundColor;
    _imgTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _imgTable.delegate = self;
    _imgTable.dataSource = self;
    [self.view addSubview:_imgTable];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_doneBtn addTarget:self action:@selector(ActionDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_doneBtn setTitle:@"完成勘察" forState:UIControlStateNormal];
    [_doneBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_doneBtn];
    
}

@end
