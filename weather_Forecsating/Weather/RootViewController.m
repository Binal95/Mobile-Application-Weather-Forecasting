//
//  RootViewController.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 10/17/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "RootViewController.h"
#import "PageContentViewController.h"
#import "PageViewController.h"
#import "CityFavDML.h"
#import "OpenWeatherMapAPI.h"
#import "AppDelegate.h"
//#import "FavViewController.h"
//#import "RootViewControllerDelegate.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblActivity;


@end

@implementation RootViewController

NSDate *firstday;
NSDate *secondday;
NSDate *thirdday;
NSDate *forthday;
NSDate *fifthday;
AppDelegate *ap;
NSArray *viewControllers;
NSMutableArray * abc;

- (void)viewWillAppear:(BOOL)animated
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    //_lblActivity.text=@"Loading...";
    //[indicator setCenter:self.imageView.center];
    //[self.contentView addSubview:indicator];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblActivity.text=@"";
    //FavViewController *fav = [[FavViewController alloc] init];
    //fav.tempval = tempval;
  ap =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *string =  [[NSUserDefaults standardUserDefaults]
                         objectForKey:@"CurrentCityName"];
    if (!string)
    {
        string=@"San Francisco";
    }
   // NSString *trimmedString = [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    _arrPageTitles= [[NSMutableArray alloc] initWithObjects:string, nil];
     [_arrPageTitles addObjectsFromArray: [CityFavDML fetchCities]];
    NSLog(@"titles array%@",_arrPageTitles);
   // _arrPageTitles=@[@"Houston",@"Dallas",@"Austin"];
    self.PageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    }

