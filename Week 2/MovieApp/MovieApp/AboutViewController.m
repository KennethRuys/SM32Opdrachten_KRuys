//
//  AboutViewController.m
//  MovieApp
//
//  Created by FHICT on 13/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EasterEggAction:(id)sender {
}

- (IBAction)ShowTextAction:(id)sender {
    //read the text from the IBOutlet. make sure you use the name you gave to the IBoutlet of the textfield
    NSString* selectedText = self.TextFieldOutlet.text;
    
    //Create an AlertView. This view can show a dialog.
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"Your text is:" message:selectedText delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
    //Actualy show the dialog by sending the 'show' message
    [alertView show];
}
@end
