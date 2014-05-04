//
//  AUIExpandableTextView.m
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import "AUIExpandableTextView.h"

@interface AUIExpandableTextView ()

@end

@implementation AUIExpandableTextView

-(instancetype)initWithFrame:(CGRect)frame andMaxHeight:(int)maxHeight
{
    if(!(self = [super initWithFrame:frame]))
        return nil;
    
    // luu lai cai frame
    containerCollapsedFrame = frame;
    
    // khoi tao proxy
    proxyFull = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 520)];
    [proxyFull setBackgroundColor:[UIColor colorWithRed:(float)0 green:(float)0 blue:(float)0 alpha:0.7]];
    [proxyFull setHidden:YES];
    [proxyFull setUserInteractionEnabled:YES];
    [self addSubview:proxyFull];
    
    
    // khoi tao label, textview
    label = [[UILabel alloc] init];
    //[label setBackgroundColor:[UIColor redColor]];
    [label setNumberOfLines:0];
    [self addSubview:label];
    
    // lable Fullview
    labelFull = [[UILabel alloc] init];
    //[labelFull setBackgroundColor:[UIColor redColor]];
    [labelFull setNumberOfLines:0];
    [labelFull setHidden:YES];
    [self addSubview:labelFull];
    
    // luu lai max height
    contentMaxHeight = maxHeight;
    
    // text scroll view
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height - contentMaxHeight, frame.size.width, contentMaxHeight)];
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView setSelectable:NO];
    [textView setEditable:NO];
    [textView setHidden:YES];
    [self addSubview:textView];


    // set lai contentHeight
    contentHeight = (int)frame.size.height;
    
    
    // event
    self.autoHandlerTapEvent = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tap];
    
    return self;
}


-(void)setText:(NSString *)text
{
    contentText = text;
    
    // don gian la se cai doan text vao trong label thoi
    [label setText:text];
    [labelFull setText:text];
    [textView setText:text];
}
-(void)setTextColor:(UIColor *)color
{
    contentColor = color;
    
    [label setTextColor:color];
    [labelFull setTextColor:color];
    [textView setTextColor:color];
}
-(void)setFont:(UIFont *)font
{
    contentFont = font;
    
    [label setFont:font];
    [labelFull setFont:font];
    [textView setFont:font];
}
-(void)setTextShadowColor:(UIColor *)color offset:(CGSize)offset;
{
    [label setShadowColor:color];
    [label setShadowOffset:offset];
    [labelFull setShadowColor:color];
    [labelFull setShadowOffset:offset];
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:contentText];
    NSRange range = NSMakeRange(0, [attString length]);
    
    [attString addAttribute:NSForegroundColorAttributeName value:contentColor range:range];
    [attString addAttribute:NSFontAttributeName value:contentFont range:range];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowColor = color;
    shadow.shadowOffset = offset;
    [attString addAttribute:NSShadowAttributeName value:shadow range:range];
    
    [textView setAttributedText:attString];
}
-(void)setTextContainerInset:(UIEdgeInsets)edge
{
    edgeInsets = edge;
    //[textView setTextContainerInset:edgeInsets];
}

-(void)render
{
    // set height cho thang label binh thuong
    CGRect labelFrame = CGRectMake(edgeInsets.left, edgeInsets.top, containerCollapsedFrame.size.width - edgeInsets.left - edgeInsets.right, containerCollapsedFrame.size.height - edgeInsets.top - edgeInsets.bottom);
    label.frame = labelFrame;
    
    // tinh toan lai height cho thang labelfull
    CGRect newRectSize;
    
    if(contentFont)
    {
        newRectSize = [contentText boundingRectWithSize:CGSizeMake(containerCollapsedFrame.size.width, 9999)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:contentFont}
                                                       context:nil];
    }
    else
    {
        newRectSize = labelFrame;
    }
    
   // CGRect labelFullFrame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y, labelFrame.size.width, newRectSize.size.height);

    // update lai contentHeight
    contentHeight = (int)newRectSize.size.height;
    
    //NSLog(@"labelFullFrameheight: %f", labelFullFrame.size.height);
    
    // change height cho thang label full
    //labelFull.frame = labelFullFrame;
    
}


-(void)toggleExpandCollapseAnimated:(BOOL)animated
{
    //NSLog(@"sender.state: %@", sender);
    
    // neu nhu thang label nho bi hide di roi
    // thi lan tap nay can phai show no len lai
    if([label isHidden])
    {
        [label setHidden:NO];
        [labelFull setHidden:YES];
        [textView setHidden:YES];
        [proxyFull setHidden:YES];
        
     //   [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^(void) {
            self.frame = containerCollapsedFrame;
     //   } completion:nil];
        
        return;
    }
    
    
    
    // khi tap vao, thi chac chan thang label nho (noi dung bi trim di)
    // thi phai hidden, va 1 trong 2 thang label full, hoac thang textview scroll
    // phai duoc show len, nhung ma thang nao duoc show len thi chua biet
    // neu phai kiem tra:
    // neu nhu ma contentHeight < contentMaxHeight
    // thi thang labelfull duoc show len
    // con nguoc lai thi boi vi noi dung text dai qua
    // nen thang textscroll view phai duoc show len
    
    // hide thang nho
    [label setHidden:YES];
    
    
    // backup lai may cai frame
    backupCollapsedLabelFrame = label.frame;
    backupCollapsedlabelFullFrame = labelFull.frame;
    backupCollapsedtextViewFrame = textView.frame;
    
    
    // tinh toan ra frame cho 2 cai thang labelFull va textview
    
    //
    if(contentHeight <= contentMaxHeight)
    {
        // show thang label full
        [labelFull setHidden:NO];
        
        // tinh toan ra coi cai frame expanded ra se nhu the nao
        labelFull.frame = CGRectMake(containerCollapsedFrame.origin.x + edgeInsets.left,
                                  containerCollapsedFrame.origin.y + containerCollapsedFrame.size.height - contentHeight - edgeInsets.top - edgeInsets.bottom,
                                     containerCollapsedFrame.size.width - edgeInsets.left - edgeInsets.right,
                                  contentHeight + edgeInsets.top + edgeInsets.bottom + 10);
        
    }
    else
    {
        // show thang textview scroll
        [textView setHidden:NO];
    }
    
    
    
    // bat dau hieu ung thoi
    if(animated)
    {
        
        // set background cho thang cuoi chan
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^(void) {
            self.frame = CGRectMake(0, 0, 320, 520);
        } completion:^(BOOL finished){
            [proxyFull setHidden:NO];
        }];
    
    }
    else{
        self.frame = CGRectMake(0, 0, 320, 520);
        [proxyFull setHidden:NO];
    }
    
}



- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if(!self.autoHandlerTapEvent)
        return;
    
    [self toggleExpandCollapseAnimated:YES];
}

@end