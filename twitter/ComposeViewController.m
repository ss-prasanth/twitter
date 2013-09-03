//
//  ComposeViewController.m
//  twitter
//
//  Created by Prasanth Sivanappan on 03/09/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"


#define MAX_TWEET_SIZE 140

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Compose";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    
    if ([User currentUser]){
        User *user = [User currentUser];
        self.name.text = [user objectForKey:@"name"];
        self.handle.text = [NSString stringWithFormat:@"@%@", [user objectForKey:@"screen_name"]];
        self.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[user objectForKey:@"profile_image_url"]]]];
        
        
    }
    self.spinner.hidden = YES;
    [self.tweetText setScrollEnabled:YES];
    [self.tweetText setUserInteractionEnabled:TRUE];
    [self.tweetText becomeFirstResponder];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidChange:(UITextView *)textView {

     self.navigationItem.rightBarButtonItem.enabled =  YES;
    NSString* text = textView.text;
    int len = 140 - text.length;
    if (len <= 0) {
        //textView.editable = NO;
        len = 0;
        textView.text = [text substringToIndex:140];
    };
    self.numChar.text = [NSString stringWithFormat:@"%d", len];
    
}
- (void) onTweetButton{
    NSString* tweet = self.tweetText.text;
    
    self.spinner.hidden = NO;
    [self.spinner startAnimating];

    [[TwitterClient instance] sendTweet:tweet success:^(AFHTTPRequestOperation *operation, NSError *error){
        [self.spinner stopAnimating];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [self.spinner stopAnimating];
        [[[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Couldn't send the tweet, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
}

- (void) onCancelButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
