//
//  CompleteSurveyCollCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteSurveyCollCell2Block)(NSString *str);

@interface CompleteSurveyCollCell2 : UICollectionViewCell

@property (nonatomic, copy) CompleteSurveyCollCell2Block completeSurveyCollCell2Block;

@property (nonatomic, strong) UITextView *contentTV;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UILabel *contentL;

@end
