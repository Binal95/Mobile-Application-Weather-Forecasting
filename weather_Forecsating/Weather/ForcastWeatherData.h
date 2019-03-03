//
//  ForcastWeatherData.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 11/19/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForcastWeatherData : NSObject <NSURLConnectionDelegate>
+(void)placeJSONGetRequest: (NSString *) location withHandler: (void  (^) ( NSData *darta, NSURLResponse *response, NSError *error))ourBlock;

@end

NS_ASSUME_NONNULL_END
