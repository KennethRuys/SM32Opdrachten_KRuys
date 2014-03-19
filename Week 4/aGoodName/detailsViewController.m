//
//  detailsViewController.m
//  aGoodName
//
//  Created by FHICT on 19/03/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import "detailsViewController.h"

@interface detailsViewController ()

@end

@implementation detailsViewController

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

-(void) viewDidAppear:(BOOL)animated
{
    //Todo set the other UI elements
    self.nameOutlet.text = self.selectedPirate.name;
    self.lifeOutlet.text = self.selectedPirate.life;
    self.yearsOutlet.text = self.selectedPirate.active;
    self.birthOutlet.text = self.selectedPirate.countryOfOrigin;
    self.commentsOutlet.text = self.selectedPirate.comments;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
