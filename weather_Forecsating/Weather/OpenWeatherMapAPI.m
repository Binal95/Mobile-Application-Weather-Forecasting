//
//  OpenWeatherMapAPI.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/3/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "OpenWeatherMapAPI.h"
#import "Keys.h"
#import "WeatherData.h"
#import "CityFavDML.h"
#import "ForcastWeatherData.h"

@implementation OpenWeatherMapAPI
@synthesize array;
@synthesize cast;
@synthesize tryobject;

-(id)initWithArray: (NSMutableArray *) array{
    self = [super init];
    if (self) {
        self.array = array;
    }
    return self;
}
+ (OpenWeatherMapAPI *)sharedInstance {
    static OpenWeatherMapAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OpenWeatherMapAPI alloc] init];
    });
    return sharedInstance;
}

+ (void)fetchCurrentWeatherDataForLocation:(NSString *)location completion:(void(^)(WeatherData *weatherData))completion failure:(void(^)(NSError* error))failure{
    //float latitude = location.coordinate.latitude;

    //float longitude = location.coordinate.longitude;
    //NSLog(@"%f",latitude);
    //NSLog(@"%f",latitude);
  //  NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                          //  stringForKey:@"CurrentCityName"];
    NSString *savedValue=location;
    //NSLog(savedValue);
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=imperial&appid=%s",savedValue, kOpenWeatherMapAPIKey];

   // NSString *urlString;
 
    //if (v.btnCF.isSelected)// && v.lblCF.text isEqual:@"C")
    {
   // urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=houston&units=imperial&appid=%s", kOpenWeatherMapAPIKey];
        //v.lblCF.text=@"F";
    NSLog(@"F-%@", urlString);
     }
    //else if (v.btnCF.isSelected)// && [v.lblCF.text isEqual:@"F"])
  /*  {
        
        urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=houston&units=metric&appid=%s", kOpenWeatherMapAPIKey];
        v.lblCF.text=@"C";
        NSLog(@"C-%@", urlString);
    }*/
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error) {
            failure(error);
        } else {
            WeatherData *weather = [[WeatherData alloc] initWithJSON:data];
            completion(weather);
        }
        
    }] resume];

}
+ (WeatherData *)fetchCurrentWeatherDataForLocation1:(NSString *)location {
   
    NSString *savedValue=location;
    //NSLog(savedValue);
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=imperial&appid=%s",savedValue, kOpenWeatherMapAPIKey];
    NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];

    NSData *data = [NSData dataWithContentsOfURL:url];
   
           WeatherData *weather = [[WeatherData alloc] initWithJSON:data];
    
            return weather;
    
        

        
}

+ (WeatherData*)fetchForeCastWeatherDataForLocation1:(NSString *)location {
    
    //NSError *error;
        NSString *savedValue=location;
    //NSMutableArray *arraynew = [[NSMutableArray alloc]init];
    NSString *urlString = [[@"http://api.openweathermap.org/data/2.5/forecast?q=" stringByAppendingString:savedValue] stringByAppendingString:@"&units=imperial&APPID=a0a0e5e6d1ded0c79e853990c86f957b"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
     NSData *data = [NSData dataWithContentsOfURL:url];
    //NSMutableDictionary *fullData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
   //[[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:ourBlock] resume];
  //  [ForcastWeatherData placeJSONGetRequest: savedValue withHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
       WeatherData *forecastData = [[WeatherData alloc]forcastingWithJSON:data];
    return forecastData;
   // }];
    
   
        /* NSMutableDictionary *fullData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
       
         NSArray* forcastList = fullData[@"list"];
         NSDictionary *temp = [[NSDictionary alloc]init];
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-dd-MM HH:MM:SS"];
         
         for (NSDictionary* forecastDic in forcastList)
         {
            
            // NSArray *weather = forecastDic[@"weather"];
             temp = forecastDic[@"main"];
             //NSLog(temp[@"temp_max"]);
             // forecastData.date = [dateFormatter dateFromString:(NSString *)forecastDictionary[@"dt_txt"]];
             forecastData.date =[dateFormatter dateFromString:forecastDic[@"dt_txt"]];
           
            // forecastData.highTemp = temp[@"temp_max"];
            // forecastData.lowTemp = temp[@"temp_min"];
            // forecastData.humidity = temp[@"humidity"];
             //forecastData.pressure = temp[@"pressure"];
             forecastData.tempForecast = temp[@"temp"];
         
        
              
            
           [arraynew addObject:forecastData];
           
         // double avgtemp = [arraynew ]
            // [self.array addObject:forecastData];
         }
     

     }];
 return arraynew;*/
        
  
}

@end
