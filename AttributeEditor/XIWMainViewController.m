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
    NSLog(@"this is %d", (int)[_sentenceManager.sentence length]);

    
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

@end
