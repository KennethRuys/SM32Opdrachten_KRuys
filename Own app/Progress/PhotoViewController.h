//
//  PhotoViewController.h
//  Progress
//
//  Created by FHICT on 03/04/14.
//  Copyright (c) 2014 FHICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

@end
