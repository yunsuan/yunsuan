//
//  ContractDetailMainContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractDetailMainContractVC.h"

#import "MainContractCell.h"

@interface ContractDetailMainContractVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    NSMutableArray *_dataArr;
    UIImagePickerController *_imagePickerController; /**< 相册拾取器 */
}

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ContractDetailMainContractVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        _dataArr = [NSMutableArray arrayWithArray:dataArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.isEdit) {
        
        return _dataArr.count + 1;
    }else{
     
        return _dataArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainContractCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainContractCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MainContractCell alloc] initWithFrame:CGRectMake(0, 0, 110 *SIZE, 100 *SIZE)];
    }
    
    cell.tag = indexPath.item;
    
    cell.mainContractCellBlock = ^(NSInteger index) {
        
        [BaseRequest GET:ContractTakeDealImgDel_URL parameters:@{@"img_id":_dataArr[index][@"img_id"]} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [_dataArr removeObjectAtIndex:index];
                [collectionView reloadData];
                if (self.contractDetailMainContractVCBlock) {
                    
                    self.contractDetailMainContractVCBlock();
                }
            }
        } failure:^(NSError *error) {
           
            [self showContent:@"网络错误"];
        }];
    };
    
    if (indexPath.item < _dataArr.count) {
        
//        cell.deleteBtn.hidden = NO;
        [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (error) {
                
                cell.bigImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
        
        if (self.isEdit) {
            
            cell.deleteBtn.hidden = NO;
        }else{
            
            cell.deleteBtn.hidden = YES;
        }
    }else{
        
        cell.deleteBtn.hidden = YES;
        cell.bigImg.image = [UIImage imageNamed:@"uploadphotos"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item < _dataArr.count) {
        
        
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传合同图片"
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
                                                       @"file_name":@"img"
                                                       }
          constructionBody:^(id<AFMultipartFormData> formData) {
              [formData appendPartWithFileData:data name:@"img" fileName:@"img.jpg" mimeType:@"image/jpg"];
          } success:^(id resposeObject) {
              
              if ([resposeObject[@"code"] integerValue] == 200) {
                  
                  NSDictionary *dic = @{@"img_url":resposeObject[@"data"],@"deal_id":self.dealId};
                  [BaseRequest GET:ContractTakeDealImgAdd_URL parameters:dic success:^(id resposeObject) {
                      
                      if ([resposeObject[@"code"] integerValue] == 200) {
                          
                          [_dataArr addObject:@{@"img_url":dic[@"img_url"],@"img_id":resposeObject[@"data"]}];
                          [_coll reloadData];
                          if (self.contractDetailMainContractVCBlock) {
                              
                              self.contractDetailMainContractVCBlock();
                          }
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

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"主体合同";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsMake(5 *SIZE, 10 *SIZE, 0, 10 *SIZE);
    _flowLayout.minimumInteritemSpacing = 5 *SIZE;
    _flowLayout.minimumLineSpacing = 10 *SIZE;
    _flowLayout.itemSize = CGSizeMake(110 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = YJBackColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[MainContractCell class] forCellWithReuseIdentifier:@"MainContractCell"];
    [self.view addSubview:_coll];
}

@end
