//
//  FanzoneViewController.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 4/27/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "FanzoneViewController.h"
#import "FanzoneCell.h"
#import "AUIFreedomController.h"

@interface FanzoneViewController (){
    NSDictionary *dataFanzone;
    BOOL viewIsResized;
}

@end

@implementation FanzoneViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.listFanzone =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 160)];
    [self.listFanzone setDataSource:self];
    [self.listFanzone setDelegate:self];
    self.listFanzone.backgroundColor= [UIColor clearColor];
    self.listFanzone.separatorColor= [UIColor clearColor];
    [self.view addSubview:self.listFanzone];
    [[self view] endEditing:YES];
    // chat section
    
    
    
    UIView *chatSection = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-108, 320, 45)];
    [chatSection setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fchat"]]];
    
    
    self.messageField = [[UITextField alloc] initWithFrame:CGRectMake(12, 9, 190,  29)];
    [self.messageField setBackgroundColor:[UIColor clearColor]];
    self.messageField.delegate = self;
    
    
    
    self.chooseSticker = [[UIButton alloc] initWithFrame:CGRectMake(199, 13, 19, 19)];
    [self.chooseSticker setImage:[UIImage imageNamed:@"favatar"] forState:UIControlStateNormal];
    
    self.chooseColor = [[UIButton alloc] initWithFrame:CGRectMake(225, 13, 19, 19)];
    [self.chooseColor setImage:[UIImage imageNamed:@"fnav"] forState:UIControlStateNormal];
    
    
    self.sendMessage = [[UIButton alloc] initWithFrame:CGRectMake(267, 13, 30, 15)];
    [self.sendMessage setImage:[UIImage imageNamed:@"fsend"] forState:UIControlStateNormal];
    
    
    

    
    
    
    
    [chatSection addSubview:self.messageField];
    [chatSection addSubview:self.sendMessage];
    [chatSection addSubview:self.chooseSticker];
    [chatSection addSubview:self.chooseColor];
    
    
    [self.view addSubview:chatSection];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    // [self.view addSubview:self.messageField];
    //[self.view addSubview:self.sendMessage];
    
    
    
    NSArray *values1 = [NSArray arrayWithObjects:
                        @"post_image001.jpg",
                        @"post_image002.jpg",
                        @"post_image003.jpg",
                        @"post_image004.jpg",
                        @"post_image005.jpg",
                        @"post_image006.jpg",
                        @"post_image007.jpg",
                        @"post_image008.jpg",
                        @"post_image009.jpg",
                        @"post_image010.jpg",
                        @"post_image011.jpg",
                        @"post_image012.jpg",
                        nil];
    
    NSArray *values2 = [NSArray arrayWithObjects:
                        @"Kelvin",
                        @"John",
                        @"Jack",
                        @"Philip",
                        @"Obama",
                        @"Kdc",
                        @"Cd",
                        @"Huy",
                        @"John",
                        @"Jack",
                        @"Philip",
                        @"Huy",
                        nil];
    
    NSArray *values3 = [NSArray arrayWithObjects:
                        @"Hi",
                        @"What your name",
                        @"Where do you go",
                        @"Need you now",
                        @"Good bye",
                        @"Wtf",
                        @"Oh my god",
                        @"CLGT",
                        @"LOL",
                        @"Need you now",
                        @"Good bye",
                        @"Wtf",
                        nil];
    
    NSArray *values4 = [NSArray arrayWithObjects:
                        @"7:00",
                        @"9:00",
                        @"10:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        nil];
    
    dataFanzone = [NSDictionary dictionaryWithObjectsAndKeys:values1, @"avarta", values2, @"name", values3, @"message", values4, @"lasttime", nil];
    // set background
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_blur"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-nav"] style:UIBarButtonItemStyleBordered target:self action:@selector(menuButtonClick)];
    
    [menuButton setTintColor: [UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    
    [self addTabBar];
}











UILabel *borderSelected2;
UITabBar *tabBar;
UITabBarController *tb;
float selectBarPosition;
NSArray *itemsArray;
UITabBarItem *preItem1;

-(void)addTabBar{
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"Fan trò chuyện" image:nil tag:1];
    firstItem.titlePositionAdjustment= UIOffsetMake(0, -10.0);
    [firstItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:236.0/255 green:1.0/255 blue:140.0/255 alpha:1], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Arial" size:12.0], NSFontAttributeName,
      nil]
                             forState:UIControlStateNormal];
    preItem1= firstItem;
    
    
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTitle:@"Tài khoản" image:nil tag:2];
    secondItem.titlePositionAdjustment= UIOffsetMake(0, -10.0);
    [secondItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:136.0/255 green:136.0/255 blue:136.0/255 alpha:1], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Arial" size:12.0], NSFontAttributeName,
      nil]
                              forState:UIControlStateNormal];
    
    
    itemsArray = [[NSArray alloc] initWithObjects:firstItem, secondItem, nil];
    
    tabBar= [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [tabBar setBarTintColor:[UIColor blackColor]];
    [tabBar setItems:itemsArray animated:YES];
    
    tabBar.delegate= self;
    [self.view addSubview:tabBar];
    
    
    //Style for tabbar
    UILabel *border= [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 2)];
    border.backgroundColor= [UIColor colorWithRed:236.0/255 green:1.0/255 blue:140.0/255 alpha:1];
    [self.view addSubview:border];
    
    
    
    //Style for tabbar
    borderSelected2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320/([tabBar items].count), 5)];
    borderSelected2.backgroundColor= [UIColor colorWithRed:236.0/255 green:1.0/255 blue:140.0/255 alpha:1];
    [self.view addSubview:borderSelected2];
    
    
    selectBarPosition= (float)320/[tabBar items].count;
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    float cPosition= (item.tag- 1)* selectBarPosition;
    [preItem1 setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:136.0/255 green:136.0/255 blue:136.0/255 alpha:1], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Arial" size:12.0], NSFontAttributeName,
      nil]
                           forState:UIControlStateNormal];
    
    
    [item setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:236.0/255 green:1.0/255 blue:140.0/255 alpha:1], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Arial" size:12.0], NSFontAttributeName,
      nil]
                        forState:UIControlStateNormal];
    
    
    
    
    
    
    [UIView beginAnimations:nil context:NULL];
    borderSelected2.frame= CGRectMake(cPosition, 35, 320/([tabBar items].count), 5);
    [UIView setAnimationDuration:2];
    [UIView commitAnimations];
    
    preItem1= item;
}






