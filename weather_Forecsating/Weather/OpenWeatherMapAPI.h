//
//  OpenWeatherMapAPI.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/3/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherData.h"

@interface OpenWeatherMapAPI : NSObject
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableDictionary *cast;
@property (nonatomic,weak) NSUserDefaults *tryobject;


-(id)initWithArray: (NSMutableArray *) array;
+ (OpenWeatherMapAPI *)sharedInstance;

+(void)fetchCurrentWeatherDataForLocation:(NSString *)location completion:(void(^)(WeatherData *weatherData))completion failure:(void(^)(NSError* error))failure;
+ (WeatherData *)fetchCurrentWeatherDataForLocation1:(NSString *)location;
+ (WeatherData*)fetchForeCastWeatherDataForLocation1:(NSString *)location;
@end
