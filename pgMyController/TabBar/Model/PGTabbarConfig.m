//
//  PGTabbarConfig.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "PGTabbarConfig.h"
#import "PGTabbarItem.h"
#import "PGBadgeValue.h"
#import "UIView+pgViewFrame.h"
#import "UIColor+pgHexColor.h"
#import "PGTaBarController.h"
#import "PGTabBar.h"

@implementation PGTabbarConfig

static id _instance = nil;

+ (instancetype)config {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        [self configNormal];
    });
    return _instance;
}

- (void)configNormal
{
    [self setNorTitleColor:[UIColor colorWithHexString:@"#808080"]];
    [self setSelTitleColor:[UIColor colorWithHexString:@"#d81e06"]];
    [self setIsClearTabBarTopLine:YES];
    [self setTabBarTopLineColor:[UIColor lightGrayColor]];
    [self setTabBarBackground:[UIColor whiteColor]];
    [self setImageSize:CGSizeMake(20, 20)];
    [self setBadgeTextColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    [self setBadgeBackgroundColor:[UIColor colorWithHexString:@"#FF4040"]];
    
}

- (void)setBadgeSize:(CGSize)badgeSize
{
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (PGTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset
{
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (PGTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.x += badgeOffset.x;
        btn.badgeValue.badgeL.y += badgeOffset.y;
    }
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    _badgeTextColor = badgeTextColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (PGTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.textColor = badgeTextColor;
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor
{
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (PGTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.backgroundColor = badgeBackgroundColor;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius
{
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (PGTabbarItem *btn in arrM)
    {
        btn.badgeValue.badgeL.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius AtIndex:(NSInteger)index
{
    PGTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index
{
    PGTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = PGBadgeValueTypePoint;
}

- (void)showPoperBadgeValue:(NSString *)value AtIndex:(NSInteger)index
{
    PGTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.text = value;
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = PGBadgeValueTypePoper;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index
{
    PGTabbarItem *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badgeValue.badgeL.text = badgeValue;
    tabBarButton.badgeValue.hidden = NO;
    tabBarButton.badgeValue.type = PGBadgeValueTypeNumber;
    
}

- (void)hideBadgeAtIndex:(NSInteger)index
{
    PGBadgeValue *badgeValue = [self getTabBarButtonAtIndex:index].badgeValue;
    if (badgeValue.type != PGBadgeValueTypePoper) {
        badgeValue.hidden = YES;
    }
}

- (PGTabbarItem *)getTabBarButtonAtIndex:(NSInteger)index
{
    NSArray *subViews = self.tabBarController.pgTabBar.subviews;
    int j=0;
    for (int i = 0; i < subViews.count && j <subViews.count; i++)
    {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[PGTabbarItem class]]) {
            if (j == index) {
                PGTabbarItem *tabBarBtn = (PGTabbarItem *)tabBarButton;
                return tabBarBtn;
            }
            j++;
        }
    }
    return nil;
}

- (NSMutableArray *)getTabBarButtons
{
    NSArray *subViews = self.tabBarController.pgTabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < subViews.count; i++)
    {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[PGTabbarItem class]])
        {
            PGTabbarItem *tabBarBtn = (PGTabbarItem *)tabBarButton;
            [tempArr addObject:tabBarBtn];
        }
    }
    return tempArr;
}

- (void)setNorTitleColor:(UIColor *)norTitleColor
{
    _norTitleColor = norTitleColor;
    for (int i=0; i<self.tabBarController.viewControllers.count; i++) {
        PGTabbarItem *item = [self getTabBarButtonAtIndex:i];
        if (i!=self.tabBarController.selectedIndex) {
            item.title.textColor = norTitleColor;
        }
    }
    
}

- (void)setSelTitleColor:(UIColor *)selTitleColor
{
    _selTitleColor = selTitleColor;
    for (int i=0; i<self.tabBarController.viewControllers.count; i++) {
        PGTabbarItem *item = [self getTabBarButtonAtIndex:i];
        if (i==self.tabBarController.selectedIndex) {
            item.title.textColor = selTitleColor;
        }
    }
}

@end
