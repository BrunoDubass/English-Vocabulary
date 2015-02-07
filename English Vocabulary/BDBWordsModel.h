//
//  BDBWordsModel.h
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBWordsModel : NSObject

#pragma mark - PROPERTIES

@property (strong) NSDictionary* words;

#pragma mark - UTILS

-(NSArray *) letters;
-(NSString *) letterAtIndex: (NSInteger) aLetterIndex;
-(NSString *) wordAtIndex:(NSInteger) aWordIndex inLetterAtIndex:(NSInteger) aLetterIndex;
-(NSArray *) wordsAtIndex:(NSInteger) anIndex;

@end
