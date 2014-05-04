//
//  AUIFreedomController.h
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUIFreedomController : UIViewController<NSXMLParserDelegate>
{
    NSString *parsingCurrentElement;
    BOOL xmlErrorParsing;
    
    NSMutableArray *parsingViewControllersStack;
}

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSMutableDictionary *viewControllerNames;

+ (id)sharedFreedomController;

- (int)addChildViewController:(UIViewController *)viewController withFrame:(CGRect)frame;
- (int)addChildViewController:(UIViewController *)viewController withName:(NSString *)name withFrame:(CGRect)frame;

- (id)getChildViewControllerWithName:(NSString *)name;
- (AUIFreedomController *)getAUIFreedomParrentOfViewControllerWithName:(NSString *)name;

- (BOOL)removeChildViewControllerAtIndex:(int)index;

- (void)changeChildViewControllerFrame:(CGRect)frame atIndex:(int)index;
- (void)changeChildViewControllerFrame:(CGRect)frame atIndex:(int)index withDuration:(float)duration delay:(float)delay;
- (void)changeChildViewControllerFrame:(CGRect)frame withName:(NSString *)name;
- (void)changeChildViewControllerFrame:(CGRect)frame withName:(NSString *)name withDuration:(float)duration delay:(float)delay;

- (CGRect)getChildViewControllerFrameAtIndex:(int)index;

- (int)getHeight;
- (int)getWidth;

- (void) buildInterfaceFromXMLFile:(NSString *)name;

@end
