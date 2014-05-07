//
//  AUIFreedomController.m
//  TB_ViewContainment
//
//  Created by Huy Phan on 4/25/14.
//  Copyright (c) 2014 Bitwaker. All rights reserved.
//

#import "AUIFreedomController.h"

@interface AUIFreedomController ()

@end

@implementation AUIFreedomController

+(id)sharedFreedomController{
    static AUIFreedomController *sharedFreedomController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFreedomController = [[self alloc] init];
    });
    return sharedFreedomController;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.viewControllers = [[NSMutableArray alloc] init];
    self.viewControllerNames = [[NSMutableDictionary alloc] init];
}


- (int)addChildViewController:(UIViewController *)viewController withFrame:(CGRect)frame
{
    [self.viewControllers addObject:viewController];
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:viewController];
    
    //2. Define the detail controller's view size default
    if(CGRectIsNull(frame))frame = self.view.frame;
    viewController.view.frame = frame;
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.view addSubview:viewController.view];
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [viewController didMoveToParentViewController:self];
    
    // return index
    int count = (int)[self.viewControllers count];
    return count - 1;
}

- (int)addChildViewController:(UIViewController *)viewController withName:(NSString *)name withFrame:(CGRect)frame
{
    // dau tien la van add child vao nhu binh thuong
    int newChildViewControllerIndex = [self addChildViewController:viewController  withFrame:frame];
    
    // neu nhu co ten thi moi cho phep set ten
    if(name != NULL && [name length] > 0)
    {
        // sau do se luu lai cai index nay bang 1 cai ten
        [self.viewControllerNames setObject:@(newChildViewControllerIndex) forKey:name];
    }
    
    return newChildViewControllerIndex;
}

- (id)getChildViewControllerWithName:(NSString *)name
{
    // dau tien la get ra xem coi cai thang AUIFreedom nao la thang cha cua cai thang nay
    AUIFreedomController *searchingFreedomController = [self getAUIFreedomParrentOfViewControllerWithName:name];
    
    // neu nhu get khong duoc thang cha thi bo tay
    if(searchingFreedomController == NULL)
        return NULL;
    
    // sau do xem coi index cua thang viewController la gi
    int indexOfViewController = [(NSString *)[searchingFreedomController.viewControllerNames objectForKey:name] intValue];
    
    // return thoi
    return [searchingFreedomController.viewControllers objectAtIndex:indexOfViewController];
}

- (AUIFreedomController *)getAUIFreedomParrentOfViewControllerWithName:(NSString *)name
{
    // bay gio, boi vi khong biet cai thang AUIFreedomController nao la cha cua 1 thang view controller bat ky
    // cho nen phai dung de quy de ma search
    
    // dau tien la search xem coi trong cai AUI freedom nay (self) coi co thang nao co ten nay hay khong
    // neu nhu co thi return luon (va cung chinh la thang nay luon chu ai nua)
    NSString *childViewControllerIndexString = [self.viewControllerNames objectForKey:name];
    if(childViewControllerIndexString != NULL)
        return self;
    
    
    // con neu nhu khong co thi phai test thu xem coi trong nhung thang con cua no
    // co cai thang nao la AUIFreedom hay khong
    // neu nhu co thi se test tren nhung thang nay
    
    // tao 1 cai bien de luu
    AUIFreedomController *searchingFreedomController;
    for(int i = 0;i<[self.viewControllers count];i++)
    {
        // get ra choi
        UIViewController *childViewController = [self.viewControllers objectAtIndex:i];
        AUIFreedomController *childFreedomController;
        
        // neu nhu no la 1 thang AUIFreedom thi se tinh tiep
        if([childViewController isKindOfClass:[AUIFreedomController class]])
        {
            childFreedomController = (AUIFreedomController *)childViewController;
            searchingFreedomController = [childFreedomController getAUIFreedomParrentOfViewControllerWithName:name];
            
            // neu nhu tim ra duoc roi thi return luon
            if(searchingFreedomController != NULL)
                return searchingFreedomController;
        }
        
    }
    
    
    // truong hop khong co thi thi return null luon
    return NULL;
}

- (BOOL)removeChildViewControllerAtIndex:(int)index
{
    return YES;
}

- (void)changeChildViewControllerFrame:(CGRect)frame atIndex:(int)index
{
    UIViewController *obj = [self.viewControllers objectAtIndex:index];
    
    if(CGRectIsNull(frame))frame = self.view.frame;
    
    obj.view.frame = frame;
}
- (void)changeChildViewControllerFrame:(CGRect)frame atIndex:(int)index withDuration:(float)duration delay:(float)delay
{
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{[self changeChildViewControllerFrame:frame atIndex:index];}
                                  completion:nil];
}

