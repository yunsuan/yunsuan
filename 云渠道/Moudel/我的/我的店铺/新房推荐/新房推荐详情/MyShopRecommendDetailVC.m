//
//  MyShopRecommendDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopRecommendDetailVC.h"

#import "MyShopVC.h"

#import "YBImageBrowser.h"

#import "BuildingAlbumCollCell.h"

#import "BorderTF.h"

@interface MyShopRecommendDetailVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,YBImageBrowserDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    
    NSInteger _num;
    NSInteger _nowNum;
    NSInteger _total;
    
    NSString *_house_id;
    NSString *_info_id;
    
    NSMutableDictionary *_dataDic;
    
    NSMutableArray *_imgArr;
    NSMutableArray *_allArr;
}

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) YBImageBrowser *browser;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *stateL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UILabel *commentL;

@property (nonatomic, strong) UITextView *commentTV;

@property (nonatomic, strong) UILabel *commentPlaceL;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation MyShopRecommendDetailVC

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id
{
    self = [super init];
    if (self) {
        
        _info_id = info_id;
        _house_id = house_id;
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
    
    _dataDic = [@{} mutableCopy];
    
    _imgArr = [@[] mutableCopy];
    _allArr = [@[] mutableCopy];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetHouseDetail_URL parameters:@{@"house_id":_house_id,@"config_id":self.config_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setValue:@"" forKey:key];
                }
            }];
            
            self.projectName = _dataDic[@"project_name"];
            _projectL.text = [NSString stringWithFormat:@"所属项目：%@",self.projectName];
            
            _propertyL.text = _dataDic[@"property_type"];
            _attentL.text = [NSString stringWithFormat:@"关注：%@",_dataDic[@"collect_num"]];
            _seeL.text = [NSString stringWithFormat:@"浏览：%@",_dataDic[@"browse_num"]];
            
            _roomNumL.text = [NSString stringWithFormat:@"房号：%@%@%@",_dataDic[@"build_name"],[_dataDic[@"unit_name"] length]?[NSString stringWithFormat:@"%@",_dataDic[@"unit_name"]]:@"",_dataDic[@"house_name"]];
            _priceL.text = [NSString stringWithFormat:@"价格：%@万",_dataDic[@"total_price"]];
            _areaL.text = [NSString stringWithFormat:@"面积：%@㎡",_dataDic[@"build_size"]];
            _stateL.text = [_dataDic[@"state"] integerValue] == 1?@"未售":@"已售";
            
            _commentTV.text = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"comment"]];
            _titleTF.textfield.text = [NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"title"]];
            
            if ([_dataDic[@"recommend_house_info"][@"recommend_id"] integerValue] != 0) {
                           
                self.cancelBtn.hidden = NO;
                self.recommendBtn.frame = CGRectMake(120 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 240 *SIZE, 40 *SIZE + TAB_BAR_MORE);
                [self.recommendBtn setTitle:@"保  存" forState:UIControlStateNormal];
                _commentPlaceL.hidden = YES;
            }
            
            if ([_dataDic[@"imgInfo"][@"51"] count]) {
                           
                [_imgArr addObject:@{@"type":@"户型图",@"list":_dataDic[@"imgInfo"][@"51"]}];
            }
            if ([_dataDic[@"imgInfo"][@"52"] count]) {
                           
                [_imgArr addObject:@{@"type":@"3D图",@"list":_dataDic[@"imgInfo"][@"52"]}];
            }
            if ([_dataDic[@"imgInfo"][@"53"] count]) {
                           
                [_imgArr addObject:@{@"type":@"效果图",@"list":_dataDic[@"imgInfo"][@"53"]}];
            }
            if ([_dataDic[@"imgInfo"][@"54"] count]) {
                           
                [_imgArr addObject:@{@"type":@"平面图",@"list":_dataDic[@"imgInfo"][@"54"]}];
            }
            if ([_dataDic[@"imgInfo"][@"55"] count]) {
                           
                [_imgArr addObject:@{@"type":@"实景图",@"list":_dataDic[@"imgInfo"][@"55"]}];
            }
            [self setImgArr:_imgArr];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if (!_titleTF.textfield.text.length) {
        
        [self showContent:@"请输入推荐标题"];
        return;
    }
    if (!_commentTV.text.length) {
        
        [self showContent:@"请输入推荐理由"];
        return;
    }
    if (![_dataDic count]) {
        
        [self showContent:@"未找到房间信息"];
        return;
    }
    _recommendBtn.userInteractionEnabled = NO;
    [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"recommend_id"]],@"house_id":_house_id,@"title":_titleTF.textfield.text,@"comment":_commentTV.text} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            [self showContent:@"保存成功"];
            if (self.myShopRecommendDetailVCBlock) {
                
                self.myShopRecommendDetailVCBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[MyShopVC class]]) {
                        
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            });
        }else{
            
            _recommendBtn.userInteractionEnabled = YES;
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        _recommendBtn.userInteractionEnabled = YES;
        [self showContent:@"网络错误"];
    }];
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    
    if (!imgArr.count) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_scrollView.frame];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.image = [UIImage imageNamed:@"default_3"];
        img.clipsToBounds = YES;
        [self.view addSubview:img];
    }
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    for ( int i = 0; i < imgArr.count; i++) {
        
        if ([imgArr[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:imgArr[i]];
            
            if ([tempDic[@"list"] count]) {
                for (int j = 0; j < [tempDic[@"list"] count]; j++) {
                    
                    _total = _total + 1;
                    [_allArr addObject:tempDic[@"list"][j]];
                }
            }else{
                
                _total += 1;
                [_allArr addObject:@{@"img_url":@"default_3"}];
            }
        }
    }
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _total, _scrollView.frame.size.height)];
    
    for (int i = 0; i < _total; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, _scrollView.frame.size.height)];
        img.backgroundColor = YJTitleLabColor;
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn:)];
        [img addGestureRecognizer:tap];
        img.userInteractionEnabled = YES;
        [_scrollView addSubview:img];
        
        if ([_allArr[i][@"img_url"] isEqualToString:@"default_3"]) {
            
            img.image = [UIImage imageNamed:@"default_3"];
        }else{
            
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_allArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    img.image = [UIImage imageNamed:@"default_3"];
                }
            }];
            if ([_allArr[i][@"img_url_3d"] length]) {
                
                UIImageView *img2 = [[UIImageView alloc] init];
                img2.bounds = CGRectMake(0, 0, 60 *SIZE, 60 *SIZE);
                img2.center = _scrollView.center;
                img2.image = [UIImage imageNamed:@"3D"];
                [img addSubview:img2];
            }
        }
        
    }
    [_imgColl reloadData];
    [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    
}


