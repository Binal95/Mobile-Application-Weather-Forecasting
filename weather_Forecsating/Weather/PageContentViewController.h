//
//  ViewController.h
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "RootViewControllerDelegate.h"


@interface PageContentViewController : UIViewController <CLLocationManagerDelegate>//,RootViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblCF;
@property (weak, nonatomic) IBOutlet UIButton *btnCF;
- (IBAction)btnActCF:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ivScreenImage;
@property (weak, nonatomic) IBOutlet UILabel *lblScreenLabel;

@property NSUInteger pageIndex;
@property NSString *imgFile;
@property NSString *txtTitle;
@property NSString *cityName1;
@property NSString *pressure1;
@property NSString *wind1;
@property NSString *humidity1;
@property NSString *temper;
@property NSString *tod;
@property NSString *dat1;
@property NSString *first;
@property NSString *second;
@property NSString *third;
@property NSString *forth;
@property NSString *fifth;
//R
@property NSString *main;
@property NSString *desc;
//--

@end

