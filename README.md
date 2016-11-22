#QWOmmateumEffect
![](http://upload-images.jianshu.io/upload_images/3403640-fabd1e5afc7f5078.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

前言：
-----
简简单单的一个视觉差异效果，可以让普通的Cell看起来生动了不少。我把这个效果想象成可以透过多个窗口看到图片，所以起了Ommateum这个名字。
###效果图：
![当tableView滚动，Cell的图片也会滚动](http://upload-images.jianshu.io/upload_images/3403640-fa8e70cf7f32f2e7.gif?imageMogr2/auto-orient/strip)

Ommateum效果实现：
----
cell里的宏
```
// scrollView的滚动系数
#define kRATIO              kSCROLLVIEWHIGHT*0.5/kSCREENHEIGHT/kSCREENHEIGHT
#define kSCREENWIDTH        [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT       [UIScreen mainScreen].bounds.size.height
#define kSCROLLVIEWHIGHT    200
```
cell里的滚动方法：
```
- (void)startCellOmmateumEffect:(UIView *)view {
    //     将cell的frame转换成view的Frame(为了获取每个cell的Y值计算应当滚动多少)
    CGRect rect = [self.superview.superview convertRect:self.frame toView:view];
    //     tableView往上滑动时，当cell即将完全移出屏幕，这个时候cell还在可见区域内，而它的Y值是最大的负数，也就是说
    负多少和正多少scrollView滚动距离都是一样的，这里是按照tableView的height+一个cell的height这个范围来计算，所以
    这里加上一个cell的高度（如果不理解可以去掉kSCROLLVIEWHIGHT往上滑动看效果）
    CGFloat originY =  rect.origin.y + kSCROLLVIEWHIGHT;
    _scrollView.contentOffset = CGPointMake(0, originY*originY*kRATIO + kSCROLLVIEWHIGHT*0.5);
}
```
当tableView滚动时在代理方法scrollViewDidScroll：中去遍历当前可见的所有cell，执行他们的滚动方法
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (QWOmmateumEffectCell *cell in [_tableview visibleCells]) {
        [cell startCellOmmateumEffect:self.view];
    }
}
```
一上来加载tableView时并没有滚动到相应的位置，需要手动去让它滚一次：
```
dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:[[UIScrollView alloc] init]];
    });
```
感觉对自己有帮助请给个星，欢迎小伙伴们留言指出不足！
