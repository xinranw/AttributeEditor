Welcome to AttributeEditor
======

This app allows an user to input text and then apply formatting to each word. Currently, only text color formatting is allowed. 

How do I use it?
------
Input a sentence (with at least five words) on the home screen, then press go to move on to the editing page. There, use the +/- stepper to move between words, and press the desired buttons to apply formatting.
Press clear on the home screen to clear the input line. 

Bugs
------
Repeated words:
When the stepper is pressed, the app uses the stepper's index to find what should be the selected string. 
When an attribute is to be applied however, the addLabelAttributes function looks for the selected string in the editingLabel to apply the attribute (see code below).
```objective-c
NSString *selectedString = [self.words objectAtIndex:(int)self.wordStepper.value];
NSRange range = [[self.editingLabel.attributedText string]rangeOfString:selectedString];
```
Due to this process, if the string that is supposed to be selected occurs before, the earliest occurance is selected and set to be range. As a result, the attribute is applied to range, which is different from what is supposed to be selected.