//
//  AppDelegate.h
//  Progress
//
//  Created by FHICT on 19/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Exercise.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableArray * exerciseList;

-(void)addExerciseListItem : (Exercise*) exer;
-(NSMutableArray*)getExerciseList;

@end
