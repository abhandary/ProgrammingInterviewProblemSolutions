//
//  LocalWeather.h
//  Beautiful Weather
//
//  Created by Akshay Bhandary on 11/24/13.
//  Copyright (c) 2013 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    WEATHER_DATE = 0,
    PRECIP_MM    = 1,
    TEMP_C       = 2,
    TEMP_F       = 3,
    TEMP_MAX_C   = 4,
    TEMP_MAX_F   = 5,
    TEMP_MIN_F   = 6,
    TEMP_MIN_C   = 7,
    WEATHER_CODE = 8,
    WEATHER_DESC = 9,
    WIND_SPEED_MILES = 10
}WeatherLookupConstants;

@interface LocalWeather : NSObject

- (NSString*) currentWeatherConditionForAttribute:(WeatherLookupConstants) lookup;

@property (nonatomic, retain) NSMutableDictionary *currentCondition;
@property (nonatomic, retain) NSMutableArray      *weatherArray;

@end
