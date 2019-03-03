//
//  JSONParser.m
//  test
//
//  Created by Patel, Binal Shaileshkumar on 11/18/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "JSONParser.h"
#import "FetchWeatherData.h"
#import "WeatherData.h"

@implementation JSONParser
-(id)initWithArray: (NSMutableArray *) array{
    self = [super init];
    if (self) {
        self.array = array;
    }
    return self;
}
-(void)parseDataFor{
    [FetchWeatherData placeJSONGetRequest:@"Houston" withHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSMutableDictionary *fullData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        NSArray* forecastList = fullData[@"list"];
        NSDictionary *temp = [[NSDictionary alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        
        for (NSDictionary* forecastDictionary in forecastList) {
            
            WeatherData *forecastData = [[WeatherData alloc] init];
            NSArray *weather = forecastDictionary[@"weather"];
            temp = forecastDictionary[@"main"];
            //NSLog(temp[@"temp_max"]);
           // forecastData.date = [dateFormatter dateFromString:(NSString *)forecastDictionary[@"dt_txt"]];
            forecastData.date = [dateFormatter dateFromString:forecastDictionary[@"dt_txt"]];
            forecastData.highTemp = temp[@"temp_max"];
            forecastData.lowTemp = temp[@"temp_min"];
            forecastData.humidity = temp[@"humidity"];
            forecastData.pressure = temp[@"pressure"];
            forecastData. temp = temp[@"temp"];
            
            for (NSDictionary* weatherDictionary in weather) {
                forecastData.weatherDescription = weatherDictionary[@"description"];
            }
            
            [_array addObject:forecastData];
        }        
    }];
}
@end

