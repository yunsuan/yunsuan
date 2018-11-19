//
//  CustomDetailTableCell4.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell4.h"

@interface CustomDetailTableCell4()
{
    
    NSMutableArray *_dataArr;
}
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CustomDetailTableCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addBtnBlock) {
        
        self.addBtnBlock();
    }
}

- (void)initUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 7, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28 *SIZE, 19 *SIZE, 80 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"需求标签";
    [self.contentView addSubview:label];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(308 *SIZE, 3 *SIZE, 35 *SIZE, 35 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(77 *SIZE, 30 *SIZE);
//    layout.minimumInteritemSpacing = 11 *SIZE;
//    layout.sectionInset = UIEdgeInsetsMake(0, 28 *SIZE, 0, 0);
//    
//    _tagView = [[TagView2 alloc] initWithFrame:CGRectMake(0, 49 *SIZE, SCREEN_Width, 30 *SIZE) DataSouce:@[] type:@"1" flowLayout:layout];
//    [self.contentView addSubview:_tagView];
//
//    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(49 *SIZE);
        make.right.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-39 *SIZE);
    }];
}
@end