- (void)ActionImgBtn:(UIButton *)btn{
    
    NSMutableArray *tempArr = [NSMutableArray array];

    NSMutableArray *tempArr1 = [NSMutableArray array];
    for (NSDictionary *dic in _imgArr) {

        for (NSDictionary *subDic in dic[@"list"]) {

            [tempArr1 addObject:subDic];
        }
    }
    [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        YBImageBrowserModel *model = [YBImageBrowserModel new];
        model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
        if ([obj[@"img_url_3d"] length]) {

            model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
        }

        [tempArr addObject:model];
    }];

    [_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
        [tempDic setObject:obj[@"type"] forKey:@"name"];

        [tempDic setObject:obj[@"list"] forKey:@"data"];
        [_imgArr replaceObjectAtIndex:idx withObject:tempDic];

    }];

     YBImageBrowserModel *YBmodel = tempArr[_num];
    if (YBmodel.third_URL.length) {

        BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
        nextVC.weburl = YBmodel.third_URL;
        [self.navigationController pushViewController:nextVC animated:YES];
    }else{
        
        YBImageBrowser *browser = [YBImageBrowser new];
        browser.delegate = self;
        browser.dataArray = tempArr;
        browser.albumArr = _imgArr;
        browser.infoid = _info_id;
        browser.currentIndex = _num;
        [browser show];
    }
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    [self alertControllerWithNsstring:@"放弃推荐" And:@"该操作将会把该房间从我的店铺移除，是否继续？" WithCancelBlack:^{
        
    } WithDefaultBlack:^{
        
        if (![_dataDic count]) {
            
            [self showContent:@"未找到房间信息"];
            return;
        }
        [BaseRequest POST:ProjectUpdateRecommendHouse_URL parameters:@{@"recommend_id":[NSString stringWithFormat:@"%@",_dataDic[@"recommend_house_info"][@"recommend_id"]],@"house_id":_house_id,@"is_recommend":@"0"} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                if (self.myShopRecommendDetailVCBlock) {
                    
                    self.myShopRecommendDetailVCBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
        }];
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width);
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if ([_imgArr[i][@"list"] count]) {
            
            if (([_imgArr[i][@"list"] count]  + count)< _num + 1) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }else{
            
            if ((1  + count) < _num + 1) {
                
                count = count + 1;
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }
    }
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        
        _commentPlaceL.hidden = YES;
    }else{
        
        _commentPlaceL.hidden = NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"type"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            if ([_imgArr[i][@"list"] count]) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                count = count + 1;
            }
        }
    }
    [_scrollView setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
    
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"房间详情";

    
    self.view.backgroundColor = CLWhiteColor;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, 202.5 *SIZE)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE)];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.2;
    [self.view addSubview:alphaView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 17 *SIZE;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE + NAVIGATION_BAR_HEIGHT, SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = [UIColor clearColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    
    [_imgColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.view addSubview:_imgColl];
    
    _roomNumL = [[UILabel alloc] init];
    _roomNumL.textColor = YJTitleLabColor;
//    _roomNumL.adjustsFontSizeToFitWidth = YES;
    _roomNumL.font = [UIFont systemFontOfSize:11 *SIZE];
    _roomNumL.text = @"房号：";
    [self.view addSubview:_roomNumL];
    
    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = CLWhiteColor;
//    _propertyL.adjustsFontSizeToFitWidth = YES;
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.backgroundColor = YJBlueBtnColor;
    _propertyL.layer.cornerRadius = 2 *SIZE;
    _propertyL.clipsToBounds = YES;
    _propertyL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.view addSubview:_propertyL];
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJTitleLabColor;
//    _priceL.adjustsFontSizeToFitWidth = YES;
    _priceL.font = [UIFont systemFontOfSize:11 *SIZE];
    _priceL.text = @"价格：";
    [self.view addSubview:_priceL];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = YJTitleLabColor;
//    _attentL.adjustsFontSizeToFitWidth = YES;
    _attentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _attentL.text = @"关注：";
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_attentL];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJTitleLabColor;
//    _areaL.adjustsFontSizeToFitWidth = YES;
    _areaL.font = [UIFont systemFontOfSize:11 *SIZE];
    _areaL.text = @"面积：";
    [self.view addSubview:_areaL];
    
    _seeL = [[UILabel alloc] init];
    _seeL.textColor = YJTitleLabColor;
