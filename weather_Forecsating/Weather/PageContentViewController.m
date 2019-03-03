//
//  ViewController.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"
#import "RootViewController.h"
#import "OpenWeatherMapAPI.h"
#import "CityFavDML.h"
#import "FavViewController.h"


#define kUpdateInterval 3600

@interface PageContentViewController ()
{
    NSMutableArray *cities;
}
@property (weak, nonatomic) IBOutlet UILabel *lblGraphics;
//@property (weak, nonatomic) IBOutlet UIImageView *ImgWeather;
- (IBAction)btnAddFavroite:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *degreesLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *wind;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *humidity;
//@property (weak, nonatomic) IBOutlet UILabel *tomorrow;
//@property (weak, nonatomic) IBOutlet UILabel *dat;
@property (weak, nonatomic) IBOutlet UILabel *lblfirstDay;
@property (weak, nonatomic) IBOutlet UILabel *lblsecondDay;
@property (weak, nonatomic) IBOutlet UILabel *lblthirdDay;
@property (weak, nonatomic) IBOutlet UILabel *lblfifthDay;

@property (weak, nonatomic) IBOutlet UILabel *lblforthDay;

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.locationManager = [[CLLocationManager alloc] init];
    [self enableLocationServices];
    self.cityName.text=self.cityName1;
    self.wind.text=self.wind1;
    self.pressure.text=self.pressure1;
    self.humidity.text=self.humidity1;
    self.degreesLabel.text=self.temper;
   // self.dat.text=self.dat1;
    //self.tomorrow.text=self.tod;
    //self.lblfirstDay.text = self.first;
    //self.lblsecondDay.text = self.second;
    //self.lblthirdDay.text = self.third;
    //self.lblforthDay.text = self.forth;
    //self.lblfifthDay.text = self.fifth;
    
    int ii= [self.first intValue];
    NSLog(@"first val Rachana:%d",ii );
    NSLog(@"first val Rachana:%@",self.first );
    //self.lblfirstDay.text = //[NSString stringWithFormat:@"%@%@", self.first, @"°"];
    //[NSString stringWithFormat:@"%@%@%@",@"1st Day: ",[NSString stringWithFormat:@"%@",self.first], @"°"];
    self.lblfirstDay.text = [NSString stringWithFormat:@"%@",self.first];
    self.lblsecondDay.text = [NSString stringWithFormat:@"%@", self.second];
    self.lblthirdDay.text = [NSString stringWithFormat:@"%@", self.third];
    self.lblforthDay.text = [NSString stringWithFormat:@"%@", self.forth];
    self.lblfifthDay.text = [NSString stringWithFormat:@"%@", self.fifth];
    
    cities=[CityFavDML fetchCities];
    
    //R-----.gif
    //NSArray *array =[NSArray arrayWithObjects:[UIImage imageNamed:@"rain.gif"], nil];
    //UIImage *image=[UIImage animatedImageNamed:@"rain.gif" duration:1.0f];
    //
    
    //R
    self.lblGraphics.text=[NSString stringWithFormat: @"%@", [self.desc capitalizedString]];
    UIImage *img;
    if ([self.desc isEqual: @"broken clouds"] || [self.desc isEqual:@"overcast clouds"])
    {
        img = [UIImage imageNamed:@"04d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"overcast.png"]];
    }
    else if ([self.desc isEqual: @"clear sky"])
    {
        img = [UIImage imageNamed:@"01d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clearSun.jpg"]];
        
        // after sunset
        //img = [UIImage imageNamed:@"01n.png"];
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clearNight.jpg"]];
    }
    else if ([self.desc isEqual: @"few clouds"])
    {
        img = [UIImage imageNamed:@"02d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fewCloudsDay.jpg"]];
        // after sunset
        //img = [UIImage imageNamed:@"02n.png"];
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fewCloudsNight.jpg"]];
    }
    else if ([self.desc isEqual: @"scattered clouds"])
    {
        img = [UIImage imageNamed:@"03d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scatteredCloudsDay.jpg"]];
        // after sunset
        //img = [UIImage imageNamed:@"03n.png"];
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"scatteredCloudsNight.jpg"]];
    }
    else if ([self.desc isEqual: @"light rain"]
             ||[self.desc isEqual: @"moderate rain"]
             ||[self.desc isEqual: @"heavy intensity rain"]
             ||[self.desc isEqual: @"very heavy rain"]
             ||[self.desc isEqual: @"extreme rain"])
    {
        img = [UIImage imageNamed:@"10d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rainDay.jpg"]];
        for (UIView *view in [self.view subviews]) {
            //Check if the view is of UILabel class
            if ([view isKindOfClass:[UILabel class]]) {
                //Cast the view to a UILabel
                UILabel *label = (UILabel *)view;
                //Set the color to label
                label.textColor = [UIColor whiteColor];
            }
        }
        //NSArray *array =[NSArray arrayWithObjects:[UIImage imageNamed:@"rain.gif_frame_00000.jpg"],[UIImage imageNamed:@"rain.gif_frame_00001.jpg"],[UIImage imageNamed:@"rain.gif_frame_00002.jpg"],[UIImage imageNamed:@"rain.gif_frame_00003.jpg"], nil];
        
        //UIImage *image=[UIImage animatedImageWithImages:array duration:1.0f];
        //self.ImgWeather.image=image;
        
        // after sunset
        //img = [UIImage imageNamed:@"10n.png"];
        
    }
    else if (([self.desc rangeOfString:@"drizzle"].location != NSNotFound
              && [self.desc rangeOfString:@"thunderstorm"].location == NSNotFound)
             || ([self.desc isEqual: @"light intensity shower rain"]
                 || [self.desc isEqual:@"shower rain"]
                 || [self.desc isEqual:@"heavy intensity shower rain"]
                 || [self.desc isEqual:@"ragged shower rain"]
                 ))
    {
        img = [UIImage imageNamed:@"09d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rainDay.jpg"]];
    }
    else if ([self.desc rangeOfString:@"thunderstorm"].location != NSNotFound)
    {
        img = [UIImage imageNamed:@"11d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"thunderstorm.jpg"]];
        for (UIView *view in [self.view subviews]) {
            //Check if the view is of UILabel class
            if ([view isKindOfClass:[UILabel class]]) {
                //Cast the view to a UILabel
                UILabel *label = (UILabel *)view;
                //Set the color to label
                label.textColor = [UIColor whiteColor];
            }
        }
    }
    else if ([self.desc rangeOfString:@"snow"].location != NSNotFound
             || [self.desc rangeOfString:@"sleet"].location != NSNotFound
             || [self.desc isEqual:@"freezing rain"])
    {
        img = [UIImage imageNamed:@"13d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"snowfall.jpg"]];
    }
    else
    {
        img = [UIImage imageNamed:@"50d.png"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mist.jpg"]];
    }
   // _ImgWeather.image=img;
    //--
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
  //  [self.view reloadInputViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Location Services

- (void)enableLocationServices {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if ([[NSDate date] timeIntervalSinceDate:self.lastUpdate] > kUpdateInterval || !self.lastUpdate) {
  
            
        
        /*[OpenWeatherMapAPI
            fetchCurrentWeatherDataForLocation:[locations lastObject]
                                    completion:^(WeatherData *weatherData) {
                                        NSLog(@"%@", weatherData);
                                        NSString *tempString = [weatherData tempString];
                                        NSString *wingData = [weatherData wind];
                                        NSString *pressData = [weatherData press];
                                        NSString *humidData = [weatherData humdity];
                                        NSString *tomoData = [weatherData tomorrow];
                                        NSString *datData = [weatherData dat];
   
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            self.degreesLabel.text = tempString;
                                            self.wind.text = @"Wind: ";
                                            self.wind.text = [self.wind.text stringByAppendingString:wingData];
                                            self.pressure.text = @"Pressure: ";
                                            self.pressure.text = [self.pressure.text stringByAppendingString:pressData];
                                            self.humidity.text = @"Humidity: ";
                                            self.humidity.text = [self.humidity.text stringByAppendingString:humidData];
                                            self.tomorrow.text = @"Tomorrow: ";
                                            self.tomorrow.text = [self.tomorrow.text stringByAppendingString:tomoData];
                                            self.dat.text = @"After 2 days: ";
                                            self.dat.text = [self.dat.text stringByAppendingString:datData];
                                            self.lastUpdate = [NSDate date];
                                            
                                        });
                                        }
                                    failure:^(NSError *error) {
                                        NSLog(@"Failed: %@",error);
                                    }
        ];*/
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
                       
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                           
                       }
                       
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       NSLog(@"placemark.country %@",placemark.country);
                       NSLog(@"placemark.postalCode %@",placemark.postalCode);
                       NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
                       NSLog(@"placemark.locality %@",placemark.locality);
                       NSLog(@"placemark.subLocality %@",placemark.subLocality);
                       NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
                       NSString *valueToSave = placemark.locality;
                       [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"CurrentCityName"];
                       [[NSUserDefaults standardUserDefaults] synchronize];
                     //  self.cityName.text = valueToSave;
                       NSLog(@"saved city name in the key CurrentCityName");
                   }];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}


- (IBAction)btnActCF:(id)sender {
    int deg=self.degreesLabel.text.intValue;
    
   /* NSArray *tdegItems = [self.tomorrow.text componentsSeparatedByString:@": "];
    int tdeg =((NSString *)[tdegItems objectAtIndex:1]).intValue;
    
    NSArray *datdegItems = [self.dat.text componentsSeparatedByString:@": "];
    int datdeg =((NSString *)[datdegItems objectAtIndex:1]).intValue;
    */
    NSArray *fdegItems = [self.lblfirstDay.text componentsSeparatedByString:@": "];
    int fdeg =((NSString *)[fdegItems objectAtIndex:1]).intValue;
    
    NSArray *sdegItems = [self.lblsecondDay.text componentsSeparatedByString:@": "];
    int sdeg =((NSString *)[sdegItems objectAtIndex:1]).intValue;
    
    NSArray *t3degItems = [self.lblthirdDay.text componentsSeparatedByString:@": "];
    int t3deg =((NSString *)[t3degItems objectAtIndex:1]).intValue;
    
    NSArray *f4degItems = [self.lblforthDay.text componentsSeparatedByString:@": "];
    int f4deg =((NSString *)[f4degItems objectAtIndex:1]).intValue;
    
    NSArray *f5degItems = [self.lblfifthDay.text componentsSeparatedByString:@": "];
    int f5deg =((NSString *)[f5degItems objectAtIndex:1]).intValue;
    //int datdeg=self.dat.text.intValue;
    
    if ([_lblCF.text isEqual:@"F"])
    {
        self.degreesLabel.text = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%0.f", ((deg - 32) * (5.0/9.0))], @"°"];

        _lblCF.text=@"C";
       /* self.tomorrow.text = [NSString stringWithFormat:@"%@%@%@",@"Tomorrow: ",[NSString stringWithFormat:@"%0.f", ((tdeg - 32) * (5.0/9.0))], @"°"];
        self.dat.text = [NSString stringWithFormat:@"%@%@%@",@"After 2 days: ",[NSString stringWithFormat:@"%0.f", ((datdeg - 32) * (5.0/9.0))], @"°"];*/
        self.lblfirstDay.text = [[fdegItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ",[NSString stringWithFormat:@"%0.f", ((fdeg - 32) * (5.0/9.0))], @"°"]];
        self.lblsecondDay.text = [[sdegItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f", ((sdeg - 32) * (5.0/9.0))], @"°"]];
        self.lblthirdDay.text = [[t3degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f", ((t3deg - 32) * (5.0/9.0))], @"°"]];
        self.lblforthDay.text = [[f4degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f", ((f4deg - 32) * (5.0/9.0))], @"°"]];
        self.lblfifthDay.text = [[f5degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f", ((f5deg - 32) * (5.0/9.0))], @"°"]];
    }
    else if ([_lblCF.text isEqual:@"C"])
    {
        self.degreesLabel.text= [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%0.f",((deg * (9.0/5.0)) + 32)], @"°"];

        _lblCF.text=@"F";
      /*  self.tomorrow.text = [NSString stringWithFormat:@"%@%@%@",@"Tomorrow: ",[NSString stringWithFormat:@"%0.f",((tdeg * (9.0/5.0)) + 32)], @"°"];
        self.dat.text = [NSString stringWithFormat:@"%@%@%@",@"After 2 days: ",[NSString stringWithFormat:@"%0.f",((datdeg * (9.0/5.0)) + 32)], @"°"];*/
         self.lblfirstDay.text = [[fdegItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ",[NSString stringWithFormat:@"%0.f",((fdeg * (9.0/5.0)) + 32)], @"°"]];
        self.lblsecondDay.text = [[sdegItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f",((sdeg * (9.0/5.0)) + 32)], @"°"]];
        self.lblthirdDay.text = [[t3degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f",((t3deg * (9.0/5.0)) + 32)], @"°"]];
        self.lblforthDay.text = [[f4degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f",((f4deg * (9.0/5.0)) + 32)], @"°"]];
        self.lblfifthDay.text = [[f5degItems objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@",@": ",[NSString stringWithFormat:@"%0.f",((f5deg * (9.0/5.0)) + 32)], @"°"]];
    }
}
- (IBAction)btnAddFavroite:(id)sender {
   [self performSegueWithIdentifier:@"FavtoFav" sender:self];
    
}


/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FavtoFav"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        FavViewController *destViewController = segue.destinationViewController;
        destViewController.temp = _temper;
    }
}*/

@end
