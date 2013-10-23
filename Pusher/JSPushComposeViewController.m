//
//  JSPushComposeViewController.m
//  Pusher
//
//  Created by Javier Soto on 10/21/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import "JSPushComposeViewController.h"

#import "JSPushOverRAC.h"

@interface JSPushComposeViewController ()

@property (weak) IBOutlet NSTextField *titleTextField;
@property (strong) IBOutlet NSTextView *messageTextView;
@property (weak) IBOutlet NSTextField *URLTextField;

@property (weak) IBOutlet NSButton *sendButton;

@property BOOL requestInProgress;

@end

@implementation JSPushComposeViewController

- (void)setView:(NSView *)view
{
    [super setView:view];

    @weakify(self);
    self.sendButton.rac_command = [[RACCommand alloc]
                                   initWithEnabled:[[RACSignal combineLatest:@[self.messageTextView.rac_textSignal,
                                                                               RACObserve(self, requestInProgress)]]
                                                    reduceEach:^id(NSString *message, NSNumber *requestInProgress)
                                                    {
                                                        return @((message.length > 0 && !requestInProgress.boolValue));
                                                    }]
                                   signalBlock:^RACSignal *(id input)
                                   {
                                       @strongify(self);

                                       [self sendRequest];
                                   }];
}

- (void)clearFields
{
    self.titleTextField.stringValue = self.messageTextView.string = self.URLTextField.stringValue = @"";
}

- (void)sendRequest
{
    self.requestInProgress = YES;
    @weakify(self);
    [[JSPushOverRAC sendPushMessageWithTitle:self.titleTextField.stringValue
                                     message:self.messageTextView.string
                                         URL:self.URLTextField.stringValue]
     subscribeError:^(NSError *error) {
         @strongify(self);
         self.requestInProgress = NO;

         NSAlert *alert = [NSAlert alertWithMessageText:@"Message"
                                          defaultButton:@"OK"
                                        alternateButton:nil
                                            otherButton:nil
                              informativeTextWithFormat:@"An error has occured"];

         [alert runModal];
     } completed:^{
         @strongify(self);
         self.requestInProgress = NO;
         
         [self clearFields];
     }];
    
}

@end
