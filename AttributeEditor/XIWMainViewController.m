//
//  XIWMainViewController.m
//  AttributeEditor
//
//  Created by User on 9/29/13.
//  Copyright (c) 2013 Xinran Wang. All rights reserved.
//

#import "XIWMainViewController.h"
#import "XIWSentenceManager.h"

@interface XIWMainViewController ()
@property (nonatomic, strong) IBOutlet UITextField *sentenceField;
@property (nonatomic, strong) XIWSentenceManager *sentenceManager;

- (IBAction) clearText:(id)sender;
- (IBAction) saveAndContinue:(id)sender;
@end

@implementation XIWMainViewController
- (XIWSentenceManager *)sentenceManager
{
    if (!_sentenceManager)
        _sentenceManager = [[XIWSentenceManager alloc] init];
    return _sentenceManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Set background image
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setImage:[UIImage imageNamed:@"bg_blue_checkered.png"]];
    backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    [self sentenceManager];
    if ([_sentenceManager.sentence length] > 0)
        [self performSegueWithIdentifier:@"Editor" sender:self];
}

- (void)viewWillAppear: (BOOL)animated
{
    if (self.sentenceManager.sentence != nil){
        _sentenceField.text = self.sentenceManager.sentence;
    }
}

/* 
 Action corresponds to a button press on "Go"
 This stores the entered text into fieldValue, converts into an array of words.
 A check for minimum number of words is performed and an alert is raised if the sentence is too short.
 Otherwise save the entered sentence into memory and advance to the Editor view
 */
 
- (IBAction)saveAndContinue:(id)sender
{
    NSString *fieldValue = _sentenceField.text;
    NSArray *words = [fieldValue componentsSeparatedByCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [_sentenceField resignFirstResponder];
    
    if ([words count] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please put in at least 5 words."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        // Saves input text
        _sentenceManager.sentence = fieldValue;
        
        // Advances view
        [self performSegueWithIdentifier:@"Editor" sender:self];
    }
    
}

/*
 Clears the input area and clears the previous stored text form memory
 */
- (IBAction)clearText:(id)sender
{
    NSString *emptyField = @"";
    _sentenceField.text = emptyField;
    _sentenceManager.sentence = emptyField;
}

@end
