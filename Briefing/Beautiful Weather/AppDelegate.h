//
//  AppDelegate.h
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *viewController;
@property (retain, nonatomic) UINavigationController *mainNavigationController;


@end
