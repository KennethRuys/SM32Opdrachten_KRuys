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
    
    X_array_container = [[NSMutableArray alloc] init];
    Y_array_container = [[NSMutableArray alloc] init];
    Z_array_container = [[NSMutableArray alloc] init];
    
    X_current = [[NSMutableArray alloc] init];
    Y_current = [[NSMutableArray alloc] init];
    Z_current = [[NSMutableArray alloc] init];
    
    X_current_delta = [[NSMutableArray alloc] init];
    Y_current_delta = [[NSMutableArray alloc] init];
    Z_current_delta = [[NSMutableArray alloc] init];
    
    X_current_MA = [[NSMutableArray alloc] init];
    Y_current_MA = [[NSMutableArray alloc] init];
    Z_current_MA = [[NSMutableArray alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"Sit ups 10x", @"Crunches 20x", @"Forward press 100kg 10x", @"Deadlift 200kg 10x", @"Running 10km", nil];
    [self setContentsList:array];
    
    self.motionManager = [[CMMotionManager alloc] init];
    
}

-(void)baseline_outputAccelertionData:(CMAcceleration)acceleration
{
    self.xlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    self.ylabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    self.zlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    
    if(X_baseline_array.count <= 20)
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
    self.xlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.x];
    self.ylabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.y];
    self.zlabel.text = [NSString stringWithFormat:@" %.2fg",acceleration.z];
    
    [X_first_record_array addObject:[NSNumber numberWithDouble:acceleration.x-X_baseline]];
    [Y_first_record_array addObject:[NSNumber numberWithDouble:acceleration.y-Y_baseline]];
    [Z_first_record_array addObject:[NSNumber numberWithDouble:acceleration.z-Z_baseline]];
}

