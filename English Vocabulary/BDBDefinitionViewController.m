//
//  BDBDefinitionViewController.m
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBDefinitionViewController.h"



@interface BDBDefinitionViewController ()

@end

@implementation BDBDefinitionViewController


-(id)initWithModel:(NSString*)aModel{
    if (self = [super init]) {
        _wordModel = aModel;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.activity startAnimating];
    [self.activity setHidden:NO];
    self.browser.delegate = self;
    [self syncViewModel];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DELEGATE

-(void)wordsTable:(BDBWordsTableViewController *)tableView didSelectWord:(NSString *)aWord{
    
    _wordModel = aWord;
    [self.activity startAnimating];
    [self.activity setHidden:NO];
    [self syncViewModel];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activity stopAnimating];
    [self.activity setHidden:YES];
}

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{

        if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
            
            self.navigationItem.rightBarButtonItem = svc.displayModeButtonItem;
            
        }else if(displayMode == UISplitViewControllerDisplayModeAllVisible){
            
            self.navigationItem.rightBarButtonItem = nil;
    }
    
}

#pragma mark - UTILS

-(NSURLRequest *) definitionRequestForWord: (NSString *) aWord{
    NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"http://www.merriam-webster.com/dictionary/%@", aWord]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}


-(void)syncViewModel{
    
    self.title = self.wordModel;
    [self.browser loadRequest:[self definitionRequestForWord:self.wordModel]];
    
}

@end
