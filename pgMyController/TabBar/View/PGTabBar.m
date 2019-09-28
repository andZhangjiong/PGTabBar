//
//  PGTaBar.m
//  pgMyController
//
//  Created by 张炯 on 2019/8/22.
//  Copyright © 2019 张炯. All rights reserved.
//

#import "PGTabBar.h"
#import "PGTabbarItem.h"
#import "PGTabbarConfig.h"
#import "UIView+pgViewFrame.h"
#import "NSMutableArray+pgSafeHelper.h"
#import "PGTaBarController.h"

#define PG_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define PG_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define iSiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSiPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iSBANG_Screen (iSiPhoneX || iSiPhoneXR || iSiPhoneXS || iSiPhoneXS_MAX)

#define TABBARHEIGHT (iSBANG_Screen ? 83 : 49)

#define PG_STATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)

#define NARBARHEIGHT (PG_STATUSBAR_HEIGHT+44)

#define BottomSafeHeight (MA_BANG_Screen ? 34 : 0)

@interface PGTabBar ()

/** 存放 CustomTabbarItem 数组 */
@property (nonatomic, strong) NSMutableArray *saveTabBarBtnArr;
/** 正常状态下image数组 */
@property (nonatomic, strong) NSMutableArray *norImageArr;
/** 选中状态下image数组 */
@property (nonatomic, strong) NSMutableArray *selImageArr;
/** 标题数组 */
@property (nonatomic, strong) NSMutableArray *titleArr;


@end

@implementation PGTabBar

- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(PGTabbarConfig *)config
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backGroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backGroundView.userInteractionEnabled = YES;
        [self addSubview:self.backGroundView];
        self.saveTabBarBtnArr = [NSMutableArray array];
        for (int i = 0; i < titleArr.count; i++)
        {
            PGTabbarItem *tbBtn = [[PGTabbarItem alloc] init];
            if ([self isURLImage:norImageArr[i]])
            {
//                [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:norImageArr[i]]];
            }
            else
            {
                tbBtn.imageView.image = [UIImage imageNamed:norImageArr[i]];
            }
            tbBtn.title.text = titleArr[i];
            tbBtn.title.textColor = [[PGTabbarConfig config] norTitleColor];
            tbBtn.tag = i;
            [self addSubview:tbBtn];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tbBtn addGestureRecognizer:tap];
            
            [self.saveTabBarBtnArr addObject:tbBtn];
            
        }
        self.titleArr = [NSMutableArray arrayWithArray:titleArr];
        self.norImageArr = [NSMutableArray arrayWithArray:norImageArr];
        self.selImageArr = [NSMutableArray arrayWithArray:selImageArr];
        
        //背景颜色处理
        self.backgroundColor = [[PGTabbarConfig config] tabBarBackground];
        
        //顶部线条处理
        if (config.isClearTabBarTopLine)
        {
            [self topLineIsClearColor:YES];
        }
        else
        {
            [self topLineIsClearColor:NO];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backGroundView.frame = self.bounds;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[PGTabbarItem class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    //进行排序
    for (int i = 0; i < tempArr.count; i++)
    {
        UIView *view = tempArr[i];
        if ([view isKindOfClass:[UIButton class]])
        {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }
    
    CGFloat viewW = self.width / tempArr.count;
    CGFloat viewH = 49;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++)
    {
        CGFloat viewX = i * viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    [self setUpSelectedIndex:tag];
    [self setSelectedIndex:tag];
    [PGTabbarConfig config].tabBarController.selectedIndex = tag;
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.myDelegate tabBar:self didSelectIndex:tag];
    }
//    NSString *target = [NSString stringWithFormat:@"138731.1.%zd",tag+1];
//    NSString *url = [NSString stringWithFormat:@"router://Hermes/appendEvent?target=%@",target] ;
//    [JDRouter openURL:url arg:nil error:nil completion:nil];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self setUpSelectedIndex:selectedIndex];
}

