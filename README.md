# vertical-horizontal-waterfall-layout
可横竖向切换的瀑布流布局
<br>
![image](https://github.com/XY-Wing/vertical-horizontal-waterfall-layout/blob/master/GIF/layout.gif)
### Usage
```Objc
        XYCustomLayout *layout = [[XYCustomLayout alloc] init];
        layout.delegate = self;
        layout.columnCount = 3;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; 
```

### Properties
```Objc
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
```

### Delegates
```Objc
/*
 竖直滚动时生效 获取item的高度， 宽度自适应
 */
- (CGFloat)customLayout:(XYCustomLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
/*
 水平滚动时生效 获取item的宽度， 高度自适应
 */
- (CGFloat)customLayout:(XYCustomLayout *)layout widthForItemAtIndexPath:(NSIndexPath *)indexPath;
```
