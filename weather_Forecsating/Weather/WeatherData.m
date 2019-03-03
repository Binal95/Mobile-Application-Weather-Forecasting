//
//  WeatherData.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/5/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "WeatherData.h"
#import "ForcastWeatherData.h"

@implementation WeatherData
@synthesize  array;
@synthesize fulldata;
-(id)initWithDate:(NSDate *)date temp:(NSNumber *)tempForecast{
    

    self = [super init];
    
    if(self){
        _date = date;
        _tempForecast = tempForecast;
       // _weatherDescription = weatherDescription;
      // _highTemp = highTemp;
     //  _lowTemp = lowTemp;
       // _humidity = humidity;
      //  _pressure = pressure;
       
        
    }
    return self;
}

-(id)forcastingWithJSON:(NSData *)jsonData {
    
   
        NSError *error;
    
    NSMutableDictionary *fullData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
       // id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
       // if (error) {
           // NSLog(@"NSJSONSerialization failed with error: %@", [error localizedDescription]);
            //return self;
  // NSArray* forcastList = fullData[@"list"];
    fulldata = fullData[@"list"];
   /*NSDictionary *temp = [[NSDictionary alloc]init];
   // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-dd-MM HH:MM:SS"];
    for (NSDictionary* forecastDic in forcastList)
    {
        
        // NSArray *weather = forecastDic[@"weather"];
        temp = forecastDic[@"main"];
        //NSLog(temp[@"temp_max"]);
        // forecastData.date = [dateFormatter dateFromString:(NSString *)forecastDictionary[@"dt_txt"]];
       _date =[dateFormatter dateFromString:forecastDic[@"dt_txt"]];
        
        // forecastData.highTemp = temp[@"temp_max"];
        // forecastData.lowTemp = temp[@"temp_min"];
        // forecastData.humidity = temp[@"humidity"];
        //forecastData.pressure = temp[@"pressure"];
       _tempForecast = temp[@"temp"];
        
        [array setValue:_tempForecast forKey:(NSString*)_date];
        
        
        //[arraynew addObject:];
        
        // double avgtemp = [arraynew ]
        // [self.array addObject:forecastData];
    }
    */
    
    return self;
    
   
}

- (id)initWithJSON:(NSData *)jsonData {
    if (self = [super init]){
        NSError *error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (error) {
            NSLog(@"NSJSONSerialization failed with error: %@", [error localizedDescription]);
            return self;
        }
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            id idName = [jsonObject objectForKey:@"name"];
            if ([idName isKindOfClass:[NSString class]]) {_name = idName;}
            id idWeatherArr = [jsonObject objectForKey:@"weather"];
            if ([idWeatherArr isKindOfClass:[NSArray class]]) {
                id idWeather = [idWeatherArr objectAtIndex:0];
                if ([idWeather isKindOfClass:[NSDictionary class]]) {
                    id idMain = [idWeather objectForKey:@"main"];
                    if ([idMain isKindOfClass:[NSString class]]) {_main = idMain;}
                    id idDesc = [idWeather objectForKey:@"description"];
                    if ([idDesc isKindOfClass:[NSString class]]) {_desc = idDesc;}
                }
            }
            id idMainD = [jsonObject objectForKey:@"main"];
            if ([idMainD isKindOfClass:[NSDictionary class]]) {
                _temp = [NSNumber numberWithDouble: [[idMainD objectForKey:@"temp"] doubleValue]];
                
                _pressure = [NSNumber numberWithDouble: [[idMainD objectForKey:@"pressure"] doubleValue]];
                _humidity = [NSNumber numberWithDouble: [[idMainD objectForKey:@"humidity"] doubleValue]];
                _temp_min = [NSNumber numberWithDouble: [[idMainD objectForKey:@"temp_min"] doubleValue]];
                _temp_max = [NSNumber numberWithDouble: [[idMainD objectForKey:@"temp_max"] doubleValue]];
                NSLog(@"%@,%@,%@,%@,%@",_pressure,_humidity,_temp_min,_temp_max,_temp);
            }
            id idWind = [jsonObject objectForKey:@"wind"];
            if ([idWind isKindOfClass:[NSDictionary class]]) {
                _wind_speed = [NSNumber numberWithDouble:[[idWind objectForKey:@"speed"] doubleValue]];
                _wind_deg = [NSNumber numberWithDouble:[[idWind objectForKey:@"deg"] doubleValue]];
            }
        } else {
            NSLog(@"Data is not a Dictionary");
        }
    }
    return self;
}

- (NSString *)tempString {
    return [NSString stringWithFormat:@"%i°",[self.temp intValue]];
}
- (NSString *)wind {
    return [NSString stringWithFormat:@"%i°",[self.wind_speed intValue]];
}
- (NSString *)press {
    return [NSString stringWithFormat:@"%i°",[self.pressure intValue]];
}
- (NSString *)humdity {
    return [NSString stringWithFormat:@"%i°",[self.humidity intValue]];
}
- (NSString *)tomorrow {
    return [NSString stringWithFormat:@"%i°",[self.temp intValue]];
}
- (NSString *)dat {
    return [NSString stringWithFormat:@"%i°",[self.temp intValue]];
}

//R
- (NSString *)mainString {
    return self.main;
}
- (NSString *)descString {
    return self.desc;
}
//--

@end
