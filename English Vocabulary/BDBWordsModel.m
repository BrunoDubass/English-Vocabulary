//
//  BDBWordsModel.m
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBWordsModel.h"

@implementation BDBWordsModel

#pragma mark - PROPERTIES

#pragma mark - INITS

-(id)init{
    if (self = [super init]) {
        
        NSURL* vocabularyURL = [[NSBundle mainBundle]URLForResource:@"Vocabwords" withExtension:@"txt"];
        self.words = [NSDictionary dictionaryWithContentsOfURL:vocabularyURL];
    }
    return self;
}

#pragma mark - UTILS

-(NSArray *) letters{
    
    return [[self.words allKeys]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}
-(NSString *) letterAtIndex: (NSInteger) aLetterIndex{
    
    return [[self letters]objectAtIndex:aLetterIndex];
}

-(NSArray *) wordsAtIndex:(NSInteger) anIndex{
    
    NSString* letter = [[self letters]objectAtIndex:anIndex];
    return [[self.words objectForKey:letter]sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSString *) wordAtIndex:(NSInteger) aWordIndex inLetterAtIndex:(NSInteger) aLetterIndex{
    
    return [[self wordsAtIndex:aLetterIndex]objectAtIndex:aWordIndex];
    
    
}

@end
