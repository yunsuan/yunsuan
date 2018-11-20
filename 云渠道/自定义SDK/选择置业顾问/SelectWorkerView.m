//
//  SelectWorkerView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectWorkerView.h"

@implementation SelectWorkerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setAdvicerSelect:(NSInteger)advicerSelect{
    
    if (advicerSelect == 1) {
        
        _nameL.text = [NSString stringWithFormat:@"%@/%@/%@",self.dataArr[0][@"GSMC"],self.dataArr[0][@"RYXM"],self.dataArr[0][@"RYDH"]];
        _phoneL.text = [NSString stringWithFormat:@"联系电话：%@",self.dataArr[0][@"RYDH"]];
        self.ID = [NSString stringWithFormat:@"%@",self.dataArr[0][@"ID"]];
    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (btn.tag == 0) {
        
        WorkerPickView *view = [[WorkerPickView alloc] initWithFrame:self.bounds WithData:self.dataArr];
        WS(weakSelf);
        view.workerPickBlock = ^(NSString *GSMC, NSString *ID, NSString *RYBH, NSString *RYDH, NSString *RYXM, NSString *RYTP) {
            
            weakSelf.nameL.text = [NSString stringWithFormat:@"%@/%@/%@",GSMC,RYXM,RYDH];
            weakSelf.phoneL.text = [NSString stringWithFormat:@"联系电话：%@",RYDH];
            weakSelf.ID = [NSString stringWithFormat:@"%@",ID];
        };
        [self addSubview:view];
    }else{
        
        if (self.selectWorkerRecommendBlock) {
            
            self.selectWorkerRecommendBlock();
            [self removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    if ([touches.anyObject.view isKindOfClass:[self class]]) {
    
        [self removeFromSuperview];
//    }
}

- (void)initUI{
    
//    self.backgroundColor = [UIColor blackColor];
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    alphaView.userInteractionEnabled = YES;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(55 *SIZE, 206 *SIZE, 250 *SIZE, 227 *SIZE)];
    
    _whiteView.backgroundColor = CH_COLOR_white;
    [self addSubview:_whiteView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24 *SIZE, 250 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:14 *SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"该项目置业顾问";
    [_whiteView addSubview:label];
    
    _nameView = [[UIView alloc] initWithFrame:CGRectMake(25 *SIZE, 65 *SIZE, 200 *SIZE, 33 *SIZE)];
    _nameView.backgroundColor = COLOR(238, 238, 238, 1);
    [_whiteView addSubview:_nameView];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(8 *SIZE, 11 *SIZE, 160 *SIZE, 11 *SIZE)];
    _nameL.textColor = YJTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _nameL.text = @""
    [_nameView addSubview:_nameL];
    
    _dropImg = [[UIImageView alloc] initWithFrame:CGRectMake(185 *SIZE, 15 *SIZE, 8 *SIZE,  8 *SIZE)];
    _dropImg.image = [UIImage imageNamed:@"downarrow1"];
    [_nameView addSubview:_dropImg];
    
    _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nameBtn.frame = _nameView.bounds;
    _nameBtn.tag = 0;
    [_nameBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nameView addSubview:_nameBtn];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(32 *SIZE, 112 *SIZE, 250 *SIZE, 11 *SIZE)];
    _phoneL.textColor = YJTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    _phoneL.text = @"联系电话:";
    [_whiteView addSubview:_phoneL];
    
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(25 *SIZE, 164 *SIZE, 200 *SIZE, 37 *SIZE);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    _recommendBtn.tag = 1;
    [_recommendBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommendBtn setBackgroundColor:YJBlueBtnColor];
    [_whiteView addSubview:_recommendBtn];
}

@end
