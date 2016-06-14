//
//  AppDelegate.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "RearTableViewController.h"


@interface AppDelegate()<SWRevealViewControllerDelegate>
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.mainNavigationController  = navigationController;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    */
    /*
    RearViewController *rearViewController = [[RearViewController alloc] init];
	
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];

    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
*/
    
    
	UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window = window;
    
	RearTableViewController *rearViewController = [[RearTableViewController alloc] init];
//    FrontViewControllerImage *frontViewController = [[FrontViewControllerImage alloc] init];
  
    self.viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    SWRevealViewController *mainRevealController =
    [[SWRevealViewController alloc] initWithRearViewController:rearViewController frontViewController:self.viewController];
    
    mainRevealController.rearViewRevealWidth = 240;
    mainRevealController.rearViewRevealOverdraw = 0;
    mainRevealController.bounceBackOnOverdraw = NO;
    mainRevealController.stableDragOnOverdraw = YES;
    [mainRevealController setFrontViewPosition:FrontViewPositionRight];
    
    mainRevealController.delegate = self;
    
	self.window.rootViewController = mainRevealController;
	[self.window makeKeyAndVisible];
	return YES;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma - SWRevealViewController delegate methods

- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}


- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}

- (void)revealController:(SWRevealViewController *)revealController willRevealRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didRevealRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willHideRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didHideRearViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willShowFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didShowFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController willHideFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}

- (void)revealController:(SWRevealViewController *)revealController didHideFrontViewController:(UIViewController *)viewController
{
    NSLog( @"%@: %@", NSStringFromSelector(_cmd), viewController);
}






@end
