//
//  FavViewController.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 10/12/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface FavViewController : UITableViewController 
{
    
    NSMutableArray* cityArray;
}
//R
@property NSString *main;
@property NSString *desc;
@property NSString *temp;
//@property (strong, nonatomic) NSMutableArray *tempval;
//--
@end

NS_ASSUME_NONNULL_END
