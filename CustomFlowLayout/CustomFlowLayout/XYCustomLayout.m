//
//  XYCustomLayout.m
//  CustomFlowLayout
//
//  Created by wing on 2018/8/14.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "XYCustomLayout.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface XYCustomLayout()
@property(nonatomic,strong)NSMutableArray <UICollectionViewLayoutAttributes *>*attributesArr;
@property(nonatomic,strong)NSMutableArray *maxPositionArr;
@end

@implementation XYCustomLayout
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributesArr
{
    if (!_attributesArr) {
        _attributesArr = @[].mutableCopy;
    }
    return _attributesArr;
}
- (NSMutableArray *)maxPositionArr
{
    if (!_maxPositionArr) {
        _maxPositionArr = @[].mutableCopy;
    }
    return _maxPositionArr;
}
- (instancetype)init
{
    if (self = [super init]) {
        //默认配置
        _columnCount = 2;
        _rowCount = 3;
        _itemEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.attributesArr removeAllObjects];
    [self.maxPositionArr removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    if (_scrollDirection == UICollectionViewScrollDirectionVertical) {
        for (int i = 0; i < _columnCount; i ++) {
            [_maxPositionArr addObject:@0];
        }
    } else {
        for (int i = 0; i < _rowCount; i ++) {
            [_maxPositionArr addObject:@0];
        }
    }
    
    for (int i = 0; i < count; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributesArr addObject:attr];
    }
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (_scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat h = [_delegate customLayout:self heightForItemAtIndexPath:indexPath];
        CGFloat w = (self.collectionView.frame.size.width - _itemEdgeInsets.left - _itemEdgeInsets.right - (_columnCount - 1) * _itemEdgeInsets.left) / _columnCount;
        CGFloat minY = [_maxPositionArr.firstObject floatValue];
        NSInteger minYIndex = 0;
        for (int i = 0; i < _columnCount; i ++) {
            CGFloat y = [_maxPositionArr[i] floatValue];
            if (y < minY) {
                minY = y;
                minYIndex = i;
            }
        }
        CGFloat x = _itemEdgeInsets.left + (w + _itemEdgeInsets.left) * minYIndex;
        CGFloat y = minY + _itemEdgeInsets.top;
        attr.frame = CGRectMake(x, y, w, h);
        _maxPositionArr[minYIndex] = @(CGRectGetMaxY(attr.frame));
    } else {
        CGFloat w = [_delegate customLayout:self widthForItemAtIndexPath:indexPath];
        CGFloat h = (self.collectionView.frame.size.height - _itemEdgeInsets.top - _itemEdgeInsets.bottom - (_rowCount - 1) * _itemEdgeInsets.bottom) / _rowCount;
        CGFloat minX = [_maxPositionArr.firstObject floatValue];
        NSInteger minRowIndex = 0;
        for (int i = 0; i < _maxPositionArr.count; i ++) {
            CGFloat x = [_maxPositionArr[i] floatValue];
            if (x < minX) {
                minX = x;
                minRowIndex = i;
            }
        }
        CGFloat x = minX + _itemEdgeInsets.left;
        CGFloat y = _itemEdgeInsets.top + (_itemEdgeInsets.top + h) * minRowIndex;
        attr.frame = CGRectMake(x, y, w, h);
        _maxPositionArr[minRowIndex] = @(CGRectGetMaxX(attr.frame));
    }
    
    return attr;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArr;
}
- (CGSize)collectionViewContentSize
{
    CGFloat maxValue = [self xy_fecthMaxValue];
    if (_scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(self.collectionView.frame.size.width, maxValue + _itemEdgeInsets.bottom);
    } else {
        return CGSizeMake(maxValue + _itemEdgeInsets.right, self.collectionView.frame.size.height);
    }
}
- (CGFloat)xy_fecthMaxValue
{
    CGFloat maxValue = [_maxPositionArr.firstObject floatValue];
    for (int i = 0; i < _maxPositionArr.count; i ++) {
        CGFloat value = [_maxPositionArr[i] floatValue];
        if (value > maxValue) {
            maxValue = value;
        }
    }
    return maxValue;
}
@end
