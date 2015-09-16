//
//  RTMovie.h
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMovie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterUrl;
@property (nonatomic, strong) NSString *posterHDUrl;

@property NSInteger scoreAudience;//user's scores
@property NSInteger scoreCritics;//how refresh the movie


//helper methods
+ (void)fetchMovies:(NSString *)url successCallback:(void(^)(NSArray *))successCallback;

@end
