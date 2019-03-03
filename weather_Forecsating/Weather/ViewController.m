//
//  ViewController.m
//  pickerview
//
//  Created by Patel, Binal Shaileshkumar on 11/08/18.
//  Copyright © 2018 CSCI5737 Fall18. All rights reserved.
//

#import "ViewController.h"
#import "CityFavDML.h"
@interface ViewController ()
{
    NSDictionary *dictionary;
        NSString *text1,*text2;
}
- (IBAction)SaveFAv:(id)sender;
- (IBAction)backbtn:(id)sender;

@end

@implementation ViewController
- (void)viewDidLoad {
    text1=@"Alabama";
    text2=@"Alexandra City";
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AlabamaCities" ofType:@"csv"];
NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",content);
    NSMutableArray *Alabama=[content componentsSeparatedByString:@"\r\n"];
    
    _Alaska=[[NSMutableArray alloc]initWithObjects:@"Anchorage",
            @"Cordova",
            @"Fairbanks",
            @"Haines",
            @"Homer",
            @"Juneau",
            @"Ketchikan",
            @"Kodiak",
            @"Kotzebue",
            @"Nome",
            @"Palmer",
            @"Seward",
            @"Sitka",
            @"Skagway",
            @"Valdez",nil];
    

    
    // Do any additional setup after loading the view, typically from a nib.
    
   
    [super viewDidLoad];
    id objects[]={Alabama, _Alaska};
    id keys[]={@"Alabama",@"Alaska"};
    NSUInteger count = sizeof(objects) / sizeof(id);
    dictionary = [NSDictionary dictionaryWithObjects:objects
                                             forKeys:keys
                                               count:count];
    path = [[NSBundle mainBundle] pathForResource:@"States" ofType:@"csv"];
   content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",content);
    _arrdata=[content componentsSeparatedByString:@"\r\n"];
    

  
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return _arrdata.count;
    }
    if (component==1)
    {
        NSArray *a1=[[NSArray alloc]initWithArray:dictionary[text1]];
        return a1.count;
    }
    return component;
   // return arrdata.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component ==0)
    {
     //   text1 =[_arrdata objectAtIndex:row];
        return [_arrdata objectAtIndex:row];
    }
    if (component==1)
    {
        text2=[dictionary[text1] objectAtIndex:row];
        NSMutableArray *obj=dictionary[text1];
        return [obj objectAtIndex:row];
    }
    return 0;
   // return [arrdata objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    bool *x=false;
    if (component==0)
    {
        text1=[_arrdata objectAtIndex:row];
        [pickerView reloadAllComponents];
           text1=[_arrdata objectAtIndex:row];
        x=true;
        
    }
    if (component==1)
    {
       // text2=[dictionary[text1] objectAtIndex:row];
        if(!x)
        {
       text2=[_Alaska objectAtIndex:row];
        }
        else if(x)
        {
            text2=[dictionary[text1] objectAtIndex:row];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (bool) loadCityIntoDatabase
{
  
    NSString* curWord = text2;
    
    NSMutableArray *cityArray= [[NSMutableArray alloc]init];
    cityArray=[CityFavDML fetchCities];
    for ( int i=0;i<cityArray.count;i++){
        NSString *city=[cityArray objectAtIndex:i];
        if([city isEqualToString: curWord])
        {
            return false;
        }
    }
    return true;
   // [CityFavDML addFavCity:curWord ];
    
}

- (IBAction)SaveFAv:(id)sender {
     NSString* curWord = text2;
   bool *x= [ self loadCityIntoDatabase];
    if(x)
    {
        [CityFavDML addFavCity:curWord ];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
    //[self dismissViewControllerAnimated:YES completion:nil];
   // [_ScoresField resignFirstResponder];
    UIAlertView* alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Already in favourites " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [self viewDidLoad];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [self viewDidLoad];
    
}
- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
