//
//  detailsViewController.h
//  aGoodName
//
//  Created by FHICT on 19/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pirate.h"

@interface detailsViewController : UIViewController

@property Pirate *selectedPirate;

@property (weak, nonatomic) IBOutlet UILabel *nameOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lifeOutlet;
@property (weak, nonatomic) IBOutlet UILabel *yearsOutlet;
@property (weak, nonatomic) IBOutlet UILabel *birthOutlet;

@property (weak, nonatomic) IBOutlet UITextView *commentsOutlet;

@end
