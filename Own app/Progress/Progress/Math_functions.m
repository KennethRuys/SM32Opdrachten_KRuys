//
//  Math_functions.m
//  Progress
//
//  Created by FHICT on 16/04/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "Math_functions.h"

@implementation Math_functions

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

-(double)computeAverage:(NSMutableArray*)source_array
{
    double storage = 0;
    for(int i = 0; i < source_array.count; i++)
    {
        storage += [source_array[i] doubleValue];
    }
    return storage/source_array.count;
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
