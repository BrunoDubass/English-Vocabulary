//
//  BDBWordsTableViewController.m
//  English Vocabulary
//
//  Created by Bruno Domínguez on 16/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBWordsTableViewController.h"
#import "BDBWordsModel.h"
#import "BDBDefinitionViewController.h"

@interface BDBWordsTableViewController ()

@end

@implementation BDBWordsTableViewController

#pragma mark - INITS

-(id)initWithModel:(BDBWordsModel*)aModel{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _wordsModel = aModel;
        self.title = @"English Vocabulary";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [[self.wordsModel letters]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [[self.wordsModel wordsAtIndex:section]count];
    }

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.wordsModel letters]objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    NSString* word = nil;
    word = [self.wordsModel wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section];
    
    static NSString* cellId = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = word;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - DELEGATE

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* word = [self.wordsModel wordAtIndex:indexPath.row inLetterAtIndex:indexPath.section];
   
    [self.delegate wordsTable:self didSelectWord:word];
    [self saveLastSelectedWordAtSection:indexPath.section row:indexPath.row];
    
}

-(void)wordsTable:(BDBWordsTableViewController *)tableView didSelectWord:(NSString *)aWord{
    
    BDBDefinitionViewController* defVC = [[BDBDefinitionViewController alloc]initWithModel:aWord];
    [self.navigationController pushViewController:defVC animated:YES];
}

#pragma mark - DEFAULTS

-(NSDictionary*)setDefaults{
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* defaultWord = @{@"section":@0, @"row":@0};
    [defaults setValue:defaultWord forKey:@"lastSelectedWord"];
    
    [defaults synchronize];
    
    return defaultWord;
}

-(void)saveLastSelectedWordAtSection:(NSUInteger)section row:(NSUInteger)row{
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{@"section":@(section), @"row":@(row)} forKey:@"lastSelectedWord"];
    [defaults synchronize];
    
}

-(NSString*)lastSelectedWord{
    
    
    NSDictionary* coord = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastSelectedWord"];
    
    if (coord == nil) {
        coord = [self setDefaults];
    }
    NSIndexPath* indexP = [NSIndexPath indexPathForRow:[[coord objectForKey:@"row"]integerValue]
                                             inSection:[[coord objectForKey:@"section"]integerValue]];
    
    return [self.wordsModel wordAtIndex:indexP.row inLetterAtIndex:indexP.section];
}


@end
