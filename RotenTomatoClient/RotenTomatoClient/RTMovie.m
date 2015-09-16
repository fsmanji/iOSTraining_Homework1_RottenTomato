//
//  RTMovie.m
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "RTMovie.h"
#import "AFHTTPRequestOperationManager.h"

@interface RTMovie ()
@end

@implementation RTMovie


- (void)initializeWithDictionary:(NSDictionary *)jsonResult {
    self.title = jsonResult[@"title"];
    self.year = jsonResult[@"year"];
    self.synopsis = jsonResult[@"synopsis"];
    self.posterUrl = jsonResult[@"posters"][@"thumbnail"];
    self.scoreAudience = [jsonResult[@"ratings"][@"audience_score"] integerValue];
    self.scoreCritics = [jsonResult[@"ratings"][@"critics_score"] integerValue];
    
    
    NSRange range = [self.posterUrl rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        self.posterHDUrl = [self.posterUrl stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    
    NSLog(@"title=%@\n\tyear=%@\n\turl=%@\n\tdescription=%@\n\t", self.title,
          self.year,
          self.posterUrl,
          self.synopsis);
}

+ (void)fetchMovies:(NSString *)url successCallback:(void(^)(NSArray *))successCallback {
   /* AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableArray *movieList = [[NSMutableArray alloc] init];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *results = responseObject[@"movies"];
        if (results) {
            
            for (NSDictionary *result in results) {
                RTMovie *movie = [[RTMovie alloc] init];
                [movie initializeWithDictionary:result];
                [movieList addObject:movie];
            }
            successCallback(movieList);
            NSLog(@"JSON: %@", responseObject);
        }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Failure while trying to fetch repos");
         successCallback(movieList);
     }];
    */

     NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         //parse 'movies' json
         NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         NSArray *results = responseObject[@"movies"];
         NSMutableArray *movieList = [[NSMutableArray alloc] init];
         if (results) {
             
             for (NSDictionary *result in results) {
                 RTMovie *movie = [[RTMovie alloc] init];
                 [movie initializeWithDictionary:result];
                 [movieList addObject:movie];
             }
             successCallback(movieList);
             NSLog(@"JSON: %@", responseObject);
         }
         NSLog(@"JSON: %@", movieList);
     }];
     
}

@end
