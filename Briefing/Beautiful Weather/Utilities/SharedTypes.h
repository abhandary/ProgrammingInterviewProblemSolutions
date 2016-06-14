//
//  SharedTypes.h
//  BeautifulWeather
//
//  Created by Akshay Bhandary on 3/1/14.
//  Copyright (c) 2014 Akshay Bhandary. All rights reserved.
//

#ifndef BeautifulWeather_SharedTypes_h
#define BeautifulWeather_SharedTypes_h

#define DEBUG_LOGX(string) \
if (DEBUG) { \
NSLog(@"%s: "string, __PRETTY_FUNCTION__); \
}

#define DEBUG_LOG(format, ...) \
if (DEBUG) { \
NSLog(@"%s: "format, __PRETTY_FUNCTION__, __VA_ARGS__); \
}

typedef struct {
	double latitude;
	double longitude;
} LocationCoordinate2D;


#endif
