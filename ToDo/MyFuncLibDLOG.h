//
//  HeaderDLOG.h
//
//  Created by Ramzi on 11/24/14.
//  Copyright (c) 2014 Ramzi. All rights reserved.
//

#ifndef MyFuncLibDLOG_h
#define MyFuncLibDLOG_h

#import <Availability.h>

#if __has_feature(objc_arc)
#define DLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
#define DLog(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);
#endif


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//Usage:[textBox setBackgroundColor:UIColorFromRGB(0X060606)];

/*
 To read the file from the bundle do the following:-
 NSString *dataFile = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];

 To read it from your sandbox storage (documents):-
 NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/YourFile.txt"];
 NSString *dataFile = [NSString stringWithContentsOfFile:docPath
 usedEncoding:NSUTF8StringEncoding
 error:NULL];
 
 To write to document folder:-
 NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/YourFile.txt"];
 [dataFile writeToFile:docPath
 atomically:YES
 encoding:NSUTF8StringEncoding
 error:NULL];
*/

#endif
