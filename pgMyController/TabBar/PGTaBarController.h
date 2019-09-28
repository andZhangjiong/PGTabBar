//
//  PGTaBarController.h
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PGTabBar, PGTabbarConfig;

@interface PGTaBarController : UITabBarController

@property (nonatomic, strong) PGTabBar *pgTabBar;

@property (nonatomic, assign) BOOL animationHidden;

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config: (PGTabbarConfig *)config;


@end



NS_ASSUME_NONNULL_END
