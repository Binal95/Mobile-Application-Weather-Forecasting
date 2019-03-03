//
//  RootViewController.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 10/17/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
//#import "RootViewControllerDelegate.h"
#import "FavViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic,strong) UIPageViewController *PageViewController;
@property (nonatomic,strong) NSMutableArray *arrPageTitles;
@property (nonatomic,strong) NSMutableArray *arrPageImages;
@property (nonatomic,strong) NSMutableArray *windarray;
@property (nonatomic,strong) NSMutableArray *pressurearray;
@property (nonatomic,strong) NSMutableArray *humidityarray;
@property (nonatomic,strong) NSMutableArray *humidarray;
@property (nonatomic,strong) NSMutableArray *temparray;
@property (nonatomic,strong) NSMutableArray *todayarray;
@property (nonatomic,strong) NSMutableArray *tommorowarray;
@property (nonatomic,strong) NSMutableArray *datarray;

@property (nonatomic,strong) NSMutableArray *firstDayForeCastarray;
@property (nonatomic,strong) NSMutableArray *secondDayForeCastarray;
@property (nonatomic,strong) NSMutableArray *thirdDayForeCastarray;
@property (nonatomic,strong) NSMutableArray *forthDayForeCastarray;
@property (nonatomic,strong) NSMutableArray *fifthDayForeCastarray;

//R
@property (nonatomic,retain) NSMutableArray *mainarray;
@property (nonatomic,retain) NSMutableArray *descarray;
//--

@property (nonatomic,strong) NSMutableArray *foreCastData;
- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index;

- (IBAction)btnStartAgain:(id)sender;
@property (nonatomic,strong) NSNumber *firstDayTemp;
@property (nonatomic,strong) NSNumber *firstDayCount;
@property (nonatomic,strong) NSNumber *secondDayTemp;
@property (nonatomic,strong) NSNumber *secondDayCount;
@property (nonatomic,strong) NSNumber *thirdDayTemp;
@property (nonatomic,strong) NSNumber *thirdDayCount;
@property (nonatomic,strong) NSNumber *forthDayTemp;
@property (nonatomic,strong) NSNumber *forthDayCount;
@property (nonatomic,strong) NSNumber *fifthDayTemp;
@property (nonatomic,strong) NSNumber *fithDayCount;

//R
//@property(weak)id <RootViewControllerDelegate> delegate;
//-(void)passTemp;

//--
@end
