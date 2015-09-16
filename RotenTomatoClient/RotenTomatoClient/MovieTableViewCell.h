//
//  MovieTableViewCell.h
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTMovie;

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UILabel *titleLeft;
@property (weak, nonatomic) IBOutlet UILabel *titleRight;

@property RTMovie* movie;

-(void) initWithMovie:(NSArray *)list leftIndex:(NSInteger)left rightIndex:(NSInteger)right;
@end
