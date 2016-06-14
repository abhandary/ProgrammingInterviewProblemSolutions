//
//  LocalWeather.m
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/24/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import "LocalWeather.h"

@implementation LocalWeather

+ (NSString*) weatherLookupEnumToString:(WeatherLookupConstants) lookup
{
    switch (lookup){
        case WEATHER_DATE:
            return @"date";
        case PRECIP_MM:
            return @"precipMM";
        case TEMP_C:
            return @"temp_C";
        case TEMP_F:
            return @"temp_F";
        case TEMP_MAX_C:
            return @"tempMaxC";
        case TEMP_MAX_F:
            return @"tempMaxF";
        case TEMP_MIN_F:
            return @"tempMinF";
        case TEMP_MIN_C:
            return @"tempMinC";
        case WEATHER_CODE:
            return @"weatherCode";
        case WEATHER_DESC:
            return @"weatherDesc";
        case WIND_SPEED_MILES:
            return @"windspeedMiles";
    }
    return @"";
}


- (NSString*) currentWeatherConditionForAttribute:(WeatherLookupConstants) lookup
{
    return [self.currentCondition objectForKey:[LocalWeather weatherLookupEnumToString:lookup]];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[CURRENT-CONDTION:%@], [WEATHER ARRAY:%@]", self.currentCondition, self.weatherArray];
}


@end
