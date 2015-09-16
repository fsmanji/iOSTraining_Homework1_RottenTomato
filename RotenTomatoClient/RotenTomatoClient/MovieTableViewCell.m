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

-(void) initWithMovieLeft:(RTMovie *)movieLeft andMovieRight:(RTMovie *)movieRight {
    //first reset previous image
    self.imageViewLeft.image = nil;
    self.imageViewRight.image = nil;
    
    if(movieLeft) {
        [self.imageViewLeft setImageWithURL:[NSURL URLWithString:movieLeft.posterUrl]];
        self.titleLeft.text = movieLeft.title;
    }
    
    if(movieRight) {
        [self.imageViewRight setImageWithURL:[NSURL URLWithString:movieRight.posterUrl]];
        self.titleRight.text = movieRight.title;
    }
}

@end
