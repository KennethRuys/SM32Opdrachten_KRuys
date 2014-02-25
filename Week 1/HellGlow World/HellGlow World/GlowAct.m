
//
//  GlowAct.m
//  HellGlow World
//
//  Created by FHICT on 20/02/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "GlowAct.h"

@implementation GlowAct

@synthesize _name;
@synthesize _rating;
@synthesize _startTime;


-(void)showInfo
{
    NSLog(@"The act is called %@ and will start at %@. People gave it a rating of %ld", _name, _startTime, _rating);
}
@end
