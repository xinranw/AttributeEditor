//
//  XIWSentenceManager.m
//  AttributeEditor
//
//  Created by User on 9/29/13.
//  Copyright (c) 2013 Xinran Wang. All rights reserved.
//

#import "XIWSentenceManager.h"

@implementation XIWSentenceManager

- (NSString *) sentence
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sentence"];
}

- (void)setSentence:(NSString *)sentence
{
    [[NSUserDefaults standardUserDefaults] setObject:sentence forKey:@"sentence"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
