//
//  MyShopRoomDetailVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/26.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopRoomDetailVC.h"


#import "YBImageBrowser.h"

#import "BuildingAlbumCollCell.h"

@interface MyShopRoomDetailVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,YBImageBrowserDelegate>
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

@property (nonatomic, strong) UIButton *recommendBtn;

@end

@implementation MyShopRoomDetailVC

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
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetHouseDetail_URL parameters:@{@"house_id":_house_id} success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            [_dataDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ([obj isKindOfClass:[NSNull class]]) {
                    
                    [_dataDic setValue:@"" forKey:key];
                }
            }];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
        [self showContent:@"网络错误"];
    }];
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    
}

- (void)ActionImgBtn:(UIButton *)btn{
    
//    NSMutableArray *tempArr = [NSMutableArray array];
//
//    NSMutableArray *tempArr1 = [NSMutableArray array];
//    for (NSDictionary *dic in _imgArr) {
//
//        for (NSDictionary *subDic in dic[@"list"]) {
//
//            [tempArr1 addObject:subDic];
//        }
//    }
//    [tempArr1 enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        YBImageBrowserModel *model = [YBImageBrowserModel new];
//        model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
//        if ([obj[@"img_url_3d"] length]) {
//
//            model.third_URL = [NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url_3d"]];
//        }
//
//        [tempArr addObject:model];
//    }];
//
//    [_imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:obj];
//        [tempDic setObject:obj[@"type"] forKey:@"name"];
//
//        [tempDic setObject:obj[@"list"] forKey:@"data"];
//        [_imgArr replaceObjectAtIndex:idx withObject:tempDic];
//
//    }];
//
//     YBImageBrowserModel *YBmodel = tempArr[num];
//    if (YBmodel.third_URL.length) {
//
//        BuildingAlbumVC *nextVC = [[BuildingAlbumVC alloc] init];
//        nextVC.weburl = YBmodel.third_URL;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    }else{
//    YBImageBrowser *browser = [YBImageBrowser new];
//    browser.delegate = self;
//    browser.dataArray = tempArr;
//    browser.albumArr = _imgArr;
//    browser.infoid = _info_id;
//    browser.currentIndex = num;
//    [browser show];
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width) + 1;
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if ([_imgArr[i][@"list"] count]) {
            
            if (([_imgArr[i][@"list"] count]  + count)< _num) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }else{
            
            if ((1  + count)< _num) {
                
                count = count + 1;
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }
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
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    [_recommendBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"添加到到我的店铺" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.view addSubview:_recommendBtn];
}
@end
