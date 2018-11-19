//
//  ModifyProjectImageVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyProjectImageVC.h"

#import "TextFieldImgCell.h"

#import "ChangeImgNameView.h"
#import "DropDownBtn.h"
#import "AddAlbumView.h"

@interface ModifyProjectImageVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_ImgArr;
    NSMutableArray *_titleArr;
    NSMutableArray *_NameUrlArr;
    NSInteger _section;
    NSInteger _index;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
    NSString *_imgUrl;
    NSMutableArray *_nameArr;
    NSMutableDictionary *_imgDic;
}
@property (nonatomic, strong) DropDownBtn *selectBtn;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UITableView *imgTable;

@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation ModifyProjectImageVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _ImgArr = [@[] mutableCopy];
        _titleArr = [@[] mutableCopy];
    }
    return self;
}

- (instancetype)initWithImgArr:(NSArray *)imgArr
{
    self = [super init];
    if (self) {
        
        _ImgArr = [NSMutableArray arrayWithArray:imgArr];
        _titleArr = [@[] mutableCopy];
        for (int i = 0; i < imgArr.count; i++) {
            
            [_titleArr addObject:imgArr[i][@"name"]];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
//    _nameArr = [@[] mutableCopy];
//    _ImgArr = [@[] mutableCopy];
    _NameUrlArr = [@[] mutableCopy];
    _imgDic = [@{} mutableCopy];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}

- (void)ActionEditBtn:(UIButton *)btn{
    
    self.rightBtn.selected = !self.rightBtn.selected;
    if (self.rightBtn.selected) {
        
        _imgTable.editing = YES;
    }
}

- (void)ActionDoneBtn:(UIButton *)btn{
    
    [_NameUrlArr removeAllObjects];
    [_imgDic removeAllObjects];
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
        [_imgDic setObject:jsonResult forKey:@"img_group"];
    }
    [_imgDic setObject:_houseId forKey:@"house_id"];

    [BaseRequest POST:UpdateImgURL parameters:_imgDic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            [self alertControllerWithNsstring:@"温馨提示" And:@"修改成功" WithDefaultBlack:^{

                if (self.modifyProjectImageVCBlock) {
                    
                    self.modifyProjectImageVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

#pragma mark -- request --

- (void)RequestAddDic:(NSDictionary *)dic index:(NSInteger )index{
    
    
    [BaseRequest POST:HouseSurveyAddImg_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyProjectImageVCBlock) {
                
                self.modifyProjectImageVCBlock();
            }
            NSMutableDictionary *mutabDic = [NSMutableDictionary dictionaryWithDictionary:@{@"img_id":resposeObject[@"data"],@"img_url":dic[@"img_url"],@"name":@"请输入图片名称"}];
            [_ImgArr addObject:mutabDic];
            [_nameArr addObject:mutabDic];;
            [_imgTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

- (void)RequestModifyDic:(NSDictionary *)dic index:(NSInteger )index{
    
    [BaseRequest POST:HouseSurveyUpdateImg_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyProjectImageVCBlock) {
                
                self.modifyProjectImageVCBlock();
            }
            NSMutableDictionary *mutabDic = [NSMutableDictionary dictionaryWithDictionary:@{@"img_id":dic[@"img_id"],@"img_url":dic[@"img_url"],@"name":@"请输入图片名称"}];
            [_ImgArr replaceObjectAtIndex:index withObject:mutabDic];
            [_nameArr replaceObjectAtIndex:index withObject:mutabDic];
            [_imgTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
        NSLog(@"%@",error);
    }];
}

#pragma mark -- table --

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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row < _ImgArr.count) {
        
        return YES;
    }
    
    return NO;
}


// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}



// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [BaseRequest GET:HouseSurveyDelImg_URL parameters:@{@"img_id":_ImgArr[indexPath.row][@"img_id"]} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyProjectImageVCBlock) {
                
                self.modifyProjectImageVCBlock();
            }
            [self showContent:@"删除成功"];
            [_ImgArr removeObjectAtIndex:indexPath.row];
            [_nameArr removeObjectAtIndex:indexPath.row];
            [_imgTable reloadData];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _section = indexPath.section;
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
    
    
    self.titleLabel.text = @"修改图片信息";
    self.navBackgroundView.hidden = NO;

    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 50 *SIZE)];
    _titleView.backgroundColor = CH_COLOR_white;
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
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_doneBtn addTarget:self action:@selector(ActionDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_ImgArr.count) {
        
        [_doneBtn setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        
        [_doneBtn setTitle:@"完成勘察" forState:UIControlStateNormal];
    }
    [_doneBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_doneBtn];
    
}

@end
