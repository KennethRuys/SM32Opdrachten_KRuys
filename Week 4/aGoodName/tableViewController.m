//
//  tableViewController.m
//  aGoodName
//
//  Created by FHICT on 19/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "tableViewController.h"

#import "AFNetworking.h"
#import "Pirate.h"
//make sure that you import your detailViewController
#import "detailsViewController.h"

@interface tableViewController ()

@end

@implementation tableViewController

@synthesize pirates;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.pirates = [[NSMutableArray alloc] init];
    NSLog(@"viewDidLoad");
    [self loadJsonData];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadJsonData
{
    NSLog(@"test inside loadJsonData");
    
    //Create URL
    
    NSURL* url = [NSURL URLWithString:@"http://athena.fhict.nl/users/i282933/pirates.json"];
    
    //Sometimes servers return a wrong header. Use thi to add a new accepted type
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         
         NSLog(@"%@",responseObject);
         
         [self parseJSONData: responseObject];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     
     {
         
         NSLog(@"Error: %@", error);
         
     }
     
     ];
    
    [operation start];
    
    
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://athena.fhict.nl/users/i886625/pirates.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //This code is executed when the result was ok.
        NSLog(@"JSON: %@", responseObject);
        [self parseJSONData:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //This code is executed when there was an error.
        NSLog(@"Error: %@", error);
        
    }];*/
}

-(void) parseJSONData:(id) JSON
{
    //Loop through all objects in JSON array
    for (NSDictionary* dict in JSON) {
        //Create a pirate object where the json data can be stored
        Pirate *pirate = [[Pirate alloc] init];
        //Get the JSON data from the dictionary and store it at the Pirate object
        pirate.name = [dict objectForKey:@"name"];
        pirate.life = [dict objectForKey:@"life"];
        pirate.countryOfOrigin = [dict objectForKey:@"country_of_origin"];
        pirate.active = [dict objectForKey:@"years_active"];
        pirate.comments = [dict objectForKey:@"comments"];
        
        //Add the pirates to the array
        [pirates addObject:pirate];
    }
    [self.tableView reloadData];
}






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.pirates.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the cell. Note that this name is the same as in the storyboard
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Set the correct name in the cell.
    //Do so by looking up the row in indexpath and choosing the same element in the array
    NSInteger currentRow = indexPath.row;
    Pirate * currentPirate = [self.pirates objectAtIndex:currentRow];
    
    NSString *textForCell = currentPirate.name;
    
    //Set the text in the cell
    cell.textLabel.text = textForCell;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Find the selected pirate
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    Pirate *selectedPirate =  [self.pirates objectAtIndex:selectedRow.row];
    //Pass the selected pirate to the next viewcontroller
    detailsViewController *controller = segue.destinationViewController;
    controller.selectedPirate = selectedPirate;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
