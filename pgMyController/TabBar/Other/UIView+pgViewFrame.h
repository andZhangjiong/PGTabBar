//
//  UIView+pgViewFrame.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (pgViewFrame)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat   top;

@property (nonatomic, assign) CGFloat   left;

@property (nonatomic, assign) CGFloat   bottom;

@property (nonatomic, assign) CGFloat   right;

@property (nonatomic, assign) CGFloat   centerX;

@property (nonatomic, assign) CGFloat   centerY;

@end

NS_ASSUME_NONNULL_END
