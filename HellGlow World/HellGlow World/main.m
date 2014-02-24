//
//  main.m
//  HellGlow World
//
//  Created by FHICT on 20/02/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GlowAct.h"
#import "City.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        GlowAct* blueLightAct = [GlowAct alloc];
        blueLightAct._name = @"The Bluelight act";
        blueLightAct._startTime = @"22:20";
        blueLightAct._rating = 8;
        
        GlowAct* pinkLightAct = [GlowAct alloc];
        pinkLightAct._name = @"The Pinklight act";
        pinkLightAct._startTime=@"23:30";
        pinkLightAct._rating = 7;
        
        City* cityObject = [[City alloc] init];
        cityObject._name = @"Eindhoven";
        cityObject._population = 220000;
        
        [cityObject._glowActs addObject:blueLightAct];
        [cityObject._glowActs addObject:pinkLightAct];
        cityObject._amountOfActs = [cityObject._glowActs count];
        [cityObject showInfo];
    }
    return 0;
}

