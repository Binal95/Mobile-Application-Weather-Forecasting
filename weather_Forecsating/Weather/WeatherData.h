//
//  WeatherData.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/5/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *main;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *temp_min;
@property (strong, nonatomic) NSNumber *temp_max;
@property (strong, nonatomic) NSNumber *wind_speed;
@property (strong, nonatomic) NSNumber *wind_deg;

//R
- (NSString *)mainString;
- (NSString *)descString;
//-- 
@property NSDate *date;
@property NSNumber *tempForecast;

-(id)initWithJSON:(NSData *)jsonData;
-(id)forcastingWithJSON:(NSData *)jsonData;

- (NSString *)tempString;
- (NSString *)wind;
- (NSString *)press;
- (NSString *)humdity;
- (NSString *)tomorrow;
- (NSString *)dat;

-(id)initWithDate:(NSDate *)date temp:(NSNumber *)tempForecast ;
@property NSMutableDictionary* array;
@property NSArray* fulldata;
@end
