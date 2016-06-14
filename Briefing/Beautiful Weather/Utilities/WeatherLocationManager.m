//
//  WeatherLocationManager.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/24/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import "WeatherLocationManager.h"

#import <CoreLocation/CoreLocation.h>


NSString* kBeautifulWeatherLocationUpdate = @"kBeautifulWeatherLocationUpdate";


@interface WeatherLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic) double lon;
@property (nonatomic) double lat;


@end

@implementation WeatherLocationManager



+ (WeatherLocationManager *)sharedInstance
{
    static WeatherLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WeatherLocationManager alloc] init];
    });
    return sharedInstance;
}

+ (void) initialize
{
    // init cl location manager
    [self sharedInstance].locationManager = [[CLLocationManager alloc] init];
    [self sharedInstance].locationManager.delegate = [self sharedInstance];
    [self sharedInstance].locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self sharedInstance].locationManager.distanceFilter = kCLDistanceFilterNone;
    [[self sharedInstance].locationManager startUpdatingLocation];

    //@todo: update lat and lon using last seen or default lat lon
}



+ (LocationCoordinate2D) getLocation
{
    LocationCoordinate2D loc = {[self sharedInstance].lat, [self sharedInstance].lon};
    return loc;
}

#pragma mark LocationManager Delegate methods

-(void) locationManager: (CLLocationManager *)manager didUpdateToLocation: (CLLocation *) newLocation
           fromLocation: (CLLocation *) oldLocation
{
    DEBUG_LOGX();
    CLLocation *location = nil; // [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    self.lon = coordinate.longitude;
    self.lat = coordinate.latitude;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kBeautifulWeatherLocationUpdate
                                                        object:nil];

    [manager stopUpdatingLocation];
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}


@end
