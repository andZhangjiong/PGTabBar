//
//  PGTaBarController.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "PGTaBarController.h"
#import "PGTabBar.h"
#import "PGTabbarConfig.h"

@interface PGTaBarController ()

@property (nonatomic, assign) BOOL isHiddenTabbar;

@end


@implementation PGTaBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isHiddenTabbar = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(PGTabbarConfig *)config
{
    if (self = [super init]) {
        self.viewControllers = controllers;
        self.pgTabBar = [[PGTabBar alloc] initWithFrame:self.tabBar.frame norImageArr:norImageArr SelImageArr:selImageArr TitleArr:titleArr Config:config];
        [self setValue:self.pgTabBar forKeyPath:@"tabBar"];
        [PGTabbarConfig config].tabBarController = self;
        self.pgTabBar.selectedIndex = 0;
        //KVO
        [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        self.tabBar.translucent = NO;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSInteger selectedIndex = [change[@"new"] integerValue];
    self.pgTabBar.selectedIndex = selectedIndex;
}

- (void)selectedIndexWithDes:(NSString *)des{
    UINavigationController *toNavi;
    NSUInteger index = self.selectedIndex;
    if ([des isEqualToString:@"HomePage"]) {
        index = 0;
    }
    if ([des isEqualToString:@"search"]) {
        index = 1;
    }
    if ([des isEqualToString:@"myJd"]) {
        index = self.viewControllers.count-1;
    }
    toNavi = self.viewControllers[index];
    if (toNavi) {
        if (toNavi.viewControllers.count > 1) {
            [toNavi popToRootViewControllerAnimated:NO];
        }
        if (self.selectedIndex!=index) {
            self.selectedIndex = index;
        }
    }
}

+ (BOOL)isTabbarHome:(NSString *)des{
    if ([des isEqualToString:@"HomePage"] || [des isEqualToString:@"search"] || [des isEqualToString:@"myJd"]) {
        return YES;
    }
    return NO;
}

@end
