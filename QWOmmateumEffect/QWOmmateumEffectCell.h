//
//  QWOmmateumEffectCell.h
//  QWOmmateumEffect
//
//  Created by More Mocha on 16/11/22.
//  Copyright © 2016年 QivenDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWOmmateumEffectCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, copy) NSString *tempLabelText;

- (void)startCellOmmateumEffect:(UIView *)view;

@end
