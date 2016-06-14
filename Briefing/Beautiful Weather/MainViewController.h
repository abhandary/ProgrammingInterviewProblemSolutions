//
//  ViewController.h
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/2013.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController 

- (IBAction) btnRefreshTapped:(id)sender;
- (IBAction) btnSettingsTapped:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton*     refreshButton;
@property (nonatomic, retain) IBOutlet UIImageView*  backgroundImageView;
@property (nonatomic, retain) IBOutlet UIButton*     revealButton;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIImageView*  weatherImageView;
@property (nonatomic, retain) IBOutlet UIImageView*  weatherConditionImageView;
@property (nonatomic, retain) IBOutlet UIWebView*    weatherConditionWebView;
@property (nonatomic, retain) IBOutlet UILabel*      currentTemperatureLabel;
@property (nonatomic, retain) IBOutlet UILabel*      currentCityLabel;

@end
