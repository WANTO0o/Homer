//
//  CollectionViewCell.h
//  linkuslight
//
//  Created by Aba on 17/11/5.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeviceInfo.h"

@class CollectionViewCell;

@protocol CollectionViewCellDelegate

- (void)didCellClicked:(CollectionViewCell*)sender;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,retain) id<CollectionViewCellDelegate> Delegate;

//+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)refreshWithBackground:(NSString*)background Icon:(NSString*)icon Title:(NSString*)title ScenceInfo:(ScenceInfo *)scence;

@end
