//
//  WeatherNetworkLayer.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import "WeatherNetworkQuery.h"
#import "WeatherUtilities.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "LocalWeather.h"

@interface WeatherNetworkQuery ()

@end

@implementation WeatherNetworkQuery

+ (WeatherNetworkQuery *)sharedInstance
{
    static WeatherNetworkQuery *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WeatherNetworkQuery alloc] init];
    });
    return sharedInstance;
}


- (LocalWeather*) parseLocalWeather:(NSDictionary *)dictonary
{
    @try
    {
        LocalWeather *locWeather = [[LocalWeather alloc] init];
        locWeather.currentCondition = [[dictonary objectForKey:@"current_condition"] objectAtIndex:0];
        locWeather.weatherArray     = [dictonary objectForKey:@"weather"];
        return locWeather;
    }
    @catch (id exception)
    {
        assert(0);
        DEBUG_LOG(@"Exception while parsing local weather [%@]", exception);
        // @todo: flurry log error
        return nil;
    }
}


#pragma - weather network layer delegate routines

- (void) localWeatherQuerySuccess:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *values=(NSDictionary *) [responseString JSONValue];
    NSDictionary *weatherDictionary=[values objectForKey:@"data"];
    LocalWeather* locWeather = [self parseLocalWeather:weatherDictionary];
    
    [self.delegate weatherLookupSuccess:locWeather];
}


- (void) localWeatherQueryFailure:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    DEBUG_LOG(@"response: %@", responseString);
    
    WeatherLookupFailureCode failureCode = 0;
    [self.delegate weatherLookupFailure:failureCode];
}


#pragma mark - public weather query routines

- (void) localWeatherServiceWithLatitude:(double) lat andLongitude: (double) lon
{
    
    const NSString *weatherURLFormat = [WeatherUtilities weatherQueryByCoordinatesURLFormat];
    
    NSString* coordinatesString = [NSString stringWithFormat:@"%lf,%lf", lat, lon];
    NSString* finalURL = [NSString stringWithFormat:(NSString*)weatherURLFormat, coordinatesString];
    
    NSURL *url = [NSURL URLWithString:finalURL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDidFinishSelector:@selector(localWeatherQuerySuccess:)];
    [request setDidFailSelector:@selector(localWeatherQueryFailure:)];
    [request setDelegate:self];
    [request startAsynchronous];
}



@end