//    _seeL.adjustsFontSizeToFitWidth = YES;
    _seeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _seeL.text = @"浏览：";
    _seeL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_seeL];
    
    _projectL = [[UILabel alloc] init];
    _projectL.textColor = YJTitleLabColor;
//    _projectL.adjustsFontSizeToFitWidth = YES;
    _projectL.font = [UIFont systemFontOfSize:11 *SIZE];
    _projectL.text = [NSString stringWithFormat:@"所属项目："];
    [self.view addSubview:_projectL];
    
    _stateL = [[UILabel alloc] init];
    _stateL.textColor = YJTitleLabColor;
//    _projectL.adjustsFontSizeToFitWidth = YES;
    _stateL.textAlignment = NSTextAlignmentRight;
    _stateL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.view addSubview:_stateL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.adjustsFontSizeToFitWidth = YES;
    _titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    _titleL.text = @"推荐标题：";
    [self.view addSubview:_titleL];
    
    _commentL = [[UILabel alloc] init];
    _commentL.textColor = YJTitleLabColor;
    _commentL.adjustsFontSizeToFitWidth = YES;
    _commentL.text = @"推荐理由：";
    _commentL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.view addSubview:_commentL];
    
    _titleTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
    _titleTF.backgroundColor = CLWhiteColor;
    _titleTF.textfield.delegate = self;
    _titleTF.textfield.placeholder = @"特价房源、品牌开发商等";
    _titleTF.textfield.textColor = YJTitleLabColor;
    _titleTF.textfield.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.view addSubview:_titleTF];
    
    _commentTV = [[UITextView alloc] init];
    _commentTV.clipsToBounds = YES;
    _commentTV.layer.cornerRadius = 5*SIZE;
    _commentTV.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
    _commentTV.layer.borderWidth = 1*SIZE;
    _commentTV.delegate = self;
    _commentTV.textColor = YJTitleLabColor;
    [self.view addSubview:_commentTV];
    
    _commentPlaceL = [[UILabel alloc] initWithFrame:CGRectMake(5 *SIZE, 8 *SIZE, 200 *SIZE, 13 *SIZE)];
    _commentPlaceL.textColor = YJ170Color;
    _commentPlaceL.text = @"室内明亮、户型方正等";
    _commentPlaceL.font = [UIFont systemFontOfSize:11 *SIZE];
    [_commentTV addSubview:_commentPlaceL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 360 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"推  荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_recommendBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0 *SIZE, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, 120 *SIZE, 40 *SIZE + TAB_BAR_MORE);
    [_cancelBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTitle:@"取消推荐" forState:UIControlStateNormal];
    [_cancelBtn setBackgroundColor:YJ170Color];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    self.cancelBtn.hidden = YES;
    [self.view addSubview:_cancelBtn];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self.view).offset(212.5 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 *SIZE);
        make.top.equalTo(self.view).offset(212.5 *SIZE + NAVIGATION_BAR_HEIGHT);
        make.width.mas_equalTo(60 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_roomNumL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 *SIZE);
        make.top.equalTo(self->_roomNumL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 *SIZE);
        make.top.equalTo(self->_priceL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_projectL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(240 *SIZE);
    }];
    
    [_stateL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-10 *SIZE);
        make.top.equalTo(self->_areaL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(self->_projectL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(33 *SIZE);
    }];
    
    [_commentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(10 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_commentTV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(80 *SIZE);
        make.top.equalTo(self->_titleTF.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(258 *SIZE);
        make.height.mas_equalTo(70 *SIZE);
    }];
}

@end
