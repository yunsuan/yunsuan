//
//  RecommendConfirmVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendConfirmVC.h"

#import "SinglePickView.h"
#import "DateChooseView.h"

#import "DropDownBtn.h"
#import "BorderTF.h"

#import "AuthenCollCell.h"
#import "CompleteSurveyCollCell.h"

@interface RecommendConfirmVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    
    NSMutableDictionary *_dataDic;
    NSMutableDictionary *_getDic;
    NSMutableDictionary *_configDic;
    NSMutableDictionary *_dic;
    NSMutableArray *_peopleArr;
    NSMutableArray *_dataArr;
    NSMutableArray *_labelArr;
    NSMutableArray *_moduleArr;
    
    NSInteger _index;
    NSMutableArray *_imgArr1;
    NSMutableArray *_imgUrl1;
    NSMutableArray *_imgArr2;
    NSMutableArray *_imgUrl2;
    UIImagePickerController *_imagePickerController;
    UIImage *_image;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *infoView;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) DropDownBtn *numBtn;

@property (nonatomic, strong) UILabel *purposeL;

@property (nonatomic, strong) DropDownBtn *purposeBtn;

@property (nonatomic, strong) UILabel *visitL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *authenColl1;
//
//@property (nonatomic, strong) UILabel *recommendTypeL;
//
//@property (nonatomic, strong) DropDownBtn *recommendTypeBtn;

@property (nonatomic, strong) UIView *needInfoView;

//@property (nonatomic, strong) UILabel *yearL;
//
//@property (nonatomic, strong) DropDownBtn *yearBtn;
//
//@property (nonatomic, strong) UILabel *professionL;
//
//@property (nonatomic, strong) DropDownBtn *professionBtn;
//
//@property (nonatomic, strong) UILabel *addressL;
//
//@property (nonatomic, strong) DropDownBtn *addressBtn;
//
//@property (nonatomic, strong) UILabel *propertyL;
//
//@property (nonatomic, strong) DropDownBtn *propertyBtn;
//
//@property (nonatomic, strong) UILabel *priceL;
//
//@property (nonatomic, strong) DropDownBtn *priceBtn;
//
//@property (nonatomic, strong) UILabel *areaL;
//
//@property (nonatomic, strong) DropDownBtn *areaBtn;
//
//@property (nonatomic, strong) UILabel *houseTypeL;
//
//@property (nonatomic, strong) DropDownBtn *houseTypeBtn;
//
//@property (nonatomic, strong) UILabel *decorateL;
//
//@property (nonatomic, strong) DropDownBtn *decorateBtn;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UITextView *markView;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSDateFormatter *formatter;

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
    [self RequestMethod];
}

