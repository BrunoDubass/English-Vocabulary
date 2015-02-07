//
//  BDBDefinitionViewController.h
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
#import "BDBWordsTableViewController.h"


@interface BDBDefinitionViewController : UIViewController <BDBWordsTableViewControllerDelegate, UIWebViewDelegate, UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSString* wordModel;

-(id)initWithModel:(NSString*)aModel;

@end
