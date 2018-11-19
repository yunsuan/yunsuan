//
//  RoomAgencyAddProtocolCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"
#import "BorderTF.h"
typedef void(^ChangeBlock)(void);

@interface RoomAgencyAddProtocolCell3 : UITableViewCell

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTF *codeTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTF *addressTF;

@property (nonatomic, strong) UITextView *addressTV;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) BorderTF *propertyTF;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) BorderTF *roomNumTF;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) BorderTF *houseTypeTF;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) BorderTF *areaTF;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) BorderTF *certNumTF;

@property (nonatomic, strong) UILabel *homelandL;

@property (nonatomic, strong) BorderTF *homelandTF;

@property (nonatomic, strong) UIButton *changeRoom;

@property (nonatomic, copy) ChangeBlock changeblock;

-(void)setDataByDic:(NSDictionary *)dic;

@end
