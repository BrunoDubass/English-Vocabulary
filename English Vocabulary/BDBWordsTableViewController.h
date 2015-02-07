//
//  BDBWordsTableViewController.h
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBWordsModel;
@class BDBWordsTableViewController;



@protocol BDBWordsTableViewControllerDelegate <NSObject>

-(void)wordsTable:(BDBWordsTableViewController*)tableView didSelectWord:(NSString*)aWord;

@end


@interface BDBWordsTableViewController : UITableViewController <BDBWordsTableViewControllerDelegate>

#pragma mark - PROPERTIES

@property (weak, nonatomic) id<BDBWordsTableViewControllerDelegate>delegate;
@property (strong, nonatomic) BDBWordsModel* wordsModel;

#pragma mark - INITS

-(id)initWithModel:(BDBWordsModel*)aModel;

-(NSString*)lastSelectedWord;

@end
