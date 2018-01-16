//
//  ToDoListViewController.m
//  ToDoList
//
//  Created by Ramzi on 1/12/18.
//
//

#import "ToDoListViewController.h"
#import "ToDoItem.h"
#import "AddToDoItemViewController.h"
#import "MyFuncLibDLOG.h"

@interface ToDoListViewController ()

@property NSMutableArray *toDoItems;


@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadInitialData {
  ToDoItem *item1 = [[ToDoItem alloc] init];
  item1.itemName = @"Apply to iTrellis";
  item1.completed = NO;
  [self.toDoItems addObject:[item1 toDictionary]];
  ToDoItem *item2 = [[ToDoItem alloc] init];
  item2.itemName = @"Join iTrellis"; item2.completed = NO;
  [self.toDoItems addObject:[item2 toDictionary]];
  
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  self.toDoItems = [[NSMutableArray alloc] init];
  self.toDoItems = [self loadPList];
  if ([self.toDoItems count] <= 0)
    [self loadInitialData];
  
  //load other plist
  //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ToDo" ofType:@"plist"];
  //NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
  //[self.toDoItems writeToFile:filePath atomically:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
    return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"ListProtoTypeCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  static NSDateFormatter *formatter = nil;
  if (formatter == nil) {
    formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    //[formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"EEE MM/dd/YYYY HH:mm:ss a"];
  }
  ToDoItem *tdi = [[ToDoItem alloc] initWithDictionary:[self.toDoItems objectAtIndex:indexPath.row]];
// Configure the cell...
  cell.textLabel.text = tdi.itemName;
  if (tdi.completed) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //cell.detailTextLabel.text = ;
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Completed: %@",[formatter stringFromDate:(NSDate *)tdi.completionDate]]];
  }
  else {
    cell.accessoryType = UITableViewCellAccessoryNone;
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"Created: %@",[formatter stringFromDate:(NSDate *)tdi.creationDate]]];
  }
  return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      // Delete the row from the data source
      [self.toDoItems removeObjectAtIndex:indexPath.row];
      [self savePList];
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//TableView Swap/Move Cells:
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
  [self.toDoItems exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
  [self savePList];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  ToDoItem *tappedItem = [[ToDoItem alloc] initWithDictionary:[self.toDoItems objectAtIndex:indexPath.row]];
  tappedItem.completed = !tappedItem.completed;
  [self.toDoItems replaceObjectAtIndex:indexPath.row withObject:[tappedItem toDictionary]];
  [self savePList];
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  
}

#pragma mark - Navigation Segue.
-(IBAction)unwindToList:(UIStoryboardSegue *)segue
{
  AddToDoItemViewController *sourceVC = [segue sourceViewController];
  ToDoItem *addedItem = sourceVC.ItemToDo;
  if (addedItem != nil) {
    [self.toDoItems addObject:[addedItem toDictionary]];
    [self savePList];
    [self.tableView reloadData];
  }
}

#pragma mark - Load/Save:
-(NSMutableArray *)loadPList {
  NSMutableArray *retVal;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"ToDo.plist"];
//  NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ToDo.plist"];
  
  if ([filePath length] > 0)
  {
    retVal = [NSMutableArray arrayWithContentsOfFile:filePath];
  }
  if (!retVal)
  {
    retVal = [[NSMutableArray alloc] init];
  }
  return retVal;
}
-(void)savePList {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"ToDo.plist"];
  //NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ToDo.plist"];
  
  BOOL success = [_toDoItems writeToFile:filePath atomically:YES];
  if (!success) {
    //DLog(@"WRITE ERROR file:%@", filePath);
  }
  else
    ;//DLog(@"WROTEFILE:%@", filePath);
}


@end
