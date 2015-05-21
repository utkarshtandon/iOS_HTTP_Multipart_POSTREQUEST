//
//  ViewController.m
//  multipartpost
//
//  Created by Utkarsh Tandon on 2/22/15.
//  Copyright (c) 2015 Utkarsh Tandon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    textFileContentsString = [NSString stringWithFormat:@"%@", @"Potatoes are cool sometimes"];
    textFileContentsData = [textFileContentsString dataUsingEncoding:NSASCIIStringEncoding];
    // Build the path, and create if needed.
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    fileName = @"myTextFile.txt";
    fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    NSLog(fileAtPath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act...
    [[textFileContentsString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
    
    
    NSError *error = nil;
    NSString *myString = [NSString stringWithContentsOfFile:fileAtPath encoding:NSUTF8StringEncoding error:&error];
    NSLog(myString);

    /*
    NSLog([[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding]);
    NSData *data =[NSData dataWithContentsOfFile:fileAtPath];
    
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // The main act...
    NSLog(@"Hi");
    NSLog(newStr);
    */

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postrequest:(id)sender {
   
    NSString *urlString = @"http://192.168.1.117:8080/potatoapi";
    
    //NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init]];
    //[request setURL:[NSURL URLWithString:urlString]];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *string = [NSString stringWithFormat:@"%@%@%@", @"Content-Disposition: form-data; name=\"userfile\"; filename=\"", fileAtPath, @"\"\r\n"];
    NSLog(@"%@", string);
    [body appendData:[[NSString stringWithString:string] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:textFileContentsData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    self.returnlabel.text=returnString;
    NSLog(returnString);
    NSLog(@"finish");
    
    /*
    NSData *data = [NSData dataWithContentsOfFile:fileAtPath];
    NSString * strRR = [NSString stringWithFormat:@"%@%@", @"name=userfile",@"&&filename=myTextFile.txt" ];
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:strRR];
    [urlString appendFormat:@"%@", data];
    NSData *postData = [urlString dataUsingEncoding:NSASCIIStringEncoding
                               allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSString *baseurl = @"http://192.168.1.117:8080/potatoapi";
    
    NSURL *url = [NSURL URLWithString:baseurl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod: @"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded"
      forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [connection start];
    NSError *error= nil;
    
    NSHTTPURLResponse * theResponse = nil;
    
    NSData *returnedData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&theResponse error:&error];
    NSString *result= [[NSString alloc] initWithData:returnedData encoding:NSASCIIStringEncoding];
    self.returnlabel.text =result;
    */
    /*
    NSData *data = [NSData dataWithContentsOfFile:fileAtPath];
    NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"potato=%@"];
    [urlString appendFormat:@"%@", data];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.1.117:8080/potatoapi"]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
      forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSError *error= nil;
    
    NSHTTPURLResponse * theResponse = nil;
    
    NSData *returnedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];
    
    NSString *result= [[NSString alloc] initWithData:returnedData encoding:NSASCIIStringEncoding];
    self.returnlabel.text =result;
    */
    
}
@end
# iOS_HTTP_Multipart_POSTREQUEST
