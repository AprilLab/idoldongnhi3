//
//  AUITabBar.m
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUITabBar.h"
#import "AUITabBarItem.h"

@interface AUITabBar ()

@end

@implementation AUITabBar

+(void) hackToRecieveEventInView:(UIView *)view
{
    UITabBar *hackTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, -30, 320, 22)];
    [hackTabBar setItems:[[NSArray alloc] initWithObjects:[[UITabBarItem alloc] initWithTitle:nil image:nil tag:1], nil] animated:YES];
    [view addSubview:hackTabBar];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.selectedItem = NULL;
    self.selectedIndex = 0;
    
    tabbarItems = [[NSMutableArray alloc] init];
    
    // add vao 1 cai background image
    if(backgroundImageView == NULL)
    {
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backgroundImageView];
    }
    
    // khoi tao cai thang wrapper truoc
    if(tabbarItemsWrapperView == NULL)
    {
        tabbarItemsWrapperView = [[UIView alloc] initWithFrame:self.frame];
        [self addSubview:tabbarItemsWrapperView];
    }
    
    return self;
}

-(void)setTabbarItems:(NSMutableArray *)items
{
    
    
    if([items count] <= 0)
        return;
    
    // tinh toan ra width, height cua may cai nut
    float width = self.frame.size.width / [items count];
    float height = self.frame.size.height;
    
    
    // append may cai nut vao
    for(int i = 0; i < [items count]; i++)
    {
        AUITabBarItem *tabbarItem = (AUITabBarItem *)[items objectAtIndex:i];
        
        [tabbarItem setFrame:CGRectMake(i * width, 0, width, height)];
        [tabbarItemsWrapperView addSubview:tabbarItem];
        
        // set cai tag de xiu nua khi nhan event thi con biet
        [tabbarItem setTag:(i+1)];
        
        // add event
        [tabbarItem addTarget:self action:@selector(tabbarItemTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        // add vao thoi
        [tabbarItems addObject:tabbarItem];
    }
    
}

-(void)setBackgroundImage:(UIImage *)image
{
    [backgroundImageView setImage:image];
}
-(void)setBottomShadowImage:(UIImage *)image
{
    // kiem tra xem coi bottomShadowImageView co duoc khoi tao hay chua
    // neu chua duoc khoi tao thi se khoi tao
    if(bottomShadowImageView == NULL)
    {
        bottomShadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, image.size.width, image.size.height)];
        [self addSubview:bottomShadowImageView];
        [self sendSubviewToBack:bottomShadowImageView];
    }
    
    [bottomShadowImageView setImage:image];
}

- (void)setItemsColor:(UIColor *)color forState:(UIControlState)state
{
    for(int i = 0; i < [tabbarItems count]; i++)
    {
        AUITabBarItem *tabbarItem = (AUITabBarItem *)[tabbarItems objectAtIndex:i];
        [tabbarItem setTitleColor:color forState:state];
    }
}

- (void)setItemsFont:(UIFont *)font
{
    for(int i = 0; i < [tabbarItems count]; i++)
    {
        AUITabBarItem *tabbarItem = (AUITabBarItem *)[tabbarItems objectAtIndex:i];
        tabbarItem.titleLabel.font = font;
    }
}

- (void)initSelectedItemBorderWithFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    
    self.selectedItemBorder = [[UILabel alloc] initWithFrame:frame];
    [self.selectedItemBorder setBackgroundColor:color];
    [self addSubview:self.selectedItemBorder];
    
    [self bringSubviewToFront:tabbarItemsWrapperView];
}


- (void)selectTabAtIndex:(int)index
{
    AUITabBarItem *tabbarItem = (AUITabBarItem *)[tabbarItems objectAtIndex:index];
    [self tabbarItemTouchUpInside:tabbarItem];
}


// event

-(void) tabbarItemTouchUpInside:(id)sender
{
    
    // kiem tra xem coi index bao nhieu
    AUITabBarItem *tabbarItem = (AUITabBarItem *)sender;
    NSInteger index = (tabbarItem.tag-1);
    
    // xem coi co cai thang border bottom hay khong
    // thi se truot qua cai index moi
    if(self.selectedItemBorder != NULL)
    {
        float chenhlech = (index - self.selectedIndex) * self.frame.size.width / [tabbarItems count];
        
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      self.selectedItemBorder.frame = CGRectMake(self.selectedItemBorder.frame.origin.x + chenhlech, self.selectedItemBorder.frame.origin.y, self.selectedItemBorder.frame.size.width, self.selectedItemBorder.frame.size.height);
                                  }
                                  completion:nil];
    }
    
    // set ngay vao cai thang selected
    self.selectedItem = tabbarItem;
    self.selectedIndex = index;
    
    // cuoi cung don gian la goi qua delegate
    [self.delegate aTabBar:self didSelectItem:tabbarItem atIndex:index];
}

@end