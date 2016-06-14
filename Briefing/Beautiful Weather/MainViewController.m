//
//  ViewController.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//



#import <CoreText/CoreText.h>

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "WeatherLocationManager.h"
#import "WeatherNetworkQuery.h"
#import "LocalWeather.h"


@interface MainViewController  () <WeatherNetworkLayerDelegate>

@end


@implementation MainViewController

#pragma mark - view related

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [WeatherLocationManager initialize];
        [WeatherNetworkQuery sharedInstance].delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated) name:kBeautifulWeatherLocationUpdate object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.view addGestureRecognizer:revealController.panGestureRecognizer1];
    [self initViews];

}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


#pragma mark - initial view setup

- (void) initViews
{
    [self.view addGestureRecognizer:self.scrollView.panGestureRecognizer];

    self.weatherImageView.image = [UIImage imageNamed:@"sun.jpg"];
    
    // setup reval controller
    SWRevealViewController *revealController = self.revealViewController;
    [self.revealButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [revealController revealToggleAnimated:NO];
    
    // setup weather image view
    [self.weatherConditionWebView setBackgroundColor:[UIColor clearColor]];
    [self.weatherConditionWebView setOpaque:NO];
    self.weatherConditionWebView.hidden = NO;
    [self.scrollView addSubview:self.weatherConditionWebView];
    [self.scrollView bringSubviewToFront:self.weatherConditionWebView];
    self.weatherConditionWebView.frame = CGRectMake(230, 70, 70, 70);
    [self.weatherConditionWebView setScalesPageToFit:YES];
    

    // setup ordering of views
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.weatherImageView];
    [self.scrollView addSubview:self.currentTemperatureLabel];
    [self.view addSubview:self.revealButton];
    [self.view addSubview:self.currentCityLabel];
}


#pragma mark - button responders

- (IBAction) btnRefreshTapped:(id)sender
{
    [self refreshWeather];
}

- (IBAction) btnSettingsTapped:(id)sender
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Weather Routines

- (void) updateTemperature: (LocalWeather*) localWeather
{
    NSString* tempC = [localWeather currentWeatherConditionForAttribute:TEMP_C];
    NSMutableAttributedString * attributedTempStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%c", tempC, @"\u00B0", 'C']];
    
    [attributedTempStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Optima" size:37] range:NSMakeRange(0, tempC.length)];
    [attributedTempStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Optima" size:15] range:NSMakeRange(tempC.length, 1)];
    [attributedTempStr addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"2" range:NSMakeRange(tempC.length, 1)];
    [attributedTempStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Optima" size:15] range:NSMakeRange(tempC.length + 1, 1)];

    self.currentTemperatureLabel.attributedText = attributedTempStr;
}
- (void) weatherLookupSuccess:(LocalWeather*) localWeather
{
    DEBUG_LOG(@"Local Weather: %@", localWeather);
    
    NSString*  path    = [[NSBundle mainBundle] pathForResource:@"svg" ofType:@"html"];
    NSString*  content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self.view addSubview:self.weatherConditionWebView];
    self.weatherConditionWebView.delegate = self;
    
    self.weatherConditionWebView.scrollView.scrollEnabled = NO;
    self.weatherConditionWebView.scrollView.bounces = NO;
  
 
    
    [self.weatherConditionWebView loadHTMLString:content baseURL:[[NSBundle mainBundle] bundleURL]];
    
    [self updateTemperature:localWeather];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    DEBUG_LOG(@"webViewDidFailLoadWithError: %@", error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DEBUG_LOGX(@"webViewDidFinishLoad:");
      self.weatherConditionWebView.frame = CGRectMake(230, 70, 70, 70);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    DEBUG_LOGX(@"webViewDidStartLoad:");
    self.weatherConditionWebView.frame = CGRectMake(230, 70, 70, 70);    
}

- (void) weatherLookupFailure:(WeatherLookupFailureCode) failureCode
{
    DEBUG_LOG(@"failure code: %d", failureCode);
}

- (void) refreshWeather
{
    LocationCoordinate2D location = [WeatherLocationManager getLocation];
    [[WeatherNetworkQuery sharedInstance] localWeatherServiceWithLatitude:location.latitude
                                                             andLongitude:location.longitude];
    
}

#pragma mark - Location Updates

- (void) locationUpdated
{
    DEBUG_LOGX();
    [self refreshWeather];
}

@end