- (void)viewDidAppear:(BOOL)animated{
    
    // Create page view controller
    [self viewDidLoad];
    _lblActivity.text=@"";
    NSString *string =  [[NSUserDefaults standardUserDefaults]
                         objectForKey:@"CurrentCityName"];
    if (!string)
    {
        string=@"San Francisco";
    }
    NSString *trimmedString = [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSMutableArray *arrPageTitles1 = [[NSMutableArray alloc] initWithObjects:trimmedString, nil];
    [arrPageTitles1 addObjectsFromArray:[CityFavDML fetchCities] ];
    NSLog(@"data fetch array%@",arrPageTitles1);
    _windarray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _pressurearray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _humidarray =[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _datarray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _temparray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _todayarray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _firstDayForeCastarray = [[NSMutableArray alloc]initWithArray:arrPageTitles1];
     _secondDayForeCastarray = [[NSMutableArray alloc]initWithArray:arrPageTitles1];
     _thirdDayForeCastarray = [[NSMutableArray alloc]initWithArray:arrPageTitles1];
     _forthDayForeCastarray = [[NSMutableArray alloc]initWithArray:arrPageTitles1];
     _fifthDayForeCastarray = [[NSMutableArray alloc]initWithArray:arrPageTitles1];
    
    //R
    _mainarray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    _descarray=[[NSMutableArray alloc]initWithArray:arrPageTitles1];
    
    //--
    for(int i=0;i<arrPageTitles1.count;i++)
    {
        NSString *str=[arrPageTitles1 objectAtIndex:i];
        WeatherData *weatherData= [OpenWeatherMapAPI fetchCurrentWeatherDataForLocation1:str];
        WeatherData *forecast = [OpenWeatherMapAPI fetchForeCastWeatherDataForLocation1:str];
       // _foreCastData = [[NSMutableArray alloc]init];
       /* _foreCastData = [OpenWeatherMapAPI fetchForeCastWeatherDataForLocation1:str];*/
      // WeatherData *foreCast = [OpenWeatherMapAPI fetchForeCastWeatherDataForLocation1:str];
        //NSMutableArray *try = [OpenWeatherMapAPI fetchForeCastWeatherDataForLocation1:str];
      //  NSUserDefaults *tryobj = [NSUserDefaults standardUserDefaults];
        //NSMutableArray *tryvalue = [tryobj objectForKey:@"value"];
         /* NSLog(@"forecasting data");
        for (id obj in try)
        { NSLog(@"forecasting data second");
            NSLog(@"obj:%@", obj);
        }*/
       
        //NSNumber *t = [foreCast tempForecast];
      
       // NSLog(@"%@", t);
        //R
        NSString *mainData = [weatherData mainString];
        NSString *descData = [weatherData descString];
        
        [_mainarray  insertObject: mainData atIndex:i] ;
        [_descarray  insertObject: descData atIndex:i] ;
        //--
        
        NSArray* forcastList = [forecast fulldata];
        
        NSDictionary *temp = [[NSDictionary alloc]init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      
        _firstDayTemp=0;
        _firstDayCount=0;
        _secondDayTemp=0;
        _secondDayCount=0;
        _thirdDayTemp=0;
        _thirdDayCount=0;
        _forthDayTemp=0;
        _forthDayCount=0;
        _fifthDayTemp=0;
        _fithDayCount=0;
        for (NSDictionary* forecastDic in forcastList)
        {
            
            // NSArray *weather = forecastDic[@"weather"];
            temp = forecastDic[@"main"];
            //NSLog(temp[@"temp_max"]);
            // forecastData.date = [dateFormatter dateFromString:(NSString *)forecastDictionary[@"dt_txt"]];
            NSString* getdate =(NSString*)forecastDic[@"dt_txt"];
           NSString *subgetdate = [getdate substringWithRange:NSMakeRange(0,10)];
           
            NSDate* now = [NSDate date];
            NSLog(@"todayarray %@",now);
            firstday =[now dateByAddingTimeInterval:+1*24*60*60];
            NSString *Firstday = [dateFormatter stringFromDate:firstday];
            secondday =[now dateByAddingTimeInterval:+2*24*60*60];
            NSString *Secondday = [dateFormatter stringFromDate:secondday];
            thirdday =[now dateByAddingTimeInterval:+3*24*60*60];
            NSString *Thirdday = [dateFormatter stringFromDate:thirdday];
            forthday =[now dateByAddingTimeInterval:+4*24*60*60];
            NSString *Forthday = [dateFormatter stringFromDate:forthday];
            fifthday =[now dateByAddingTimeInterval:+5*24*60*60];
            NSString *Fifthday = [dateFormatter stringFromDate:fifthday];
            NSLog(@"now date :%@", firstday);
             NSLog(@"trim now date :%@", Firstday);
         if([Firstday isEqualToString:subgetdate])
         {
             /*_firstDayTemp = [NSNumber numberWithFloat:[_firstDayTemp floatValue] + [temp[@"temp_max"] floatValue]];
             _firstDayCount = [NSNumber numberWithFloat: 1 + [_firstDayCount floatValue]];
              */
             if(_firstDayTemp < temp[@"temp_max"] )
             {
                 _firstDayTemp=temp[@"temp_max"];
             }
             
         }
            
            else if([Secondday isEqualToString:subgetdate])
            {
               /*_secondDayTemp = [NSNumber numberWithFloat:[_secondDayTemp floatValue] + [temp[@"temp_max"] floatValue]];
                _secondDayCount = [NSNumber numberWithFloat: 1 + [_secondDayCount floatValue]];*/
                if(_secondDayTemp < temp[@"temp_max"] )
                {
                    _secondDayTemp=temp[@"temp_max"];
                }
            }
            else if([Thirdday isEqualToString:subgetdate])
            {
                /*_thirdDayTemp = [NSNumber numberWithFloat:[_thirdDayTemp floatValue] + [temp[@"temp_max"] floatValue]];
                _thirdDayCount = [NSNumber numberWithFloat: 1 + [_thirdDayCount floatValue]];*/
                if(_thirdDayTemp < temp[@"temp_max"] )
                {
                    _thirdDayTemp=temp[@"temp_max"];
                }
            }
            else if([Forthday isEqualToString:subgetdate])
            {
               /*_forthDayTemp = [NSNumber numberWithFloat:[_forthDayTemp floatValue] + [temp[@"temp_max"] floatValue]];
                _forthDayCount = [NSNumber numberWithFloat: 1 + [_forthDayCount floatValue]];
                */
                if(_forthDayTemp < temp[@"temp_max"] )
                {
                    _forthDayTemp=temp[@"temp_max"];
                }
            }
            else if([Fifthday isEqualToString:subgetdate])
            {
               /*_fifthDayTemp = [NSNumber numberWithFloat:[_fifthDayTemp floatValue] + [temp[@"temp_max"] floatValue]];
                _fithDayCount = [NSNumber numberWithFloat: 1 + [_fithDayCount floatValue]];*/
                if(_fifthDayTemp < temp[@"temp_max"] )
                {
                    _fifthDayTemp=temp[@"temp_max"];
                }
            }
            else
            {
                continue;
            }
            
            // forecastData.highTemp = temp[@"temp_max"];
            // forecastData.lowTemp = temp[@"temp_min"];
            // forecastData.humidity = temp[@"humidity"];
            //forecastData.pressure = temp[@"pressure"];
           
          //  sum = sum + foreCastTemp;
            
            
            
       //     [arraynew addObject:forecastData];
            
            // double avgtemp = [arraynew ]
            // [self.array addObject:forecastData];
        }
        
        
        
        
        //[dateFormatter setDateFormat:@"EEE, dd MMM yyy"];
      
        //  NSDate* date =[dateFormatter dateFromString:forecastDic[@"dt_txt"]];
        // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        //[dateFormatter setDateFormat:@"MM-dd-yyyy"];
       // NSString *getdate = (NSString*)[[jsonArray objectAtIndex:0]date];
        //getdate = (NSString*)[getdate componentsSeparatedByString];
        //NSString *get = NSString*[getdate];
        
        //NSString *firstdate = [firstday substringWithRange:NSMakeRange(0,2)];
        
        /* commented for lower average: Rachana
         
        _firstDayTemp = [NSNumber numberWithFloat:[_firstDayTemp floatValue] / [_firstDayCount floatValue]];*/
        
        NSLog(@"max firstday temp string:%@", [_firstDayTemp stringValue]);
        // _secondDayTemp = [NSNumber numberWithFloat:[_secondDayTemp floatValue] / [_secondDayCount floatValue]];
         NSLog(@"max thirdday temp:%@", _secondDayTemp);
        //_thirdDayTemp = [NSNumber numberWithFloat:[_thirdDayTemp floatValue] / [_thirdDayCount floatValue]];
        NSLog(@"max thirdday temp:%@", _thirdDayTemp);
        //_forthDayTemp = [NSNumber numberWithFloat:[_forthDayTemp floatValue] / [_forthDayCount floatValue]];
        NSLog(@"max forthday temp:%@", _forthDayTemp);
        //_fifthDayTemp = [NSNumber numberWithFloat:[_fifthDayTemp floatValue] / [_fithDayCount floatValue]];
        NSLog(@"max fifthday temp:%@", _fifthDayTemp);
        
        NSString *tempString = [weatherData tempString];
        NSString *pressData = [weatherData press];
        //NSString *humidData = [weatherData humdity];
        //NSString *tomoData = [weatherData tomorrow];
        //NSString *datData = [weatherData dat];
        NSLog(@"within rootviewcontroller viewdidapper for loop");
        NSLog(@"after for  %@", _windarray[i]);
        NSLog(@"weather data is %@",weatherData);
        [_windarray insertObject:[weatherData wind] atIndex:i];
        NSString *wingData = [weatherData wind];
        NSString *windnow = @"Wind: ";
        [_windarray insertObject:[windnow stringByAppendingString:wingData] atIndex:i];
        NSLog(@"wind is arif %@", _windarray[i]);
        //   dispatch_async(dispatch_get_main_queue(), ^{
        //   self.degreesLabel.text = tempString;
        
        [_temparray  insertObject: tempString atIndex:i] ;
        
        NSString *pressure = @"Pressure: ";
        [_pressurearray  insertObject: [pressure stringByAppendingString:pressData] atIndex:i] ;
        NSString  *humid = @"Humidity: ";
        [_humidarray  insertObject: [humid stringByAppendingString:pressData] atIndex:i];
       /* NSString *tomorrow = @"Tomorrow: ";
        [_todayarray  insertObject: [tomorrow stringByAppendingString:pressData] atIndex:i];
        NSString *dat = @"After 2 days: ";
        [_datarray  insertObject: [dat stringByAppendingString:pressData] atIndex:i];
       */
        //[dateFormatter setDateFormat:@"MM-dd-yyyy"];
        // = [Firstday stringByAppendingString:@":"];
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"EEEE"];
        NSString *nowdt=[dateFormatter2 stringFromDate:[NSDate date]];
        NSString *first=[dateFormatter2 stringFromDate:firstday];
        NSString *second=[dateFormatter2 stringFromDate:secondday];
        NSString *third=[dateFormatter2 stringFromDate:thirdday];
        NSString *forth=[dateFormatter2 stringFromDate:forthday];
        NSString *fifth=[dateFormatter2 stringFromDate:fifthday];
        //[_firstDayForeCastarray  insertObject: [first stringByAppendingString:[_firstDayTemp stringValue]]atIndex:i];
        
        [_firstDayForeCastarray  insertObject: [first stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ", [NSString stringWithFormat:@"%0.f", [_firstDayTemp floatValue]], @"°"]]atIndex:i];
        //NSString *second = @"2nd Day: ";
        [_secondDayForeCastarray  insertObject: [second stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ", [NSString stringWithFormat:@"%0.f",[_secondDayTemp floatValue]], @"°"]]atIndex:i];
        
        //NSString *third = @"3rd Day: ";
        [_thirdDayForeCastarray insertObject: [third stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ", [NSString stringWithFormat:@"%0.f",[_thirdDayTemp floatValue]], @"°"]]atIndex:i];
        
        //NSString *forth = @"4th Day: ";
        [_forthDayForeCastarray  insertObject: [forth stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ", [NSString stringWithFormat:@"%0.f",[_forthDayTemp floatValue]], @"°"]]atIndex:i];
        
        //NSString *fifth = @"5th Day: ";
        [_fifthDayForeCastarray  insertObject: [fifth stringByAppendingString:[NSString stringWithFormat:@"%@%@%@", @": ", [NSString stringWithFormat:@"%0.f",[_fifthDayTemp floatValue]], @"°"]]atIndex:i];
       // [_firstDayForeCastarray  insertObject: [first stringByAppendingString:(NSString*)_firstDayTemp] atIndex:i];
        
        
        //    self.lastUpdate = [NSDate date];
        
        //  });*/
    }
    
    //abc=_temparray;
    
    
    [super viewDidAppear:YES];

    self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.PageViewController.dataSource = self;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    viewControllers = @[startingViewController];
    [self.PageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Change the size of page view controller
    [self addChildViewController:self.PageViewController];
    [self.view addSubview:self.PageViewController.view];
    [self.PageViewController didMoveToParentViewController:self];
  //  [self viewDidLoad];
 
//    [self.PageViewController setViewControllers:@[viewControllers]direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    //NSLog(@"Rach temp:%@", _temparray);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == [self.arrPageTitles count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.arrPageTitles count] == 0) || (index >= [self.arrPageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
   // AppDelegate *ap=(AppDelegate *)[[UIApplication sharedApplication]delegate];
  //  _windarray=ap.windarray;
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
  

   // pageContentViewController.imgFile = self.arrPageImages[index];
    pageContentViewController.cityName1=self.arrPageTitles[index];
   // pageContentViewController.txtTitle = self.arrPageTitles[index];
    pageContentViewController.pageIndex = index;
    pageContentViewController.wind1=self.windarray[index];
    pageContentViewController.pressure1=self.pressurearray[index];
    pageContentViewController.humidity1=self.humidarray[index];
    pageContentViewController.temper=self.temparray[index];
    pageContentViewController.tod=self.todayarray[index];
    
    pageContentViewController.dat1=self.datarray[index];
    pageContentViewController.first= self.firstDayForeCastarray[index];
    pageContentViewController.second = self.secondDayForeCastarray[index];
    pageContentViewController.third = self.thirdDayForeCastarray[index];
    pageContentViewController.forth = self.forthDayForeCastarray[index];
    pageContentViewController.fifth = self.fifthDayForeCastarray[index];
    
    //R
    pageContentViewController.main=_mainarray[index];
    pageContentViewController.desc=_descarray[index];
    //[self.delegate sendTempArray:_temparray];
    
    //f.tempval=self.temparray;
    //--

    NSLog(@"index is %lu and wind is %@",(unsigned long)index, ap.windarray[index]);
    return pageContentViewController;

    
}

/*-(void)passTemp{
    NSLog(@"passtemp:%@",_temparray);

    //NSMutableArray* count = [@[@"abc"]mutableCopy];//Create count
    if ([self.delegate respondsToSelector:@selector(sendTempArray:)]) {
        [self.delegate sendTempArray:abc];//[@[@"12",@"33"]mutableCopy]];
    }
}*/

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    

    NSLog(@"count of pages is %lu",(unsigned long)[self.arrPageTitles count]);
    NSUInteger x =[self.arrPageTitles count];
    return x;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
