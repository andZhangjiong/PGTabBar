//
//  PGBadgeValue.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "PGBadgeValue.h"
#import "PGTabbarConfig.h"
#import "UIView+pgViewFrame.h"
#import "UIColor+pgHexColor.h"

@implementation PGBadgeValue

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [[PGTabbarConfig config] badgeTextColor];
        self.badgeL.font = [UIFont systemFontOfSize:10];
        self.badgeL.size = CGSizeMake(14, 14);
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 7.f;
        self.badgeL.layer.masksToBounds = YES;
        self.badgeL.backgroundColor = [[PGTabbarConfig config] badgeBackgroundColor];
        [self addSubview:self.badgeL];
    }
    return self;
}

- (void)resetBadgeLabel
{
    if (![self.badgeL.superview isKindOfClass:[self class]]) {
        [self.badgeL.superview removeFromSuperview];
        [self addSubview:self.badgeL];
    }
    self.badgeL.layer.cornerRadius = 7.f;
    self.badgeL.font = [UIFont systemFontOfSize:10];
    self.badgeL.textColor = [[PGTabbarConfig config] badgeTextColor];
    self.badgeL.textAlignment = NSTextAlignmentCenter;
    self.badgeL.size = CGSizeMake(14, 14);
    self.badgeL.layer.masksToBounds = YES;
    self.badgeL.backgroundColor = [[PGTabbarConfig config] badgeBackgroundColor];
}

- (void)setType:(PGBadgeValueType )type
{
    [self resetBadgeLabel];
    _type = type;
    if (type == PGBadgeValueTypePoint)
    {
        self.badgeL.size = CGSizeMake(10, 10);
        self.badgeL.layer.cornerRadius = 5.f;
        self.badgeL.x = 5;
        self.badgeL.y = self.height  - self.badgeL.size.height * 0.1;
    }
    else if (type == PGBadgeValueTypePoper)
    {
        CGSize size = CGSizeZero;
        CGFloat radius = 7.f;
        self.badgeL.layer.cornerRadius = 0;
        if (self.badgeL.text.length <= 1)
        {
            size = CGSizeMake(14, 14);
            radius = size.height * 0.5;
        } else if (self.badgeL.text.length > 1)
        {
            size = CGSizeMake([self calculateRowWidthString:self.badgeL.text withHeight:14 andFont:self.badgeL.font]+14, 14);
        }
        
        self.badgeL.size = size;
        UIView *labelBackground = [[UIView alloc] initWithFrame:self.badgeL.frame];
        self.badgeL.backgroundColor = [UIColor clearColor];
        self.badgeL.frame = self.badgeL.bounds;
        [self.badgeL.superview addSubview:labelBackground];
        [self.badgeL removeFromSuperview];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FF4142"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FF4B2B"].CGColor];
        gradientLayer.locations = @[@0.3, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = self.badgeL.bounds;
        [labelBackground.layer addSublayer:gradientLayer];
        [labelBackground addSubview:self.badgeL];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.badgeL.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.badgeL.bounds;
        maskLayer.path = maskPath.CGPath;
        labelBackground.layer.mask = maskLayer;
    }
    else if (type == PGBadgeValueTypeNumber)
    {
        CGSize size = CGSizeZero;
        CGFloat radius = 9.f;
        if (self.badgeL.text.length <= 1)
        {
            size = CGSizeMake(18, 18);
            radius = size.height * 0.5;
        } else if (self.badgeL.text.length > 1)
        {
            size = CGSizeMake([self calculateRowWidthString:self.badgeL.text withHeight:18 andFont:self.badgeL.font]+10, 18);
            radius = 5.f;
        }
        self.badgeL.size = size;
        self.badgeL.layer.cornerRadius = radius;
    }
}

- (CGFloat)calculateRowWidthString:(NSString *)string withHeight:(CGFloat)height andFont:(UIFont *)font
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}

- (CGSize)sizeWithAttribute:(NSString *)text
{
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeL.font}];
}

@end
