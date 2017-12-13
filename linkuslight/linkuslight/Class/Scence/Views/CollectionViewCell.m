//
//  CollectionViewCell.m
//  linkuslight
//
//  Created by Aba on 17/11/5.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (retain, nonatomic) ScenceInfo *scenceInfo;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImgView;
@property (weak, nonatomic) IBOutlet UIImageView *scenceIconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)refreshWithBackground:(NSString*)background Icon:(NSString*)icon Title:(NSString*)title ScenceInfo:(ScenceInfo *)scence
{
    _scenceInfo = scence;
    _backgroundImgView.image = [UIImage imageNamed:background];
    _scenceIconView.image = [UIImage imageNamed:icon];
    _titleView.text = title;

}

@end