#pragma keyboard show and hide
// progress for keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void) keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary * userInfo = aNotification.userInfo;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];

    if (!viewIsResized) {
        CGRect frame = self.view.frame;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        frame.origin.y -= keyboardFrame.size.height;
        self.view.frame = frame;
        viewIsResized = YES;
    }
    
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)aNotification
{
    NSDictionary * userInfo = aNotification.userInfo;
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    if (viewIsResized) {
        CGRect frame = self.view.frame;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        
        frame.origin.y += keyboardFrame.size.height;
        self.view.frame = frame;  
        [UIView commitAnimations];
        viewIsResized = NO;
    }    
}


// endprogrss keyboard
-(void) menuButtonClick{
    
    [[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectNull withName:@"mainMenu" withDuration:0.2 delay:0];
    
}

#pragma listFanzone
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[dataFanzone valueForKey:@"name"] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FanzoneCell *cell = (FanzoneCell *)[tableView dequeueReusableCellWithIdentifier:@"FanzoneCellCell"];
    if (cell == nil) {
        cell = [[FanzoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FanzoneCellCell"];
    }
    // Just want to test, so I hardcode the data
    cell.avarta.image = [UIImage imageNamed:[[dataFanzone valueForKey:@"avarta"] objectAtIndex:indexPath.row]];

    cell.fanName.text = [[dataFanzone valueForKey:@"name"] objectAtIndex:indexPath.row];
    cell.lastTimeMessage.text = [[dataFanzone valueForKey:@"lasttime"] objectAtIndex:indexPath.row];
    cell.message.text = [[dataFanzone valueForKey:@"message"] objectAtIndex:indexPath.row];
    
    cell.backgroundColor= [UIColor clearColor];
    if (!(indexPath.row%2)) {
        cell.backgroundColor= [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    }
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}



- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
