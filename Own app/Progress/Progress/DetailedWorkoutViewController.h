//
//  DetailedWorkoutViewController.h
//  Progress
//
//  Created by FHICT on 27/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


NSMutableArray *X_baseline_array;
NSMutableArray *Y_baseline_array;
NSMutableArray *Z_baseline_array;

NSMutableArray *X_first_record_array;
NSMutableArray *Y_first_record_array;
NSMutableArray *Z_first_record_array;

double X_baseline;
double Y_baseline;
double Z_baseline;


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

@end
