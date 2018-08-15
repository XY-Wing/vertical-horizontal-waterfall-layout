//
//  XYCustomLayout.h
//  CustomFlowLayout
//
//  Created by wing on 2018/8/14.
//  Copyright © 2018年 wing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCustomLayout;
@protocol XYCustomLayoutDelegate <NSObject>
/*
 竖直滚动时生效
 */
- (CGFloat)customLayout:(XYCustomLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
/*
 水平滚动时生效
 */
- (CGFloat)customLayout:(XYCustomLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XYCustomLayout : UICollectionViewLayout
@property(nonatomic,weak)id<XYCustomLayoutDelegate>delegate;
/*
 列数 竖直滚动时生效
 */
@property(nonatomic,assign)NSInteger columnCount;
/*
 行数 水平滚动时生效
 */
@property(nonatomic,assign)NSInteger rowCount;
/*
 item之间的间距。
 */
@property(nonatomic,assign)UIEdgeInsets itemEdgeInsets;
/*
 滚动方向
 */
@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirection;
@end
