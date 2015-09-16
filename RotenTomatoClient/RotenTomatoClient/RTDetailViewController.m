//
//  RTDetailViewController.m
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "RTDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "RTMovie.h"

@interface RTDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation RTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(Back)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = self.movie.title;

    
    [self updateUI];
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateUI {
    [self.imageView setImageWithURL:[NSURL URLWithString:self.movie.posterHDUrl]];
}

-(void) setMovieInfo:(RTMovie *)movie {
    self.movie = movie;
    if(self.isViewLoaded) {
        [self updateUI];
    }
}

         
         
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
