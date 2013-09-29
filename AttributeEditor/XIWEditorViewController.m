//
//  XIWEditorViewController.m
//  AttributeEditor
//
//  Created by User on 9/29/13.
//  Copyright (c) 2013 Xinran Wang. All rights reserved.
//

#import "XIWEditorViewController.h"
#import "XIWSentenceManager.h"

@interface XIWEditorViewController ()
@property (nonatomic, strong) XIWSentenceManager *sentenceManager;
@property (nonatomic, strong) NSArray *words;

@property (nonatomic, strong) IBOutlet UILabel *editingLabel;
@property (nonatomic, strong) IBOutlet UILabel *wordCount;
@property (nonatomic, strong) IBOutlet UILabel *currentWord;
@property (nonatomic, strong) IBOutlet UIStepper *wordStepper;

-(void)updateUI;
-(IBAction)changeColor:(UIButton *)sender;
-(IBAction)selectWord:(id)sender;

@end


@implementation XIWEditorViewController
- (XIWSentenceManager *)sentenceManager
{
    if (!_sentenceManager)
        _sentenceManager = [[XIWSentenceManager alloc] init];
    return _sentenceManager;
}

- (NSArray *)words
{
    if (!_words) {
        NSCharacterSet *whitespaceCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *sentence = _sentenceManager.sentence;
        _words = [sentence componentsSeparatedByCharactersInSet:whitespaceCharSet];
    }
    return _words;
}

-(IBAction)selectWord:(id)sender
{
    [self updateUI];
}

- (void)updateUI
{
    NSString *currentString = [_words objectAtIndex:(int)self.wordStepper.value];
    _currentWord.text = [NSString stringWithFormat:@"Current Word: %@", currentString];
    [self addLabelAttributes: @{ NSBackgroundColorAttributeName : [UIColor whiteColor] }
                       range:NSMakeRange(0, [self.editingLabel.attributedText length])];
    [self addLabelAttributes: @{ NSBackgroundColorAttributeName : [UIColor yellowColor] }];
}

- (void)addLabelAttributes: (NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.editingLabel.attributedText mutableCopy];
        [mat addAttributes:attributes
                     range:range];
        self.editingLabel.attributedText = mat;
    }
}

- (void)addLabelAttributes: (NSDictionary *)attributes
{
    NSString *selectedString = [self.words objectAtIndex:(int)self.wordStepper.value];
    NSRange range = [[self.editingLabel.attributedText string]rangeOfString:selectedString];
    
    [self addLabelAttributes:attributes range:range];
}

- (IBAction)changeColor:(UIButton *)sender
{
    [self addLabelAttributes:@{ NSForegroundColorAttributeName : sender.backgroundColor }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _editingLabel.text = self.sentenceManager.sentence;
    _wordCount.text = [NSString stringWithFormat:@"Words: %d", [self.words count]];
}

@end
