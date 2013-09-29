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
}

- (void)viewWillAppear: (BOOL)animated
{
    if (self.sentenceManager.sentence != nil){
        _sentenceField.text = self.sentenceManager.sentence;
    }
}

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
        //save the word
        _sentenceManager.sentence = fieldValue;
        
        //advance to the next view
        [self performSegueWithIdentifier:@"Editor" sender:self];
    }
    
}

@end