- (void)initDataSource{
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"YYYY-MM-dd"];
    
    _getDic = [@{} mutableCopy];
    _configDic = [@{} mutableCopy];
    _dataArr = [@[] mutableCopy];
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
    
    [_configDic setObject:_dic[@"client_id"] forKey:@"client_id"];
    if (!_numBtn->str) {
        
        [self showContent:@"请选择到访人数"];
        return;
        
    }
    
    if (_numBtn->str) {
        
        [_configDic setObject:_numBtn->str forKey:@"visit_num"];
    }
    
    if (_purposeBtn->str) {
        
        [_configDic setObject:_purposeBtn->str forKey:@"buy_purpose"];
    }
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        NSDictionary *dic = _dataArr[i];
        switch ([dic[@"type"] integerValue]) {
                
            case 1:
            {
                BorderTF *tf = [_needInfoView viewWithTag:i];
                if (![self isEmpty:tf.textfield.text]) {
                    
                    [_getDic setObject:tf.textfield.text forKey:dic[@"column_name"]];
                }
                break;
            }
            case 2:
            {
                DropDownBtn *btn = _moduleArr[i];
                if (btn.content.text) {
                    
                    [_getDic setObject:btn.content.text forKey:dic[@"column_name"]];
                }
                break;
            }
            case 3:
            {
                break;
            }
            case 4:
            {
                DropDownBtn *btn = _moduleArr[i];
                if (btn.content.text) {
                    
                    [_getDic setObject:btn.content.text forKey:dic[@"column_name"]];
                }
                break;
            }
            default:
                break;
        }
    }
    
    if (_imgUrl1) {
        
        [_getDic setObject:[_imgUrl1 componentsJoinedByString:@","] forKey:@"visit_img_url"];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_getDic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    [_configDic setObject:jsonResult forKey:@"content"];
    
    [BaseRequest POST:ProjectClientNeedUpdate_URL parameters:_configDic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.recommendConfirmVCBlock) {
                
                self.recommendConfirmVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionTagNumBtn:(DropDownBtn *)btn{
    
    for (int i = 0; i < _dataArr.count; i++) {
        
        if (i == btn.tag) {
            
            if ([_dataArr[i][@"type"] integerValue] == 2) {
                
                NSMutableArray *tempArr = [@[] mutableCopy];
                for (int j = 0; j < [_dataArr[i][@"config"] count]; j++) {
                    
                    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:_dataArr[i][@"config"][j]];
                    [tempDic setObject:tempDic[@"config_name"] forKey:@"param"];
                    [tempDic setObject:tempDic[@"config_id"] forKey:@"id"];
                    [tempDic removeObjectForKey:@"config_id"];
                    [tempDic removeObjectForKey:@"config_name"];
                    [tempArr addObject:tempDic];
                }
                SinglePickView *view = [[SinglePickView alloc] initWithFrame:self.view.bounds WithData:tempArr];

                view.selectedBlock = ^(NSString *MC, NSString *ID) {
                    
                    btn.content.text = MC;
                    btn->str = [NSString stringWithFormat:@"%@",ID];
                    [self->_moduleArr replaceObjectAtIndex:i withObject:btn];
                };
                [self.view addSubview:view];
                break;
            }else{
                
                DateChooseView *view = [[DateChooseView alloc] initWithFrame:self.view.bounds];
                view.dateblock = ^(NSDate *date) {
                    
                    btn.content.text = [self->_formatter stringFromDate:date];
                    btn->str = [self->_formatter stringFromDate:date];
                    [self->_moduleArr replaceObjectAtIndex:i withObject:btn];
                };
                [self.view addSubview:view];
                break;
            }
        }
    }
}

- (void)ActionNeedBtn:(UIButton *)btn{
    
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
        default:
            break;
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectConfigColunm_URL parameters:@{@"project_id":_dic[@"project_id"]} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [self ReMasonryUI];
            [self InfoRequestMethod];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)InfoRequestMethod{
    
    [BaseRequest GET:AgentProjectClientNeedGet_URL parameters:@{@"client_id":_dic[@"client_id"]} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                NSData *JSONData = [resposeObject[@"data"][@"content"] dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err = nil;
                NSDictionary *parameters = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&err];
                _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
                [self SetData:parameters];
            }
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSDictionary *)data{
    
    _numBtn.content.text = [NSString stringWithFormat:@"%@人",_dataDic[@"visit_num"]];
    _numBtn->str = [NSString stringWithFormat:@"%@",_dataDic[@"visit_num"]];
    [_imgUrl1 addObject:data[@"visit_img_url"]];
    [_authenColl1 reloadData];
    for (int i = 0; i < _moduleArr.count; i++) {
        
        NSDictionary *dic = _dataArr[i];
        switch ([dic[@"type"] integerValue]) {
            case 1:
            {
                BorderTF *tf = _moduleArr[i];
                [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([dic[@"column_name"] isEqualToString:key]) {
                        
                        tf.textfield.text = [NSString stringWithFormat:@"%@",obj];
                        [_moduleArr replaceObjectAtIndex:i withObject:tf];
                    }
                }];
                
                break;
            }
            case 2:
            {
                DropDownBtn *tf = _moduleArr[i];
                [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([dic[@"column_name"] isEqualToString:key]) {
                        
                        tf.content.text = [NSString stringWithFormat:@"%@",obj];
                        for (int j = 0; j < [dic[@"config"] count]; j++) {
                            
                            NSDictionary *tempDic = dic[@"config"][j];
                            if ([tempDic[@"config_name"] isEqualToString:tf.content.text]) {
                                
                                tf->str = [NSString stringWithFormat:@"%@",tempDic[@"config_id"]];
                            }
                        }
                        [_moduleArr replaceObjectAtIndex:i withObject:tf];
                    }
                }];
                break;
            }
            case 3:
            {
                
                UICollectionView *coll = _moduleArr[i];
                
                break;
            }
            case 4:
            {
                DropDownBtn *tf = _moduleArr[i];
                [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([dic[@"column_name"] isEqualToString:key]) {
                        
                        tf.content.text = [NSString stringWithFormat:@"%@",obj];
                        tf->str = [NSString stringWithFormat:@"%@",obj];
                        [_moduleArr replaceObjectAtIndex:i withObject:tf];
                    }
                }];
                break;
            }
            default:
                break;
        }
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
        
        if (_imgUrl1.count) {
            
            if (indexPath.item < _imgUrl1.count) {
                
//                cell.imageView.image = _imgUrl1[indexPath.item];
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgUrl1[indexPath.item]]] placeholderImage:[UIImage imageNamed:@"uploadphotos"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                   
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
                          
                          if (_index < _imgArr1.count) {
                              
                              [_imgArr1 replaceObjectAtIndex:_index withObject:_image];
                              [_imgUrl1 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                          }else{
                              
                              [_imgArr1 addObject:_image];
                              [_imgUrl1 addObject:resposeObject[@"data"]];
                          }
                          [self.authenColl1 reloadData];
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
                      
                      if (_index < _imgArr1.count) {
                          
                          [_imgArr1 replaceObjectAtIndex:_index withObject:_image];
                          [_imgUrl1 replaceObjectAtIndex:_index withObject:resposeObject[@"data"]];
                      }else{
                          
                          [_imgArr1 addObject:_image];
                          [_imgUrl1 addObject:resposeObject[@"data"]];
                      }
                      [self.authenColl1 reloadData];
                  }else{
                      
                      [self showContent:resposeObject[@"msg"]];
                  }
                  
                  
              } failure:^(NSError *error) {
                  
                  [self showContent:@"网络错误"];
              }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_authenColl1 reloadData];
    }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initUI{
    
    self.titleLabel.text = @"完善信息";
    self.navBackgroundView.hidden = NO;
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = YJBackColor;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    _infoView = [[UIView alloc] init];
    _infoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_infoView];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                label.text = @"到访人数:";
                _numL = label;
                [_infoView addSubview:_numL];
                break;
            }
            case 1:
            {
                label.text = @"置业目的:";
                _purposeL = label;
                [_infoView addSubview:_purposeL];
                break;
            }
            case 2:
            {
                label.text = @"到访照片:";
                _visitL = label;
                [_infoView addSubview:_visitL];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0 ; i < 2; i++) {
        
        DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
        btn.tag = i;
        [btn addTarget:self action:@selector(ActionNeedBtn:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
            {
                _numBtn = btn;
                [_infoView addSubview:_numBtn];
                break;
            }
            case 1:
            {
                _purposeBtn = btn;
                [_infoView addSubview:_purposeBtn];
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
    [_infoView addSubview:_authenColl1];
    
    
    _needInfoView = [[UIView alloc] init];
    _needInfoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_needInfoView];
    
    _markView = [[UITextView alloc] init];
    _markView.delegate = self;
    _markView.layer.borderWidth = SIZE;
    _markView.layer.cornerRadius = 5*SIZE;
    _markView.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _markView.clipsToBounds = YES;
    [_needInfoView addSubview:_markView];
    
    _placeL = [[UILabel alloc] initWithFrame:CGRectMake(6 *SIZE, 7 *SIZE, 40 *SIZE, 11 *SIZE)];
    _placeL.textColor = YJContentLabColor;
    _placeL.font = [UIFont systemFontOfSize:12 *SIZE];
    _placeL.text = @"备注...";
    [_markView addSubview:_placeL];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _confirmBtn.frame = CGRectMake(0, SCREEN_Height - 47 *SIZE - TAB_BAR_MORE, SCREEN_Width, 47 *SIZE + TAB_BAR_MORE);
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
//    if (_dic.count) {
//
//        [_confirmBtn setTitle:@"推荐" forState:UIControlStateNormal];
//    }else{
//
        [_confirmBtn setTitle:@"保存" forState:UIControlStateNormal];
//    }
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_scrollView).offset(0);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_needInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(0);
        make.top.equalTo(_infoView.mas_bottom).offset(5 *SIZE);
        make.right.equalTo(_scrollView).offset(0);
        make.width.equalTo(@(SCREEN_Width));
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(_infoView).offset(21 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(_infoView).offset(11 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_purposeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_numBtn.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_purposeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(80 *SIZE);
        make.top.equalTo(self->_numBtn.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(258 *SIZE));
        make.height.equalTo(@(33 *SIZE));
    }];
    
    [_visitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(10 *SIZE);
        make.top.equalTo(self->_purposeBtn.mas_bottom).offset(31 *SIZE);
        make.width.equalTo(@(70 *SIZE));
        make.height.equalTo(@(13 *SIZE));
    }];
    
    [_authenColl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_infoView).offset(0 *SIZE);
        make.top.equalTo(_visitL.mas_bottom).offset(21 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(91 *SIZE));
        make.bottom.equalTo(_infoView.mas_bottom).offset(-20 *SIZE);
    }];
    
