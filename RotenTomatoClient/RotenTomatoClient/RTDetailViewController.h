//
//  RTDetailViewController.h
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTMovie;

@interface RTDetailViewController : UIViewController

@property RTMovie *movie;
-(void) setMovieInfo:(RTMovie *)movie;

@end
