//
//  ForcastWeatherData.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 11/19/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "ForcastWeatherData.h"
#import "WeatherData.h"

@implementation ForcastWeatherData
+(void)placeJSONGetRequest: (NSString *) location withHandler: (void  (^) ( NSData *darta, NSURLResponse *response, NSError *error))ourBlock {
 NSString *urlString = [[@"http://api.openweathermap.org/data/2.5/forecast?q=" stringByAppendingString:location] stringByAppendingString:@"&units=imperial&APPID=a0a0e5e6d1ded0c79e853990c86f957b"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:ourBlock] resume];
}

@end
