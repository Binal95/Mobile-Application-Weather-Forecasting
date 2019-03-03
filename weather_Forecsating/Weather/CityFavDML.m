

#import "CityFavDML.h"
#import "CityFav+CoreDataClass.h"
#import "AppDelegate.h"


@implementation CityFavDML

+ (NSManagedObjectContext *) getManagedObjectContext
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.persistentContainer.viewContext;
}


+ (NSMutableArray *)fetchCities
{
    //Get managed object context
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CityFav" inManagedObjectContext:context];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category=%@", categoryname];
  //  [request setPredicate:predicate];
    // Define how we will sort the records
   // NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
   // NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
 //   [request setSortDescriptors:sortDescriptors];
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray* retStr=[[NSMutableArray alloc]init];
    if (!mutableFetchResults)
    {
        return nil;
    }
    else
    {
        if([mutableFetchResults count] > 0)
        {
            for(int i=0;i<[mutableFetchResults count];i++)
            {
          //  int indexOfRandomWord = arc4random() % [mutableFetchResults count];
            CityFav *city = [mutableFetchResults objectAtIndex:i];
                [retStr addObject: [ NSString stringWithFormat:@"%@",city.name]];
        }
    }
    return retStr;
}
}

+ (bool)addFavCity:(NSString *)City;
{
    //Get managed object context
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    //Create a blank new record
    CityFav *guessWordObj = (CityFav *)[NSEntityDescription insertNewObjectForEntityForName:@"CityFav" inManagedObjectContext:context];
    //Fill the new record
    guessWordObj.name = City;
  //  [guessWordObj setCategory:category];
    //Save the new record
    NSError *error;
    if(![context save:&error])
    {
        return false;
    }
    else
    {
        return true;
    }
}

+ (bool)deleteCity:(NSString *)wordString
{
    //Get managed object context
    NSManagedObjectContext* context =[[self class] getManagedObjectContext];
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CityFav" inManagedObjectContext:context];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", wordString];
    [request setPredicate:predicate];
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if(mutableFetchResults.count > 0)
    {
        NSManagedObject *managedObject = [mutableFetchResults objectAtIndex:0];
        [context deleteObject:managedObject];
        if (![context save:&error])
        {
            return false;
        }
    }
    return true;
}



@end
