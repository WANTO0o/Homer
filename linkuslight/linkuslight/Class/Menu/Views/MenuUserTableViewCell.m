//
//  MenuUserTableViewCell.m
//  linkuslight
//
//  Created by Aba on 17/10/8.
//  Copyright © 2017年 linkustek. All rights reserved.
//
#import "UIImage+RTTint.h"
#import "UIImage+ImageScaleSize.h"

#import "MenuUserTableViewCell.h"

@interface MenuUserTableViewCell()

@property (nonatomic,strong) UIImageView* headImageView;
@property (nonatomic,strong) UILabel* titleLable;

@end

@implementation MenuUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"menuUserTableViewCell";
    
    MenuUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuUserTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;
}

- (void)drawCellWithUserInfo:(LOLUser *)user
{
    //_headImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(70, 60, 110, 110))];
    CGSize cut = self.contentView.bounds.size;
    _headImageView = [[UIImageView alloc] initWithFrame:(CGRectMake((cut.width-30)/2-70, 60, 110, 110))];

    UIImage *img = [[[UIImage alloc] init] imageWithCornerRadius:8.0];
    _headImageView.image = img;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    _headImageView.layer.borderWidth = 1.0;
    _headImageView.backgroundColor = [UIColor whiteColor];
    [_headImageView.layer setCornerRadius:55.0];
    [self.contentView addSubview:_headImageView];
    
    //_titleLable = [[UILabel alloc] initWithFrame:(CGRectMake(105, 190, 120, 30))];
    _titleLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, 180, cut.width-55, 30))];

    if (!user || [user isKindOfClass:[NSNull null]]) {
        _titleLable.text = @"未登录";
    } else {
        
        UIImage *img = [[UIImage imageNamed:@"addition_bg_morning"] imageWithCornerRadius:8.0];
        _headImageView.image = img;
        _titleLable.text = user.userName;
    }
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLable];

}

- (void)refreshWithUserInfo:(LOLUser *)user
{
    [self drawCellWithUserInfo:user];
}


@end
