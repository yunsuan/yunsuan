//
//  RecommendConfirmVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendConfirmVC.h"

#import "SinglePickView.h"

#import "DropDownBtn.h"

#import "AuthenCollCell.h"

@interface RecommendConfirmVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    
    NSMutableDictionary *_dic;
    NSMutableArray *_peopleArr;
    NSMutableArray *_ruleArr;
    
    BOOL _isOne;
    NSInteger _index;
    NSMutableArray *_imgArr1;
    NSMutableArray *_imgUrl1;
    NSMutableArray *_imgArr2;
    NSMutableArray *_imgUrl2;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
}

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) DropDownBtn *numBtn;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) UILabel *visitL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *authenColl1;

@property (nonatomic, strong) UILabel *confirmL;

@property (nonatomic, strong) UICollectionView *authenColl2;

@property (nonatomic, strong) UILabel *recommendTypeL;

@property (nonatomic, strong) DropDownBtn *recommendTypeBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation RecommendConfirmVC

- (instancetype)initWithData:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _dic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _peopleArr = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d人",i];
        [_peopleArr addObject:@{@"id":@(i),@"param":str}];
    }
    
    _imgArr1 = [@[] mutableCopy];
    _imgArr2 = [@[] mutableCopy];
    _imgUrl1 = [@[] mutableCopy];
    _imgUrl2 = [@[] mutableCopy];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    
    if (!_numBtn->str) {
        
        [self showContent:@"请选择到访人数"];
        return;
        
    }
    
    if (_numBtn->str) {
        
        [_dic setObject:_numBtn->str forKey:@"visit_num"];
    }
    
    if (_purposeBtn->str) {
        
        [_dic setObject:_purposeBtn->str forKey:@"buy_purpose"];
    }
}

- (void)ActionTagNumBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_peopleArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.numBtn.content.text = MC;
                weakself.numBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 1:
        {
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:[self getDetailConfigArrByConfigState:BUY_TYPE]];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.purposeBtn.content.text = MC;
                weakself.purposeBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
            break;
        }
        case 2:
        {
            
            break;
        }
        case 3:{
            
            SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:_ruleArr];
            WS(weakself);
            view.selectedBlock = ^(NSString *MC, NSString *ID) {
                
                weakself.recommendTypeBtn.content.text = MC;
                weakself.recommendTypeBtn->str = [NSString stringWithFormat:@"%@",ID];
            };
            [self.view addSubview:view];
        }
        default:
            break;
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _placeL.hidden = YES;
    }else{
        
        _placeL.hidden = NO;
    }
}

