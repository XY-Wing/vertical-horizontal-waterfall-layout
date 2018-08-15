//
//  ViewController.m
//  CustomFlowLayout
//
//  Created by wing on 2018/8/14.
//  Copyright © 2018年 wing. All rights reserved.
//

#import "ViewController.h"
#import "XYCustomLayout.h"
#import "XYCollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,XYCustomLayoutDelegate>
@property(nonatomic,strong)UICollectionView *clv;
@end

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kNavigationTotalH ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.f)
@implementation ViewController

- (UICollectionView *)clv
{
    if (!_clv) {
        
        XYCustomLayout *layout = [[XYCustomLayout alloc] init];
        layout.delegate = self;
        layout.columnCount = 3;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _clv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationTotalH, kScreenW, kScreenH - kNavigationTotalH) collectionViewLayout:layout];
        _clv.backgroundColor = [UIColor whiteColor];
        [_clv registerClass:[XYCollectionViewCell class] forCellWithReuseIdentifier:@"XYCollectionViewCell"];
        
        _clv.delegate = self;
        _clv.dataSource = self;
    }
    return _clv;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.clv];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)customLayout:(XYCustomLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random_uniform(150) + 100;
}
- (CGFloat)customLayout:(XYCustomLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random_uniform(150) + 100;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYCollectionViewCell" forIndexPath:indexPath];
    cell.titleStr = [NSString stringWithFormat:@"%zd",indexPath.item];
    return cell;
}
- (IBAction)updateLayout:(UIBarButtonItem *)sender
{
    XYCustomLayout *layout = (XYCustomLayout *)_clv.collectionViewLayout;
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    } else {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    _clv.collectionViewLayout = layout;
    [_clv reloadData];
}
@end
