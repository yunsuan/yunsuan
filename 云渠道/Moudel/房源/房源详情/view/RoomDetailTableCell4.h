//
//  RoomDetailTableCell4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoomDetailTableCell4Delegate <NSObject>

- (void)Cell4collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface RoomDetailTableCell4 : UITableViewCell

@property (nonatomic, strong) UICollectionView *POIColl;

@property (nonatomic, weak) id<RoomDetailTableCell4Delegate> delegate;

@end
