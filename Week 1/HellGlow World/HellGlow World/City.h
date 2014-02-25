//
//  City.h
//  HellGlow World
//
//  Created by FHICT on 20/02/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
{
    
}

@property NSString *_name;
@property NSInteger _population;
@property NSMutableArray* _glowActs;
@property NSInteger _amountOfActs;

-(id)init;

-(void)showInfo;

@end
