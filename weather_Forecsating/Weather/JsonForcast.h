//
//  JsonForcast.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 11/19/18.
//  Copyright © 2018 Aron Beaver. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonForcast : NSObject
@property NSMutableArray *array;
-(void)parseData;
-(id)initWithArray: (NSMutableArray *) array;


@end

NS_ASSUME_NONNULL_END
