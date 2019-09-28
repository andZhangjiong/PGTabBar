//
//  PGTabbarItem.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGBadgeValue;

@interface PGTabbarItem : UIView

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 标题 */
@property (nonatomic, strong) UILabel *title;
/** badgeValue */
@property (nonatomic, strong) PGBadgeValue *badgeValue;

@end

NS_ASSUME_NONNULL_END
