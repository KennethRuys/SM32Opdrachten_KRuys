//
//  DetailViewController.h
//  Progress
//
//  Created by FHICT on 19/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
