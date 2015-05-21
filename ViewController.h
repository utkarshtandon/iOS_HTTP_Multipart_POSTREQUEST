//
//  ViewController.h
//  multipartpost
//
//  Created by Utkarsh Tandon on 2/22/15.
//  Copyright (c) 2015 Utkarsh Tandon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSData *textFileContentsData;
    NSString *textFileContentsString;
    NSString* filePath;
    NSString* fileAtPath;
    NSString* fileName;
}


@property (weak, nonatomic) IBOutlet UILabel *returnlabel;
- (IBAction)postrequest:(id)sender;

@end

# iOS_HTTP_Multipart_POSTREQUEST
