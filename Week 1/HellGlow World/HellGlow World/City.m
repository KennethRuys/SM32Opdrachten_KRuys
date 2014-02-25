//
//  City.m
//  HellGlow World
//
//  Created by FHICT on 20/02/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "City.h"
#import "GlowAct.h"

@implementation City

@synthesize _name;
@synthesize _population;
@synthesize _glowActs;
@synthesize _amountOfActs;

-(id)init
{
    if(self == [super init])
    {
        _glowActs = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)showInfo
{
    NSLog(@"In the city of %@ there are currently living %ld people. Currently there are %ld acts", _name, _population, _amountOfActs);
    for(GlowAct* key in _glowActs)
    {
        [key showInfo];
    }
}
@end
