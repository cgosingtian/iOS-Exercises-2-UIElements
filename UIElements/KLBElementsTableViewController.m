//
//  KLBElementsTableViewController.m
//  UIElements
//
//  Created by Chase Gosingtian on 8/21/14.
//  Copyright (c) 2014 KLab Cyscorpions, Inc. All rights reserved.
//

#import "KLBElementsTableViewController.h"
#import "KLBJSONController.h"
#import "KLBEmployeeStore.h"
#import "KLBEmployeeViewController.h"
#import "KLBConstants.h"
#import "KLBEmployeeTableViewCell.h"

// quick hack to make this controller appear; the
// coupling of this and the WebViewController is not optimal
#import "KLBWebViewController.h"

@interface KLBElementsTableViewController ()

@property (nonatomic,retain) NSMutableArray *viewList;
@property (nonatomic,retain) NSMutableArray *sections;
@property (nonatomic,retain) NSMutableArray *sectionContent;

@end

@implementation KLBElementsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_viewList) {
        _viewList = [[NSMutableArray alloc] init];
    }
    
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    if (!_sectionContent) {
        _sectionContent = [[NSMutableArray alloc] init];
    }
    
    [self setTitle:@"Employee Records"];
    
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL];
    
//    [[self tableView] registerClass:[KLBEmployeeTableViewCell class] forCellReuseIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL];
//    UINib *nib = [UINib nibWithNibName:KLB_EMPLOYEE_TABLE_VIEW_CELL bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //load JSON
    NSDictionary *loadedDictionary = [KLBJSONController loadJSONfromFile:@"tc"];
    [[KLBEmployeeStore sharedStore] setAllItems:[loadedDictionary mutableCopy]];
    
    //just use loadedDictionary for convenience
    for (NSString *key in loadedDictionary) {
        [_sections addObject:key];
        int entries = 0;
        int index = 0;
        for (NSDictionary *employee in [loadedDictionary objectForKey:key]) {
            KLBEmployeeViewController *evc = [[KLBEmployeeViewController alloc] initWithNibName:nil bundle:nil section:key index:index];
            [_viewList addObject:evc];
            [evc release];
            entries++;
            index++;
            
//            for (NSString *key in [employee allKeys]) {
//                NSLog(@"%@ - %@",key,[employee[key] class]);
//            }
        }
        [_sectionContent addObject:[NSNumber numberWithInt:entries]];
    }
    
    
    NSLog(@"add web button");
    //display the web view controller by pressing a button
    UIBarButtonItem *webButton = [[UIBarButtonItem alloc] initWithTitle:@"Web" style:UIBarButtonItemStylePlain target:self action:@selector(showWebView)];
    
    [[self navigationItem] setRightBarButtonItem:webButton];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[_sectionContent objectAtIndex:section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //KLBEmployeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL forIndexPath:indexPath];
    
//    if (cell == nil)
//    {
//        cell = [[KLBEmployeeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KLB_EMPLOYEE_TABLE_VIEW_CELL];
//    }
 
    int index = indexPath.row;
    if (indexPath.section > 0) {
        for (int i = indexPath.section; i > 0; i--) {
            index += [[_sectionContent objectAtIndex:indexPath.section-i]intValue];
        }
    }
    KLBEmployeeViewController *evc = [_viewList objectAtIndex:index];
    NSDictionary *dictionary = [[KLBEmployeeStore sharedStore] employeeWithSection:[evc section] index:[evc index]];
//    cell.nameLabel.text = [dictionary objectForKey:KLB_NAME_KEY];
//    cell.sectionLabel.text = [_sections objectAtIndex:indexPath.section];
//    cell.ratingLabel.text = [dictionary objectForKey:KLB_RATING_KEY];
    
    cell.textLabel.text = [dictionary objectForKey:KLB_NAME_KEY];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_sections objectAtIndex:section];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
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
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate
 
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    if (indexPath.section > 0) {
        for (int i = indexPath.section; i > 0; i--) {
            index += [[_sectionContent objectAtIndex:indexPath.section-i]intValue];
        }
    }
    KLBEmployeeViewController *evc = [_viewList objectAtIndex:index];
 
    [self.navigationController pushViewController:evc animated:YES];
}

#pragma mark - Web View Controller
- (void)showWebView {
    KLBWebViewController *wvc = [[KLBWebViewController alloc] init];
    [self.navigationController pushViewController:wvc animated:NO];
}


@end
