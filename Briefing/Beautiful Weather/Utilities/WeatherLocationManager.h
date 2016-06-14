//
//  WeatherLocationManager.h
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/24/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#pragma mark - Header Includes

#import <Foundation/Foundation.h>
#import "SharedTypes.h"

#pragma mark - Definitions

extern NSString* kBeautifulWeatherLocationUpdate;



@interface WeatherLocationManager : NSObject


+ (void) initialize;
+ (LocationCoordinate2D) getLocation;

@end
