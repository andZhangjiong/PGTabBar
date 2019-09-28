//
//  PGTaBar.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGTabBar, PGTabbarConfig;
@protocol PGTabBarDelegate <NSObject>

- (void)tabBar:(PGTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface PGTabBar : UITabBar

@property(weak, nonatomic)id <PGTabBarDelegate> myDelegate;

@property(strong, nonatomic) UIImageView *backGroundView;

@property(assign, nonatomic) NSInteger selectedIndex; // 选中的位置（默认为0）

- (instancetype)initWithFrame: (CGRect)frame norImageArr: (NSArray *)norImageArr SelImageArr: (NSArray *)selImageArr TitleArr: (NSArray *)titleArr Config: (PGTabbarConfig * )config;

- (void)updateNorImageArr:(NSArray *)norImageArr;

- (void)updateSelImageArr:(NSArray *)selImageArr;

- (void)updateTitle:(NSString *)title AtIndex:(NSInteger)index;

- (void)updateSelImage:(NSString *)image AtIndex:(NSInteger)index;

- (void)updateNorImage:(NSString *)image AtIndex:(NSInteger)index;

- (void)setTabbrHidden:(BOOL)isHidden animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
