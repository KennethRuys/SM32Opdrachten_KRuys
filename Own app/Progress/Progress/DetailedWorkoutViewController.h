//
//  DetailedWorkoutViewController.h
//  Progress
//
//  Created by FHICT on 27/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <Parse/Parse.h>
#import "Math_functions.h"

NSMutableArray *X_baseline_array;
NSMutableArray *Y_baseline_array;
NSMutableArray *Z_baseline_array;

NSMutableArray *X_first_record_array;
NSMutableArray *Y_first_record_array;
NSMutableArray *Z_first_record_array;

NSMutableArray *X_array_container;
NSMutableArray *Y_array_container;
NSMutableArray *Z_array_container;

NSMutableArray *X_current;
NSMutableArray *Y_current;
NSMutableArray *Z_current;

NSMutableArray *X_current_delta;
NSMutableArray *Y_current_delta;
NSMutableArray *Z_current_delta;

NSMutableArray *X_current_MA;
NSMutableArray *Y_current_MA;
NSMutableArray *Z_current_MA;

double X_baseline;
double Y_baseline;
double Z_baseline;

int amountOfTimesDone = 0;
bool previousValue = false;
int skipTill = 0;

Math_functions *mf;



@interface DetailedWorkoutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *contentsList;
@property (weak, nonatomic) IBOutlet UILabel *xlabel;
@property (weak, nonatomic) IBOutlet UILabel *ylabel;
@property (weak, nonatomic) IBOutlet UILabel *zlabel;

@property (strong, nonatomic)CMMotionManager *motionManager;
- (IBAction)baselineMeasurement:(id)sender;
- (IBAction)firstRecordingStart:(id)sender;
- (IBAction)firstRecordingStop:(id)sender;

- (IBAction)start_check:(id)sender;
- (IBAction)stop_check:(id)sender;

@end
