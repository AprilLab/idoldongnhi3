//
//  AUIExpandableTextView.h
//  UIKit
//
//  Copyright (c) 2008-2013, Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIView, UILabel, UIScrollView;

@interface AUIExpandableTextView : UIView
{
    // value
    NSString *contentText;
    UIColor *contentColor;
    UIFont *contentFont;
    UIImageView *proxyFull;
    
    // ui
    UILabel *label;
    UILabel *labelFull;
    UITextView *textView;
    
    CGRect containerCollapsedFrame;
    UIEdgeInsets edgeInsets;
    
    // aaa
    int contentHeight;
    int contentMaxHeight;
    
    CGRect backupCollapsedLabelFrame;
    CGRect backupCollapsedlabelFullFrame;
    CGRect backupCollapsedtextViewFrame;
}

@property (nonatomic) BOOL autoHandlerTapEvent;

-(instancetype)initWithFrame:(CGRect)frame andMaxHeight:(int)maxHeight;

-(void)setTextContainerInset:(UIEdgeInsets)edge;
-(void)setText:(NSString *)text;
-(void)setTextShadowColor:(UIColor *)color offset:(CGSize)offset;
-(void)setTextColor:(UIColor *)color;
-(void)setFont:(UIFont *)font;

-(void)render;

-(void)toggleExpandCollapseAnimated:(BOOL)animated;

@end
