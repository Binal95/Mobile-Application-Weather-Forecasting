//
//  AppDelegate.h
//  Weather
//
//  Created by Lakhani, Arif on 9/2/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic,retain) NSMutableArray *windarray;
@property (nonatomic,retain) NSMutableArray *pressurearray;
@property (nonatomic,retain) NSMutableArray *humidarray;
//@property (nonatomic,retain) NSMutableArray *temparray;
@property (nonatomic,retain) NSMutableArray *todayarray;
@property (nonatomic,retain) NSMutableArray *datarray;

- (void)saveContext;


@end

