//
//  JSONParser.h
//  test
//
//  Created by Patel, Binal Shaileshkumar on 11/18/18.
//  Copyright © 2018 Patel, Binal Shaileshkumar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONParser : NSObject
@property NSMutableArray *array;
-(void)parseDataFor;
-(id)initWithArray: (NSMutableArray *) array;
@end

NS_ASSUME_NONNULL_END