#pragma mark - 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex
{
    for (int i = 0; i < self.saveTabBarBtnArr.count; i++)
    {
        PGTabbarItem *tbBtn = self.saveTabBarBtnArr[i];
        if (i == selectedIndex)
        {
            tbBtn.title.textColor = [[PGTabbarConfig config] selTitleColor];
            if ([self isURLImage:self.selImageArr[i]])
            {
//                [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.selImageArr[i]]];
            }
            else
            {
                tbBtn.imageView.image = [UIImage imageNamed:self.selImageArr[i]];
            }
        }
        else
        {
            tbBtn.title.textColor = [[PGTabbarConfig config] norTitleColor];
            if ([self isURLImage:self.norImageArr[i]])
            {
//                [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.norImageArr[i]]];
            }
            else
            {
                tbBtn.imageView.image = [UIImage imageNamed:self.norImageArr[i]];
            }
            [tbBtn.imageView.layer removeAllAnimations];
        }
    }
}

- (void)updateNorImageArr:(NSArray *)norImageArr
{
    if (norImageArr.count == self.norImageArr.count) {
        self.norImageArr = [NSMutableArray arrayWithArray:norImageArr];
    }
    [self setUpSelectedIndex:self.selectedIndex];
}

- (void)updateSelImageArr:(NSArray *)selImageArr
{
    if (selImageArr.count == self.selImageArr.count) {
        self.selImageArr = [NSMutableArray arrayWithArray:selImageArr];
    }
    [self setUpSelectedIndex:self.selectedIndex];
}


- (void)updateTitle:(NSString *)title AtIndex:(NSInteger)index
{
    PGTabbarItem *item = self.saveTabBarBtnArr[index];
    item.title.text = title;
    [self.titleArr safe_setObject:title AtIndex:index];
}

- (void)updateSelImage:(NSString *)image AtIndex:(NSInteger)index
{
    [self.selImageArr safe_setObject:image AtIndex:index];
    PGTabbarItem *tbBtn = self.saveTabBarBtnArr[index];
    if (self.selectedIndex == index) {
        if ([self isURLImage:self.selImageArr[index]])
        {
//            [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.selImageArr[index]]];
        }
        else
        {
            tbBtn.imageView.image = [UIImage imageNamed:self.selImageArr[index]];
        }
    }
}

- (void)updateNorImage:(NSString *)image AtIndex:(NSInteger)index
{
    [self.norImageArr safe_setObject:image AtIndex:index];
    PGTabbarItem *tbBtn = self.saveTabBarBtnArr[index];
    if (self.selectedIndex != index) {
        if ([self isURLImage:self.norImageArr[index]])
        {
//            [tbBtn.imageView sd_setImageWithURL:[NSURL URLWithString:self.norImageArr[index]]];
        }
        else
        {
            tbBtn.imageView.image = [UIImage imageNamed:self.norImageArr[index]];
        }
    }
}

#pragma mark - 顶部线条处理(清除颜色)
- (void)topLineIsClearColor:(BOOL)isClearColor
{
    UIColor *color = [UIColor clearColor];
    if (!isClearColor)
    {
        color = [[PGTabbarConfig config] tabBarTopLineColor];
    }
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

- (BOOL)isURLImage:(NSString *)imageURL
{
    if ([[imageURL lowercaseString] hasPrefix:@"http"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)setTabbrHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (animated) {
        if (isHidden == NO) {
            self.hidden = NO;
        }
        [UIView animateWithDuration:0.3 animations:^{
            CGFloat H = [PGTabbarConfig config].tabBarController.view.frame.size.height;
            if (isHidden) {
                self.frame = CGRectMake(self.frame.origin.x, H, self.frame.size.width, self.frame.size.height);
            }
            else
            {
                self.frame = CGRectMake(self.frame.origin.x, H - TABBARHEIGHT, self.frame.size.width, self.frame.size.height);
            }
        } completion:^(BOOL finished) {
            if (isHidden == YES) {
                self.hidden = YES;
            }
        }];
    }
    else
    {
        CGFloat H = [PGTabbarConfig config].tabBarController.view.frame.size.height;
        if (isHidden) {
            self.frame = CGRectMake(self.frame.origin.x, H, self.frame.size.width, self.frame.size.height);
        }
        else
        {
            self.frame = CGRectMake(self.frame.origin.x, H - TABBARHEIGHT, self.frame.size.width, self.frame.size.height);
        }
        self.hidden = isHidden;
    }
}

@end
