//
//  AUITabBarItem.m
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import "AUITabBarItem.h"

@interface AUITabBarItem ()

@end

@implementation AUITabBarItem


- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [self initWithFrame:CGRectZero];
    [self setTitle:title forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    return self;
}

@end