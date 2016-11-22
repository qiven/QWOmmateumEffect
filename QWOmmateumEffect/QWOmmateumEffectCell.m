//
//  QWOmmateumEffectCell.m
//  QWOmmateumEffect
//
//  Created by More Mocha on 16/11/22.
//  Copyright © 2016年 QivenDev. All rights reserved.
//

#import "QWOmmateumEffectCell.h"

// scrollView的滚动系数
#define kRATIO              kSCROLLVIEWHIGHT*0.5/kSCREENHEIGHT/kSCREENHEIGHT
#define kSCREENWIDTH        [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT       [UIScreen mainScreen].bounds.size.height
#define kSCROLLVIEWHIGHT    200



@implementation QWOmmateumEffectCell {
    UIScrollView    *_scrollView;
    UILabel         *_tempLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCROLLVIEWHIGHT)];
    _scrollView.userInteractionEnabled = false;
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCROLLVIEWHIGHT*2)];
    
    [_scrollView addSubview:self.backgroundImageView];
    [self.contentView addSubview:_scrollView];
    
    _scrollView.contentSize = self.backgroundImageView.image.size;
    
    _tempLabel = [[UILabel alloc] init];
    [_tempLabel setTextColor:[UIColor whiteColor]];
    [_tempLabel setFont:[UIFont systemFontOfSize:30]];
    [self.contentView addSubview:_tempLabel];
}

- (void)startCellOmmateumEffect:(UIView *)view {
    //     将cell的frame转换成view的Frame(为了获取每个cell的Y值)
    CGRect rect = [self.superview.superview convertRect:self.frame toView:view];
    //     tableView往上滑动时，当cell即将完全移出屏幕，这个时候cell还在可见区域内，而它的Y值是最大的负数，也就              是说负多少和正多少scrollView滚动距离都是一样的，这里是按照tableView的height+一个cell的height这个范围来计算，所以这里加上一个cell的高度（如果不理解可以去掉kSCROLLVIEWHIGHT往上滑动看效果）
    CGFloat originY =  rect.origin.y + kSCROLLVIEWHIGHT;
    _scrollView.contentOffset = CGPointMake(0, originY*originY*kRATIO + kSCROLLVIEWHIGHT*0.5);
}

- (void)setTempLabelText:(NSString *)tempLabelText {
    _tempLabelText = tempLabelText;
    [_tempLabel setText:tempLabelText];
    [_tempLabel sizeToFit];
    _tempLabel.center = self.contentView.center;
    
}@end
