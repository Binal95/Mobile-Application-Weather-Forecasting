//
//  AppDelegate.m
//  Weather
//
//  Created by Patel, Binal Shaileshkumar on 9/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "AppDelegate.h"
#import "OpenWeatherMapAPI.h"
#import "CityFavDML.h"
@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    //UIPageControl *pageControl = [UIPageControl appearance];
 //   pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
   // pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //pageControl.backgroundColor = [UIColor whiteColor];
  //  NSMutableArray *arrPageTitles=[[NSMutableArray alloc]initWithObjects:@"houston",@"dallas",@"austin", nil];
  /*  NSString *string =  [[NSUserDefaults standardUserDefaults]
                         objectForKey:@"CurrentCityName"];
    NSString *trimmedString = [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSMutableArray *arrPageTitles = [[NSMutableArray alloc] initWithObjects:trimmedString, nil];
    
    [arrPageTitles addObjectsFromArray:[CityFavDML fetchCities] ];
  
_windarray=[[NSMutableArray alloc]initWithArray:arrPageTitles];
    _pressurearray=[[NSMutableArray alloc]initWithArray:arrPageTitles];
   _humidarray =[[NSMutableArray alloc]initWithArray:arrPageTitles];
    _datarray=[[NSMutableArray alloc]initWithArray:arrPageTitles];
    _temparray=[[NSMutableArray alloc]initWithArray:arrPageTitles];
  _todayarray=[[NSMutableArray alloc]initWithArray:arrPageTitles];
    for(int i=0;i<arrPageTitles.count;i++)
    {
        
        NSLog(@"within app delagate for loop");
        NSLog(@"after for wind is arif %@", _windarray[i]);
        NSString *str=[arrPageTitles objectAtIndex:i];
        WeatherData *weatherData= [OpenWeatherMapAPI fetchCurrentWeatherDataForLocation1:str];
       
        NSString *tempString = [weatherData tempString];
        NSString *pressData = [weatherData press];
        NSString *humidData = [weatherData humdity];
        NSString *tomoData = [weatherData tomorrow];
        NSString *datData = [weatherData dat];
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
             NSString *tomorrow = @"Tomorrow: ";
        [_todayarray  insertObject: [tomorrow stringByAppendingString:pressData] atIndex:i];
             NSString *dat = @"After 2 days: ";
        [_datarray  insertObject: [dat stringByAppendingString:pressData] atIndex:i];
         //    self.lastUpdate = [NSDate date];
            
      //  });
    }*/

    
   //NSLog(@"%@", weatherData);

 
    
    
  
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Weather"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
