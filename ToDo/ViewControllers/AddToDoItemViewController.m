//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by Ramzi on 1/12/18.
//
//

#import "AddToDoItemViewController.h"
#import "ToDoItem.h"

@interface AddToDoItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtAddItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btDoneButton;

@end

@implementation AddToDoItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self.txtAddItem becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  if (textField == self.txtAddItem){
    [textField resignFirstResponder];
    //if ([textField hasText]){
      //[self dismissViewControllerAnimated:YES completion:nil];
      //[self.btDoneButton ]
      //[self performSegueWithIdentifier:@"addToDoItemSegue" sender:self];
      //[self prepareForSegue:segue sender:self.btDoneButton];
    //}
  }
  return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
  
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  //NSLog(@"segue:%@", segue.identifier);
  if (sender != self.btDoneButton) return;
  if ([self.txtAddItem hasText]) {
    self.ItemToDo = [[ToDoItem alloc] init];
    self.ItemToDo.itemName = self.txtAddItem.text;
    self.ItemToDo.completed = NO;
  }
}
@end
