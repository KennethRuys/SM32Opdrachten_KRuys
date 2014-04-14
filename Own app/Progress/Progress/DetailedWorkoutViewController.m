//
//  DetailedWorkoutViewController.m
//  Progress
//
//  Created by FHICT on 27/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "DetailedWorkoutViewController.h"
#import <Foundation/Foundation.h>

@interface DetailedWorkoutViewController ()

@end

@implementation DetailedWorkoutViewController


@synthesize mainTableView = ivMainTableView;
@synthesize contentsList = ivContentsList;
@synthesize xlabel;
@synthesize ylabel;
@synthesize zlabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    X_baseline_array = [[NSMutableArray alloc] init];
    Y_baseline_array = [[NSMutableArray alloc] init];
    Z_baseline_array = [[NSMutableArray alloc] init];
    
    X_first_record_array = [[NSMutableArray alloc] init];
    Y_first_record_array = [[NSMutableArray alloc] init];
    Z_first_record_array = [[NSMutableArray alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"Sit ups 10x", @"Crunches 20x", @"Forward press 100kg 10x", @"Deadlift 200kg 10x", @"Running 10km", nil];
    [self setContentsList:array];

    self.motionManager = [[CMMotionManager alloc] init];
    
}

-(void)baseline_outputAccelertionData:(CMAcceleration)acceleration
{
    self.xlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    self.ylabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    self.zlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    
    if(X_baseline_array.count <= 10)
    {
        [X_baseline_array addObject:[NSNumber numberWithDouble:acceleration.x]];
        [Y_baseline_array addObject:[NSNumber numberWithDouble:acceleration.y]];
        [Z_baseline_array addObject:[NSNumber numberWithDouble:acceleration.z]];
    }
    else
    {
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *data, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(),
                            ^{
                                NSLog(@"dispatched updates");
                                [self.motionManager stopAccelerometerUpdates];
                            });
         }];
        
        double tmpx = 0;
        double tmpy = 0;
        double tmpz = 0;
        
        for (NSNumber * tmp in X_baseline_array)
        {
            tmpx += [tmp doubleValue];
        }
        for (NSNumber * tmp in Y_baseline_array)
        {
            tmpy += [tmp doubleValue];
        }
        for (NSNumber * tmp in Z_baseline_array)
        {
            tmpz += [tmp doubleValue];
        }
        
        X_baseline = tmpx/X_baseline_array.count;
        Y_baseline = tmpy/Y_baseline_array.count;
        Z_baseline = tmpz/Z_baseline_array.count;
        
        NSLog(@"X_bas: %.2fg, Y_bas: %.2fg, Z_bas: %2.fg", X_baseline, Y_baseline, Z_baseline);
        
        [X_baseline_array removeAllObjects];
        [Y_baseline_array removeAllObjects];
        [Z_baseline_array removeAllObjects];
        
    }
}

-(void)firstRecord_outputAccelertionData:(CMAcceleration)acceleration
{
    
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self mainTableView] reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[self contentsList] count];
    
    NSLog(@"rows is: %d", rows);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentForThisRow = [[self contentsList] objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]];
        // Do anything that should be the same on EACH cell here.  Add subviews, fonts, colors, etc.
    }
    
    // Do anything that COULD be different on each cell here.  Text, images, etc.
    [[cell textLabel] setText:contentForThisRow];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)baselineMeasurement:(id)sender {
    self.motionManager.accelerometerUpdateInterval = .2;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError * error)
    {
       [self baseline_outputAccelertionData:accelerometerData.acceleration];
        if(error)
        {
            NSLog(@"%@", error);
        }
    }];
}

- (IBAction)firstRecordingStart:(id)sender {
        self.motionManager.accelerometerUpdateInterval = .2;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError * error)
         {
             [self firstRecord_outputAccelertionData:accelerometerData.acceleration];
             if(error)
             {
                 NSLog(@"%@", error);
             }
         }];
}

- (IBAction)firstRecordingStop:(id)sender {
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSLog(@"dispatched updates");
                            [self.motionManager stopAccelerometerUpdates];
                        });
     }];
}
@end