//    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(_needInfoView).offset(21 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(_needInfoView).offset(11 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_professionL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_yearBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_professionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_yearBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_professionBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_professionBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_addressBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_propertyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_addressBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_propertyBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
    
//    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_propertyBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_priceBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_priceBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_houseTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_areaBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_houseTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_areaBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
//
//    [_decorateL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(self->_houseTypeBtn.mas_bottom).offset(31 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_decorateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(self->_houseTypeBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(258 *SIZE));
//        make.height.equalTo(@(33 *SIZE));
//    }];
    
//    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(10 *SIZE);
//        make.top.equalTo(_decorateBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(70 *SIZE));
//        make.height.equalTo(@(13 *SIZE));
//    }];
//
//    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(_needInfoView).offset(80 *SIZE);
//        make.top.equalTo(_decorateBtn.mas_bottom).offset(21 *SIZE);
//        make.width.equalTo(@(270 *SIZE));
//        make.height.equalTo(@(117 *SIZE));
//        make.bottom.equalTo(_needInfoView.mas_bottom).offset(-20 *SIZE);
//    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_scrollView).offset(22 *SIZE);
        make.top.equalTo(_needInfoView.mas_bottom).offset(45 *SIZE);
        make.right.equalTo(_scrollView).offset(-22 *SIZE);
        make.height.equalTo(@(40 *SIZE));
        make.bottom.equalTo(_scrollView.mas_bottom).offset(-40 *SIZE);
    }];
}

