//
//  ToDoItem.h
//  ToDoList
//
//  Created by Ramzi on 1/12/18.
//
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property (nonatomic) BOOL completed;
@property (readonly) NSDate *creationDate;
@property (readonly) NSDate *completionDate;
@property (strong, nonatomic) NSArray *subItems;

-(ToDoItem *)initWithDictionary:(NSDictionary *)dictItem;
-(NSDictionary *)toDictionary;

@end
