//
//  Math_functions.h
//  Progress
//
//  Created by FHICT on 16/04/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Math_functions : NSObject

-(id)init;

-(double)computeAverage:(NSMutableArray*)source_array;
-(void)removeBadArrayValues:(NSMutableArray*)source_array;
-(void)convertToMovingAverage: (NSMutableArray*)source_array:(NSMutableArray*)destination_array;
-(void)convertToDeltaArray: (NSMutableArray*)source_array:(NSMutableArray*)destination_array;
-(void)trimArray:(NSMutableArray*)toBeTrimmed;
-(void)trimStartFromArray:(NSMutableArray*)toBeTrimmed;
-(void)trimEndFromArray:(NSMutableArray*)toBeTrimmed;
-(void)splitIntoMultipleArrays:(NSMutableArray*)source_array:(NSMutableArray*)destination_array;
-(BOOL)arrayCompare:(NSMutableArray*)current_data:(NSMutableArray*)compare_stack;
-(void)checkIfPassedZero:(NSMutableArray*)arrayToCheck :(int)index :(int*)toStoreIn;

@end
