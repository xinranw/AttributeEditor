Welcome to AttributeEditor
======

This is a basic calculator app with support for +, -, *, /, sign reveral, and percentage calculations.

How do I use it?
------

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