-(void)start_outputAccelertionData:(CMAcceleration)acceleration
{
    //here it gets the current data and compares it to the recorded data
    //first you want to check if there is enough data to compare with
    //for the time being a max value of 30 is taken
    
    //code below creates a time period of 3 seconds in which to look
    //if nothing is recognized in the 3 second period it shifts from 0.0->3.0 to 0.05->3.05 and sofort
    
    bool x_check = false;
    bool y_check = false;
    bool z_check = false;
    
    if(X_current.count >= 30)
    {
        [X_current removeObjectAtIndex:0];
    }
    if(Y_current.count >= 30)
    {
        [Y_current removeObjectAtIndex:0];
    }
    if(Z_current.count >= 30)
    {
        [Z_current removeObjectAtIndex:0];
    }
    [X_current addObject:[NSNumber numberWithDouble:acceleration.x-X_baseline]];
    [Y_current addObject:[NSNumber numberWithDouble:acceleration.y-Y_baseline]];
    [Z_current addObject:[NSNumber numberWithDouble:acceleration.z-Z_baseline]];
    
    [self convertToDeltaArray:X_current : X_current_delta];
    [self convertToDeltaArray:Y_current : Y_current_delta];
    [self convertToDeltaArray:Z_current : Z_current_delta];
    
    [self convertToMovingAverage:X_current_delta : X_current_MA];
    [self convertToMovingAverage:Y_current_delta : Y_current_MA];
    [self convertToMovingAverage:Z_current_delta : Z_current_MA];
    
    if(X_current_MA.count > 20)
    {
        x_check = [self arrayCompare:X_current_MA : X_array_container];
    }
    if(Y_current_MA.count > 20)
    {
        y_check = [self arrayCompare:Y_current_MA : Y_array_container];
    }
    if(Z_current_MA.count > 20)
    {
        z_check = [self arrayCompare:Z_current_MA : Z_array_container];
    }
    
    if(x_check && y_check && z_check && skipTill >= 10)
    {
        amountOfTimesDone++;
        previousValue = true;
        skipTill = 0;
    }
    else if(previousValue)
    {
        skipTill++;
    }
    else
    {
        previousValue = false;
        skipTill++;
    }
    
    NSLog(@"x_check = %d, y_check = %d, z_check = %d", x_check, y_check, z_check);
    NSLog(@"amount Of Times Done: %d", amountOfTimesDone);
    
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
    self.motionManager.accelerometerUpdateInterval = .1;
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
    self.motionManager.accelerometerUpdateInterval = .05;
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
    //Code above is for dispatching updates to update queue
    
    //First we need to try and subtract the values that happen before the actual exercise
    
    
    //Create Moving Average Arrays
    
    NSMutableArray * X_MA = [[NSMutableArray alloc]init];
    NSMutableArray * Y_MA = [[NSMutableArray alloc]init];
    NSMutableArray * Z_MA = [[NSMutableArray alloc]init];
    
    NSMutableArray * X_DE = [[NSMutableArray alloc]init];
    NSMutableArray * Y_DE = [[NSMutableArray alloc]init];
    NSMutableArray * Z_DE = [[NSMutableArray alloc]init];
    
    [self convertToMovingAverage:X_first_record_array : X_MA];
    [self convertToMovingAverage:Y_first_record_array : Y_MA];
    [self convertToMovingAverage:Z_first_record_array : Z_MA];
    
    [self convertToDeltaArray:X_MA : X_DE];
    [self convertToDeltaArray:Y_MA : Y_DE];
    [self convertToDeltaArray:Z_MA : Z_DE];
    
    [self trimArray:X_DE];
    [self trimArray:Y_DE];
    [self trimArray:Z_DE];
    
    //**TEMP** Print all delta's & check amount of times passed 0
    int passed_x = 0;
    int passed_y = 0;
    int passed_z = 0;
    
    NSLog(@"Delta's with the value before, x & x-1");
    NSLog(@", id, x, y, z");
    
    int xlen = X_DE.count;
    int ylen = Y_DE.count;
    int zlen = Z_DE.count;
    
    int max_tmp = MAX(xlen, MAX(ylen,zlen));
    
    for (int i = 1; i<max_tmp; i++)
    {
        NSLog(@", %d, %.2f, %.2f, %.2f", i,
              (i<xlen) ? [X_DE[i] doubleValue] : 0,
              (i<ylen) ? [Y_DE[i] doubleValue] : 0,
              (i<zlen) ? [Z_DE[i] doubleValue] : 0);
        
        /*if(i<xlen)
         [self checkIfPassedZero:X_DE: i :&passed_x];
         if(i<ylen)
         [self checkIfPassedZero:Y_DE: i :&passed_y];
         if(i<zlen)
         [self checkIfPassedZero:Z_DE: i :&passed_z];*/
    }
    //NSLog(@"passed x: %i, passed y: %i, passed z: %i", passed_x, passed_y, passed_z);
    
    //Make like a banana and split
    [self splitIntoMultipleArrays:X_DE :X_array_container];
    [self splitIntoMultipleArrays:Y_DE :Y_array_container];
    [self splitIntoMultipleArrays:Z_DE :Z_array_container];
    
    //Remove bullshit values from split array
    [self removeBadArrayValues:X_array_container];
    [self removeBadArrayValues:Y_array_container];
    [self removeBadArrayValues:Z_array_container];
    
    //Remove insignificant values from the now clean arrays
    
    for (NSMutableArray * p_a in X_array_container) {
        [self trimArray:p_a];
    }
    for (NSMutableArray * p_a in Y_array_container) {
        [self trimArray:p_a];
    }
    for (NSMutableArray * p_a in Z_array_container) {
        [self trimArray:p_a];
    }
}

- (IBAction)start_check:(id)sender {
    self.motionManager.accelerometerUpdateInterval = .05;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError * error)
     {
         [self start_outputAccelertionData:accelerometerData.acceleration];
         if(error)
         {
             NSLog(@"%@", error);
         }
     }];
}

- (IBAction)stop_check:(id)sender {
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSLog(@"dispatched updates");
                            [self.motionManager stopAccelerometerUpdates];
                        });
     }];
}


-(void)removeBadArrayValues:(NSMutableArray*)source_array
{
    NSMutableArray * tmp = [[NSMutableArray alloc] init];
    for (NSMutableArray* p_a in source_array)
    {
        if(p_a.count < 10)
        {
            [tmp addObject:p_a];
        }
    }
    for (NSMutableArray* p_a in tmp)
    {
        [source_array removeObject:p_a];
    }
}


-(void)convertToMovingAverage: (NSMutableArray*)source_array:(NSMutableArray*)destination_array
{
    [destination_array removeAllObjects];
    if(source_array.count >= 5)
    {
        for(int i = 4; i < source_array.count; i++)
        {
            double sum_storage =
            [source_array[i] doubleValue] + [source_array[i-1] doubleValue] + [source_array[i-2] doubleValue]
            + [source_array[i-3] doubleValue] + [source_array[i-4] doubleValue];
            [destination_array addObject:[NSNumber numberWithDouble:sum_storage/5]];
        }
    }
}

