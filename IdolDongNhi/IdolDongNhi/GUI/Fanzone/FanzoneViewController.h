//
//  FanzoneViewController.h
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 4/27/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUITabBar.h"

@interface FanzoneViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AUITabBarDelegate>

@property (nonatomic, strong) IBOutlet UITableView *listFanzone;

@property (nonatomic, strong) IBOutlet UITextField *messageField;
@property (nonatomic, strong) IBOutlet UIButton *chooseSticker;
@property (nonatomic, strong) IBOutlet UIButton *chooseColor;
@property (nonatomic, strong) IBOutlet UIButton *sendMessage;

@end
