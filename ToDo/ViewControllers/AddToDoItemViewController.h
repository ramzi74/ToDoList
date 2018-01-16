//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by Ramzi on 1/12/18.
//
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddToDoItemViewController : UIViewController <UITextFieldDelegate>

@property ToDoItem *ItemToDo;

@end
