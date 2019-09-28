//
//  PGTabbarItem.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "PGTabbarItem.h"
#import "PGBadgeValue.h"
#import "PGTabbarConfig.h"
#import "UIColor+pgHexColor.h"
#import "UIView+pgViewFrame.h"


@implementation PGTabbarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:self.title];
        
        self.badgeValue = [[PGBadgeValue alloc] init];
        self.badgeValue.hidden = YES;
        [self addSubview:self.badgeValue];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = [[PGTabbarConfig config] imageSize];
    CGFloat imageY = 7;
    CGFloat iamgeX = self.frame.size.width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 15.f;
    CGFloat titleW = self.frame.size.width - 8;
    CGFloat titleY = self.frame.size.height - 18.f;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame)+1;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 4;

    self.badgeValue.origin = CGPointMake(badgeX, badgeY);
}

@end
