//
//  FISSentence.m
//  objc-fissentence
//
//  Created by Flatiron School on 6/9/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISSentence.h"

@interface FISSentence ()
@property (strong, nonatomic, readwrite) NSString *sentence;
@end

@implementation FISSentence

// The following four methods are private (only implemented in FISSentence.m). These are helper methods to ensure that argument input to public methods is valid.
-(void)assembleSentence {
    self.sentence = [self.words componentsJoinedByString:@" "];
    self.sentence = [self.sentence stringByAppendingFormat:@"%@", self.punctuation];
}

-(BOOL)validWord:(NSString *)word {
    if ([word isEqualToString:@" "] ||
        [word isEqualToString:@""] ||
        !word) {
        return NO;
    }
    return YES;
}

-(BOOL)validPunctuation:(NSString *)punctuation {
    // Define an NSCharacterSet with the valid punctuation marks for FISSentence objects.
    NSCharacterSet *punctuations = [NSCharacterSet characterSetWithCharactersInString:@".?!,;:—"];
    
    // This checks the NSCharacterSet against the argument punctuation mark. If the argument does not have a location in the NSCharacterSet, the boolean evaulates to yes and the method returns NO not a valid punctuation mark.
    if ([punctuation rangeOfCharacterFromSet:punctuations].location == NSNotFound ||
        !punctuation) {
        return NO;
    }
    return YES;
}

-(BOOL)validIndex:(NSUInteger)index {
    if (index < self.words.count) {
        return YES;
    }
    return NO;
}


// The following six methods are public (declared in FISSentence.h).
-(void)addWord:(NSString *)word {
    if ([self validWord:word]) {
        [self.words addObject: word];
    }
    [self assembleSentence];
}

-(void)addWords:(NSArray *)words withPunctuation:(NSString *)punctuation {
    // Check to make sure that the argument words array is not empty or nil.
    if ([words isEqualToArray:@[]] ||
         !words) {
        return;
    }
    // Looping through the array, only add valid words from the argument array to the words property.
    for (NSString *word in words) {
        if ([self validWord:word]) {
            [self.words addObject:word];
        }
    // Escape method implementation if the argument punctuation is invalid.
    } if (![self validPunctuation:punctuation]) {
        return;
    }
    // Otherwise, assign punctuation property to the argument.
    self.punctuation = punctuation;
    [self assembleSentence];
}

-(void)removeWordAtIndex:(NSUInteger)index {
    if (![self validIndex:index]) {
        return;
    }
    [self.words removeObjectAtIndex:index];
    [self assembleSentence];
}

-(void)insertWord:(NSString *)word atIndex:(NSUInteger)index {
    if ([self validIndex:index] &&
        [self validWord:word]) {
        [self.words insertObject:word atIndex:index];
    }
    [self assembleSentence];
}

-(void)replacePunctuationWithPunctuation:(NSString *)punctuation {
    if ([self validPunctuation:punctuation]) {
        self.punctuation = punctuation;
    }
    [self assembleSentence];
}

-(void)replaceWordAtIndex:(NSUInteger)index withWord:(NSString *)word {
    if ([self validIndex:index] &&
        [self validWord:word]) {
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    [self assembleSentence];
}

@end

