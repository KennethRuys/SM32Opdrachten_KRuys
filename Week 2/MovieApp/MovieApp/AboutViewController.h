//
//  AboutViewController.h
//  MovieApp
//
//  Created by FHICT on 13/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

- (IBAction)EasterEggAction:(id)sender;
- (IBAction)ShowTextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldOutlet;

@end
