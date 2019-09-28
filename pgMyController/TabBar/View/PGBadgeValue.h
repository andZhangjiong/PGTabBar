//
//  PGBadgeValue.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PGBadgeValueType) {
    PGBadgeValueTypePoint, //点
    PGBadgeValueTypePoper, //气泡
    PGBadgeValueTypeNumber, //数字
};

NS_ASSUME_NONNULL_BEGIN


@interface PGBadgeValue : UIView

/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;

/** type */
@property (nonatomic, assign) PGBadgeValueType type;

@end

NS_ASSUME_NONNULL_END
