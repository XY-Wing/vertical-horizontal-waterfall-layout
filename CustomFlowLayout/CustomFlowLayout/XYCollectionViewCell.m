//
//  XYCollectionViewCell.m
//  CustomFlowLayout
//
//  Created by wing on 2018/8/14.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYCollectionViewCell.h"
@interface XYCollectionViewCell()
@property(nonatomic,strong)UILabel *titleLab;
@end
@implementation XYCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGFloat  r = arc4random_uniform(255.0) / 255.0;
        CGFloat  g = arc4random_uniform(255.0) / 255.0;
        CGFloat  b = arc4random_uniform(255.0) / 255.0;
        self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        [self setupXYCollectionViewCellUI];
    }
    return self;
}
#pragma mark - 布局UI
- (void)setupXYCollectionViewCellUI
{
    self.titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark - 懒加载UI
- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
    }
    return _titleLab;
}
#pragma mark - setter
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}
@end