- (void)ReMasonryUI{
    
    _labelArr = [@[] mutableCopy];
    _moduleArr = [@[] mutableCopy];
    for (int i = 0; i < _dataArr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.text = _dataArr[i][@"column_name"];
        label.adjustsFontSizeToFitWidth = YES;
        [_labelArr addObject:label];
        
        NSDictionary *dic = _dataArr[i];
        switch ([dic[@"type"] integerValue]) {
            case 1:
            {
                BorderTF *tf = [[BorderTF alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                tf.tag = i;
                [_moduleArr addObject:tf];
                break;
            }
            case 2:
            {
                DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                btn.tag = i;
                [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_moduleArr addObject:btn];
                break;
            }
            case 3:
            {
                
                UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
                flowLayout = flowLayout;
                flowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 20 *SIZE);
                flowLayout.minimumLineSpacing = 5 *SIZE;
                flowLayout.minimumInteritemSpacing = 0;
                
                UICollectionView *coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 240 *SIZE, 20 *SIZE) collectionViewLayout:flowLayout];
                coll.backgroundColor = [UIColor whiteColor];
                coll.bounces = NO;
                coll.delegate = self;
                coll.dataSource = self;
                [coll registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
                [_moduleArr addObject:coll];
                
                break;
            }
            case 4:
            {
                DropDownBtn *btn = [[DropDownBtn alloc] initWithFrame:CGRectMake(80 *SIZE, 25 *SIZE + i * 55 *SIZE, 258 *SIZE, 33 *SIZE)];
                btn.tag = i;
                [btn addTarget:self action:@selector(ActionTagNumBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_moduleArr addObject:btn];
                break;
            }
            default:
                break;
        }
    }
    
    for (int i = 0; i < _moduleArr.count; i++) {
        
        [_needInfoView addSubview:_labelArr[i]];
        [_needInfoView addSubview:_moduleArr[i]];
        
        if (i == 0) {
            
            [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_needInfoView).offset(10 *SIZE);
                make.top.equalTo(_needInfoView).offset(21 *SIZE);
                make.width.equalTo(@(70 *SIZE));
                make.height.equalTo(@(13 *SIZE));
            }];
            
            [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(_needInfoView).offset(80 *SIZE);
                make.top.equalTo(_needInfoView).offset(11 *SIZE);
                make.width.equalTo(@(258 *SIZE));
                make.height.equalTo(@(33 *SIZE));
            }];
        }else{
    
            NSDictionary *dic = _dataArr[i - 1];
            switch ([dic[@"type"] integerValue]) {
                
                case 1:
                {
                    BorderTF *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 2:
                {
                    DropDownBtn *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_infoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_infoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
                case 3:
                {
                    
                    DropDownBtn *tf = _moduleArr[i - 1];
                    UICollectionView *coll = _moduleArr[i];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                            make.bottom.equalTo(_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.mas_equalTo(coll.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
                        }];
                    }

                    break;
                }
                case 4:
                {
                    DropDownBtn *tf = _moduleArr[i - 1];
                    [_labelArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        make.left.equalTo(_needInfoView).offset(10 *SIZE);
                        make.top.equalTo(tf.mas_bottom).offset(31 *SIZE);
                        make.width.equalTo(@(70 *SIZE));
                        make.height.equalTo(@(13 *SIZE));
                    }];
                    
                    if (i == _moduleArr.count - 1) {
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                            make.bottom.equalTo(_needInfoView).offset(-21 *SIZE);
                        }];
                    }else{
                        
                        [_moduleArr[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                            
                            make.left.equalTo(_needInfoView).offset(80 *SIZE);
                            make.top.equalTo(tf.mas_bottom).offset(21 *SIZE);
                            make.width.equalTo(@(258 *SIZE));
                            make.height.equalTo(@(33 *SIZE));
                        }];
                    }
                    
                    break;
                }
            }
        }
    }
}

@end