-(void)convertToDeltaArray: (NSMutableArray*)source_array:(NSMutableArray*)destination_array
{
    [destination_array removeAllObjects];
    if(source_array.count >= 2)
    {
        for(int i = 1; i < source_array.count; i++)
        {
            [destination_array addObject:[NSNumber numberWithDouble:
                                          [source_array[i] doubleValue]-[source_array[i-1] doubleValue]]];
        }
    }
}

-(void)trimArray:(NSMutableArray*)toBeTrimmed
{
    [self trimStartFromArray:toBeTrimmed];
    [self trimEndFromArray:toBeTrimmed];
}

-(void)trimStartFromArray:(NSMutableArray*)toBeTrimmed
{
    bool found = false;
    int index = 0;
    while(found == false && index < toBeTrimmed.count)
    {
        if([toBeTrimmed[index] doubleValue] >= 0.05 ||
           [toBeTrimmed[index] doubleValue] <= -0.05)
        {
            found = true;
        }
        else
        {
            index++;
        }
    }
    if(index != 0 && found == true)
    {
        for(int i = index-1; i >= 0; i--)
        {
            [toBeTrimmed removeObjectAtIndex:i];
        }
    }
}

-(void)trimEndFromArray:(NSMutableArray*)toBeTrimmed
{
    bool found = false;
    int index = toBeTrimmed.count - 1;
    while(found == false)
    {
        if([toBeTrimmed[index] doubleValue] >= 0.05 ||
           [toBeTrimmed[index] doubleValue] <= -0.05)
        {
            found = true;
        }
        else
        {
            index--;
        }
        
        if(index == -1)
        {
            found = true;
        }
    }
    
    if(index != -1 || index != (toBeTrimmed.count-1))
    {
        int amountOfValues = toBeTrimmed.count-1 - index;
        for(int i = amountOfValues; i > 0; i--)
        {
            [toBeTrimmed removeObjectAtIndex:index+i];
        }
    }
}

-(void)splitIntoMultipleArrays:(NSMutableArray*)source_array:(NSMutableArray*)destination_array
{
    int lastPassing = 0;
    for(int i = 1; i < source_array.count; i++)
    {
        //only if passing 0 by a positive value
        if([source_array[i] doubleValue] >= 0 && [source_array[i-1] doubleValue] <= 0 )
        {
            NSMutableArray * tmp = [[NSMutableArray alloc] init];
            NSRange tmp_range = NSMakeRange(lastPassing, i-lastPassing);
            [tmp addObjectsFromArray:[source_array subarrayWithRange:tmp_range]];
            lastPassing = i;
            [destination_array addObject:tmp] ;
        }
    }
    if(source_array.count != 0)
    {
    NSMutableArray * tmp = [[NSMutableArray alloc] init];
    NSRange tmp_range = NSMakeRange(lastPassing, source_array.count-lastPassing);
    [tmp addObjectsFromArray:[source_array subarrayWithRange:tmp_range]];
    [destination_array addObject:tmp] ;
    }
}

-(BOOL)arrayCompare:(NSMutableArray*)current_data:(NSMutableArray*)compare_stack
{
    bool found = true;
    bool loop_break = false;
    int container_i = 0;
    while(loop_break == false && container_i < compare_stack.count)
    {
        int array_i = 0;
        NSMutableArray * sub_array = compare_stack[container_i];
        while(found == true && array_i < sub_array.count )
        {
            double current_double = [current_data[array_i] doubleValue];
            double min_comp_double = [sub_array[array_i] doubleValue] - 0.10;
            double max_comp_double = [sub_array [array_i] doubleValue] + 0.10;
            
            //check if outside boundries, if so, break out of while, no need to compare if 1 value isnt correct
            if((current_double < min_comp_double) ||
               (current_double > max_comp_double))
               {
                   found = false;
               }
               array_i++;
        }
        if(found == true)
        {
            loop_break = true;
        }
        else
        {
            found = true;
            container_i++;
        }
    }
    if(compare_stack.count == 0)
    {
        return true;
    }
    else
    {
        return loop_break;
    }
}

-(void)checkIfPassedZero:(NSMutableArray*)arrayToCheck :(int)index :(int*)toStoreIn
{
    if(([arrayToCheck[index] doubleValue] >= 0 && [arrayToCheck[index-1] doubleValue] <= 0) ||
       ([arrayToCheck[index] doubleValue] <= 0 &&
        [arrayToCheck[index-1] doubleValue] >= 0))
    {
        (*toStoreIn)++;
    }
}
@end
