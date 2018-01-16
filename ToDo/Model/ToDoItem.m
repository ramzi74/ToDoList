//
//  ToDoItem.m
//  ToDoList
//
//  Created by Ramzi on 1/12/18.
//
//

#import "ToDoItem.h"

@interface ToDoItem ()
//Private Properties..

@end

@implementation ToDoItem

-(id) init {
  self = [super init];
  if (self){
    _creationDate = [NSDate date];
    _completionDate = [NSDate distantPast];//so as to not assign it nill!! plist will not register a nil thus SEGFAULTs.
    return self;
  }
  return nil;
}

-(void) setCompleted:(BOOL)completed{
  if (completed)
    _completionDate = [NSDate date];
  else
    _completionDate = [NSDate distantPast];
  _completed = completed;
}

-(ToDoItem *)initWithDictionary:(NSDictionary *)dictItem{
  self = [super init];
  if (self){
    _itemName = [dictItem objectForKey:@"itemName"];
    _creationDate = [dictItem objectForKey:@"creationDate"];
    _completed = [[dictItem objectForKey:@"completed"] boolValue];
    _completionDate = [dictItem objectForKey:@"completionDate"];
  }
  return self;
}

-(NSDictionary *)toDictionary{
  NSDictionary * dictItem = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _itemName, @"itemName",
                             [NSNumber numberWithBool:_completed], @"completed",
                             _creationDate, @"creationDate",
                             _completionDate, @"completionDate",
                             nil];
  return dictItem;
}



@end
