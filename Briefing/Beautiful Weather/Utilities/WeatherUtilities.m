//
//  WeatherUtilities.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/17/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import "WeatherUtilities.h"


// sample query: http://api.worldweatheronline.com/free/v1/weather.ashx?q=37.787702%2C-122.405243&format=json&num_of_days=5&key=xkq544hkar4m69qujdgujn7w

static const NSString* FREE_WEATHER_API_SEARCH_URL = @"http://api.worldweatheronline.com/free/v1/weather.ashx?q=%@&num_of_results=3&format=json&num_of_days=5&key=xkq544hkar4m69qujdgujn7w";

@implementation WeatherUtilities


+ (const NSString*) weatherQueryByCoordinatesURLFormat
{
    return FREE_WEATHER_API_SEARCH_URL;
}

@end
