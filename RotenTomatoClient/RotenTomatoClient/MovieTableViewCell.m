//
//  MovieTableViewCell.m
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "RTMovie.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initWithMovie:(NSArray *)list leftIndex:(NSInteger)left rightIndex:(NSInteger)right {
    //first reset previous image
    self.imageViewLeft.image = nil;
    self.imageViewRight.image = nil;
    
    self.imageViewLeft.tag = left;
    self.imageViewRight.tag = right;
    
    if(left < [list count]) {
        RTMovie* movie = list[left];
        [self.imageViewLeft setImageWithURL:[NSURL URLWithString:movie.posterHDUrl]];
        self.titleLeft.text = movie.title;
    }
    
    if(right < [list count]) {
        RTMovie* movie = list[right];
        [self.imageViewRight setImageWithURL:[NSURL URLWithString:movie.posterHDUrl]];
        self.titleRight.text = movie.title;
    }
}

@end