-(void)changeChildViewControllerFrame:(CGRect)frame withName:(NSString *)name
{
    // dau tien la phai get ra xem coi thang AUIFreedom nao la thang truc tiep
    // quan ly cai viewController voi cai ten nay
    AUIFreedomController *searchingFreedomController = [self getAUIFreedomParrentOfViewControllerWithName:name];
    if(searchingFreedomController == NULL)return;
    
    // sau do la lay ra cai index
    NSObject *indexOfViewControllerObject = [searchingFreedomController.viewControllerNames objectForKey:name];
    if(indexOfViewControllerObject == NULL)return;
    
    // chuyen qua thang int index va change thoi
    int indexOfViewController = [(NSString *)indexOfViewControllerObject intValue];
    [searchingFreedomController changeChildViewControllerFrame:frame atIndex:indexOfViewController];
}
-(void)changeChildViewControllerFrame:(CGRect)frame withName:(NSString *)name withDuration:(float)duration delay:(float)delay
{
    // dau tien la phai get ra xem coi thang AUIFreedom nao la thang truc tiep
    // quan ly cai viewController voi cai ten nay
    AUIFreedomController *searchingFreedomController = [self getAUIFreedomParrentOfViewControllerWithName:name];
    if(searchingFreedomController == NULL)return;
    // sau do la lay ra cai index
    NSObject *indexOfViewControllerObject = [searchingFreedomController.viewControllerNames objectForKey:name];
    if(indexOfViewControllerObject == NULL)return;
    
    // chuyen qua thang int index va change thoi
    int indexOfViewController = [(NSString *)indexOfViewControllerObject intValue];
    [searchingFreedomController changeChildViewControllerFrame:frame atIndex:indexOfViewController withDuration:duration delay:delay];
}

- (CGRect)getChildViewControllerFrameAtIndex:(int)index
{
    UIViewController *obj = [self.viewControllers objectAtIndex:index];
    return obj.view.frame;
}

- (int)getHeight
{
    return self.view.frame.size.height;
}
- (int)getWidth
{
    return self.view.frame.size.width;
}


- (void) buildInterfaceFromXMLFile:(NSString *)name
{
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"xml"];
    NSData *xmlFileData = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    //NSLog(@"xmlFileData: %@", xmlFileData);
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlFileData];
    
    // bay gio se reset stack
    parsingViewControllersStack = [[NSMutableArray alloc] init];
    parsingCurrentElement = [[NSString alloc] init];
    
    [xmlParser setDelegate:self];
    [xmlParser parse];
}




// ============
// XML DELEGATE
// ============


// Simple error checking
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    //NSLog(@"Error parsing XML: Error code %i", [parseError code]);
    xmlErrorParsing = YES;
}

// Start a element
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    // uu tien element dat biet
    // "self tuc la cai AUIFreedom hien tai ne
    if([elementName isEqualToString:@"self"])
    {
        [parsingViewControllersStack addObject:self];
        return;
    }
    
    // bay gio se test coi cai element name nay
    // co phai la 1 class con cua class UIViewController hay khong
    // boi vi chi support UIViewController thoi
    Class UIViewControllerKlass = NSClassFromString(elementName);
    if(UIViewControllerKlass == NULL)
        return;
    
    // tao ra 1 cai instance
    id instance = [[UIViewControllerKlass alloc] init];
    // thang lastObject
    AUIFreedomController *containerController = [parsingViewControllersStack lastObject];
    
    // xem coi co name set trong attribute hay khong
    NSString *sName = [attributeDict objectForKey:@"name"];
    
    // get ra nhung thong tin ve frame
    NSString *sLeft = [attributeDict objectForKey:@"left"];
    NSString *sRight = [attributeDict objectForKey:@"right"];
    NSString *sTop = [attributeDict objectForKey:@"top"];
    NSString *sBottom = [attributeDict objectForKey:@"bottom"];
    
    NSString *sWidth = [attributeDict objectForKey:@"width"];
    NSString *sHeight = [attributeDict objectForKey:@"height"];
    
    // mac dinh thi left, top
    int left = 0;
    if(sLeft != NULL)left = [sLeft intValue];
    int top = 0;
    if(sTop != NULL)top = [sTop intValue];
    
    // mac dinh thi width, height = full cua thang parrent cha
    int width = containerController.view.frame.size.width;
    if(sWidth != NULL)width = [sWidth intValue];
    int height = containerController.view.frame.size.height;
    if(sHeight != NULL)height = [sHeight intValue];
    
    // neu nhu truyen vao right, bottom
    // thi se set lai left, top
    if(sRight != NULL)
    {
        if(sWidth != NULL && [sWidth isEqualToString:@"auto"])
        {
            width = containerController.view.frame.size.width - left - [sRight intValue];
        }
        else
        {
            left = containerController.view.frame.size.width - width - [sRight intValue];
        }
    }

    if(sBottom != NULL)
    {
        if(sHeight != NULL && [sHeight isEqualToString:@"auto"])
        {
            height = containerController.view.frame.size.height - top - [sBottom intValue];
        }
        else
        {
            top = containerController.view.frame.size.height - height - [sBottom intValue];
        }
    }
    
    // make frame
    CGRect frame = CGRectMake(left, top, width, height);
    
    // add cai instance nay vo
    [containerController addChildViewController:instance withName:sName withFrame:frame];
    
    // sau do moi push cai instance nay vao stack
    [parsingViewControllersStack addObject:instance];
    
    
    // luu lai cai current element de ma xiu bit de con remove
    parsingCurrentElement = elementName;
    
    
    //NSLog(@"<%@>", parsingCurrentElement);
    //NSLog(@"append %@ -> %@", instance, containerController);
}

// End a element
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //NSLog(@"</%@>", elementName);
    
    if([elementName isEqualToString:parsingCurrentElement]){
       [parsingViewControllersStack removeLastObject];
        parsingCurrentElement = [[[parsingViewControllersStack lastObject] class] description];
    }
}

// Finish
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [parsingViewControllersStack removeAllObjects];
}


@end