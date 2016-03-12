//
//  TableViewController.m
//  MultiSelectionTable
//
//  Created by Hoàng Thái on 3/12/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "TableViewController.h"
#import "Person.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    NSMutableArray *arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        Person *person = [[Person alloc] init];
        [arrayData addObject:person];
    }
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                           target:self
                                                                                           action:@selector(add)]; 
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self 
                                                                            action:@selector(edit)];
}

- (void) add {
    if (arrayData.count == 0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self 
                                                                                action:@selector(edit)];
    }
    Person *person = [[Person alloc] init];
    [arrayData addObject:person];
    [self.tableView reloadData];
}

- (void) edit {
    if (self.tableView.editing) {
        [self.tableView setEditing:false animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self 
                                                                                action:@selector(edit)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                               target:self
                                                                                               action:@selector(add)]; 
        if (arrayData.count == 0) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    } else {
        [self.tableView setEditing:true animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain 
                                                                                 target:self
                                                                                 action:@selector(delete)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
                                                                                 style:(UIBarButtonItemStylePlain) 
                                                                                target:self action:@selector(edit)];
    }
}

- (void) delete {
    NSArray *selectedRows;
    selectedRows = self.tableView.indexPathsForSelectedRows;
    if (selectedRows > 0) {
        NSMutableIndexSet *indiciesOfItemToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectedIndex in selectedRows) {
            [indiciesOfItemToDelete addIndex: selectedIndex.row];
        }
        [arrayData removeObjectsAtIndexes:indiciesOfItemToDelete];
        [self.tableView deleteRowsAtIndexPaths:selectedRows
                              withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }
    if (arrayData.count == 0) {
        [self.tableView setEditing:false animated:YES];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                               target:self
                                                                                               action:@selector(add)]; 
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Person *person = arrayData[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.age;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayData removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Person *person = [Person new];
    person = arrayData[sourceIndexPath.row];
    [arrayData removeObjectAtIndex:sourceIndexPath.row];
    [arrayData insertObject:person atIndex:destinationIndexPath.row];
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

@end
