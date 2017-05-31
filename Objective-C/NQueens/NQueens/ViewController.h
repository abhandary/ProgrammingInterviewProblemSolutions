//
//  ViewController.h
//  NQueens
//
//  Created by Akshay Bhandary on 4/29/15.
//  Copyright (c) 2015 Axa Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(IBAction) solveButtonPress:(id)sender;
@property (nonatomic, retain) IBOutlet UITextField *boardSizeTextField;


@end

