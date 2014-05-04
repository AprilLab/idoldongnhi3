//
//  AUITabBar.h
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AUITabBarItem;
@class UIImageView;
@protocol AUITabBarDelegate;

@interface AUITabBar : UIView
{
    UIImageView *backgroundImageView;
    UIImageView *bottomShadowImageView;
    UIView *tabbarItemsWrapperView;
    NSMutableArray *tabbarItems;
}

@property(nonatomic, assign) id<AUITabBarDelegate> delegate;     // weak reference. default is nil
@property(nonatomic) int        selectedIndex;
@property(nonatomic, strong) AUITabBarItem        *selectedItem;
@property(nonatomic, strong) UILabel        *selectedItemBorder;


+(void) hackToRecieveEventInView:(UIView *)view;

- (void)setTabbarItems:(NSMutableArray *)items;
- (void)setBackgroundImage:(UIImage *)image;
- (void)setBottomShadowImage:(UIImage *)image;

- (void)selectTabAtIndex:(int)index;


// style
- (void)setItemsColor:(UIColor *)color forState:(UIControlState)state;
- (void)setItemsFont:(UIFont *)font;
- (void)initSelectedItemBorderWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

@end


//___________________________________________________________________________________________________

@protocol AUITabBarDelegate<NSObject>
@optional

- (void)aTabBar:(AUITabBar *)aTabBar didSelectItem:(AUITabBarItem *)item atIndex:(int)index;

@end