#pragma mark --coll代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _authenColl1) {
        
        return 1;
    }else{
        
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AuthenCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthenCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AuthenCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 91 *SIZE)];
    }
    cell.cancelBtn.tag = indexPath.item;
    cell.cancelBtn.hidden = YES;

    if (collectionView == _authenColl1) {
        
        if (_imgArr1.count) {
            
            if (indexPath.item < _imgArr1.count) {
                
                cell.imageView.image = _imgArr1[indexPath.item];
            }else{
                
                cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
                cell.cancelBtn.hidden = YES;
            }
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }else{
        
        if (_imgArr2.count) {
            
            if (indexPath.item < _imgArr2.count) {
                
                cell.imageView.image = _imgArr2[indexPath.item];
            }else{
                
                cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
                cell.cancelBtn.hidden = YES;
            }
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"uploadphotos"];
            cell.cancelBtn.hidden = YES;
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath.item;
    if (collectionView == _authenColl1) {
        
        _isOne = YES;
    }else{
        
        _isOne = NO;
    }
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
            
            [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"verify"
                                                               }
                  constructionBody:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFileData:data name:@"verify" fileName:@"verify.jpg" mimeType:@"image/jpg"];
                  } success:^(id resposeObject) {
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          if (_isOne) {
                              
                              if (_index < _imgArr1.count) {
                                  
                                  [_imgArr1 replaceObjectAtIndex:_index withObject:_image];
                                  [_imgUrl1 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                              }else{
                                  
                                  [_imgArr1 addObject:_image];
                                  [_imgUrl1 addObject:resposeObject[@"data"]];
                              }
                              [self.authenColl1 reloadData];
                          }else{
                              
                              if (_index < _imgArr2.count) {
                                  
                                  [_imgArr2 replaceObjectAtIndex:_index withObject:_image];
                                  [_imgUrl2 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                              }else{
                                  
                                  [_imgArr2 addObject:_image];
                                  [_imgUrl2 addObject:resposeObject[@"data"]];
                              }
                              [self.authenColl2 reloadData];
                          }
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
        
        [BaseRequest Updateimg:UploadFile_URL parameters:@{@"file_name":@"verify"
                                                           }
              constructionBody:^(id<AFMultipartFormData> formData) {
                  [formData appendPartWithFileData:data name:@"verify" fileName:@"verify.jpg" mimeType:@"image/jpg"];
              } success:^(id resposeObject) {
                  
                  if ([resposeObject[@"code"] integerValue] == 200) {
                      
                      if (_isOne) {
                          
                          if (_index < _imgArr1.count) {
                              
                              [_imgArr1 replaceObjectAtIndex:_index withObject:_image];
                              [_imgUrl1 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                          }else{
                              
                              [_imgArr1 addObject:_image];
                              [_imgUrl1 addObject:resposeObject[@"data"]];
                          }
                          [self.authenColl1 reloadData];
                      }else{
                          
                          if (_index < _imgArr2.count) {
                              
                              [_imgArr2 replaceObjectAtIndex:_index withObject:_image];
                              [_imgUrl2 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                          }else{
                              
                              [_imgArr2 addObject:_image];
                              [_imgUrl2 addObject:resposeObject[@"data"]];
                          }
                          [self.authenColl2 reloadData];
                      }
                  }else{
                      
                      [self showContent:resposeObject[@"msg"]];
                  }
                  
                  
              } failure:^(NSError *error) {
                  
                  [self showContent:@"网络错误"];
              }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_authenColl1 reloadData];
        [_authenColl2 reloadData];
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.titleLabel.text = @"推荐信息";
    self.navBackgroundView.hidden = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                label.text = @"到访人数:";
                _numL = label;
                [self.view addSubview:_numL];
                break;
            }
            case 1:
            {
                label.text = @"置业目的:";
                _purposeL = label;
                [self.view addSubview:_purposeL];
                break;
            }
            case 2:
            {
                label.text = @"到访照片:";
                _visitL = label;
                [self.view addSubview:_visitL];
                break;
            }
            case 3:
            {
                label.text = @"确认单时间:";
                _confirmL = label;
                [self.view addSubview:_confirmL];
                break;
            }
            case 4:
            {
                label.text = @"推荐类型：";
                _recommendTypeL = label;
                [self.view addSubview:_recommendTypeL];
                break;
            }
            case 5:
            {
                label.text = @"备注：";
                _markL = label;
                [self.view addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0 ; i < 3; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _numBtn = btn;
                [self.view addSubview:_numBtn];
                break;
            }
            case 1:
            {
                _purposeBtn = btn;
                [self.view addSubview:_purposeBtn];
                break;
            }
            case 2:
            {
                _recommendTypeBtn = btn;
                if (self.consulDic && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
                    
                    _recommendTypeBtn.content.text = [NSString stringWithFormat:@"%@",self.consulDic[@"rule_type_tags"][0][@"tag_name"]];
                    _recommendTypeBtn->str = [NSString stringWithFormat:@"%@",self.consulDic[@"rule_type_tags"][0][@"tag_id"]];
                }else{
                    
                    
                }
                [self.view addSubview:_recommendTypeBtn];
                break;
            }
            default:
                break;
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(120 *SIZE, 91 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _authenColl1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl1.backgroundColor = [UIColor whiteColor];
    _authenColl1.delegate = self;
    _authenColl1.dataSource = self;
    
    [_authenColl1 registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [self.view addSubview:_authenColl1];
    
    _authenColl2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50 *SIZE, SCREEN_Width, 91 *SIZE) collectionViewLayout:_flowLayout];
    _authenColl2.backgroundColor = [UIColor whiteColor];
    _authenColl2.delegate = self;
    _authenColl2.dataSource = self;
    
    [_authenColl2 registerClass:[AuthenCollCell class] forCellWithReuseIdentifier:@"AuthenCollCell"];
    [self.view addSubview:_authenColl2];
    
    _markView = [[UITextView alloc] init];
    _markView.delegate = self;
//    _markView.contentInset = UIEdgeInsetsMake(10 *SIZE, 12 *SIZE, 12 *SIZE, 12 *SIZE);
    _markView.layer.borderWidth = SIZE;
//    _markView.layer.borderColor = YJBackColor.CGColor;
    _markView.layer.cornerRadius = 5*SIZE;
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.clipsToBounds = YES;
    [self.view addSubview:_markView];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markView addSubview:_placeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self.view).offset(21 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(self.view).offset(11 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_numBtn.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(self->_numBtn.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    if (self.consulDic.count && [self.consulDic[@"rule_type_tags"] isKindOfClass:[NSArray class]] && [self.consulDic[@"rule_type_tags"] count]) {
        
        [_recommendTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(10 *SIZE);
            make.top.equalTo(self->_purposeBtn.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
        
        [_recommendTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(80 *SIZE);
            make.top.equalTo(self->_purposeBtn.mas_bottom).offset(21 *SIZE);
            make.width.equalTo(@(258 *SIZE));
            make.height.equalTo(@(33 *SIZE));
        }];
        
        [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(10 *SIZE);
            make.top.equalTo(self->_recommendTypeBtn.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
    }else{
        
        _recommendTypeL.hidden = YES;
        _recommendTypeBtn.hidden = YES;
        [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.view).offset(10 *SIZE);
            make.top.equalTo(self->_purposeBtn.mas_bottom).offset(31 *SIZE);
            make.width.equalTo(@(70 *SIZE));
            make.height.equalTo(@(13 *SIZE));
        }];
    }
    
    [_authenColl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_visitL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
    }];
    
    [_confirmL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(_authenColl1.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_authenColl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0 *SIZE);
        make.top.equalTo(_confirmL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(_authenColl2.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(_authenColl2.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(270 *SIZE));
        make.height.equalTo(@(117 *SIZE));
    }];
}

@end
