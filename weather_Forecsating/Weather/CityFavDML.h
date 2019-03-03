

#import <Foundation/Foundation.h>

@interface CityFavDML : NSObject

+ (NSMutableArray *)fetchCities;
+ (bool)addFavCity:(NSString *)City;
+ (bool)deleteCity:(NSString *)wordString;


@end
