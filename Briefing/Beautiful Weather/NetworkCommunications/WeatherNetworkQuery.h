//
//  WeatherNetworkLayer.h
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#pragma mark - Header Includes

#import <Foundation/Foundation.h>
#import "SharedTypes.h"

#pragma mark - Defintions

@class LocalWeather;

typedef enum
{
    SUCCESS
}WeatherLookupFailureCode;

@protocol WeatherNetworkLayerDelegate <NSObject>

- (void) weatherLookupSuccess:(LocalWeather*) localWeather;
- (void) weatherLookupFailure:(WeatherLookupFailureCode) failureCode;


@end


@interface WeatherNetworkQuery : NSObject

+ (WeatherNetworkQuery*) sharedInstance;

- (void) localWeatherServiceWithLatitude:(double) lat andLongitude: (double) lon;


@property (nonatomic, assign) id<WeatherNetworkLayerDelegate> delegate;

@end
