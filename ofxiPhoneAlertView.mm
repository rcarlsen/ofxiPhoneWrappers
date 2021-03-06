/*
 ofxiPhoneAlertView.mm
 
 Created on 6/10/09.
 Copyright 2009 Robert Carlsen | robertcarlsen.net
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "ofxiPhoneAlertView.h"

// c++ class methods
ofxiPhoneAlertView::ofxiPhoneAlertView(string _title,
                                       string _message,
                                       string _cancelButtonTitle,
                                       vector<string> _otherButtonTitles){
    NSString * title = [[[NSString alloc] initWithCString: _title.c_str()] autorelease];
    NSString * message = [[[NSString alloc] initWithCString: _message.c_str()] autorelease];
    
    // nil value will omit button
    NSString * cancelButtonTitle;
    if(_cancelButtonTitle == "")
        cancelButtonTitle = nil;
    else
        cancelButtonTitle = [[[NSString alloc] initWithCString: _cancelButtonTitle.c_str()] autorelease];
    
    // the other buttons are an array of strings
    NSMutableArray *otherButtons = [NSMutableArray array];
    for(int i=0;i<_otherButtonTitles.size();i++){
        [otherButtons addObject:[[[NSString alloc] initWithCString: _otherButtonTitles[i].c_str()] autorelease]];
    }
    
    alertViewDelegate = [[ofxiPhoneAlertViewDelegate alloc] initWithTitle:title
                                                          message:message 
                                                cancelButtonTitle:cancelButtonTitle
                                                otherButtonTitles:otherButtons];
    
    
}

ofxiPhoneAlertView::~ofxiPhoneAlertView(){
    [alertViewDelegate release];
}

void ofxiPhoneAlertView::show(){
	// UI events need to occur on the main thread.
	[alertViewDelegate performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}

int ofxiPhoneAlertView::getSelectedButton(){    
        return [alertViewDelegate getButton];
}

bool ofxiPhoneAlertView::isVisible(){
    return [alertViewDelegate isVisible];
}

bool ofxiPhoneAlertView::isDismissed(){
    return [alertViewDelegate isDismissed];
}

string ofxiPhoneAlertView::getTitle(){
    return [alertViewDelegate getTitle];
}

// obj-c implementation
@implementation ofxiPhoneAlertViewDelegate

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    if (self = [super initWithTitle:title
                            message:message 
                           delegate:self 
                  cancelButtonTitle:cancelButtonTitle
                  otherButtonTitles:nil ]){
         _alertView = [[ofxiPhoneAlertViewDelegate alloc] initWithTitle:title
                                                message:message 
                                               delegate:self 
                                      cancelButtonTitle:cancelButtonTitle
                                      otherButtonTitles:nil ];
        for(NSString *s in otherButtonTitles){
            [_alertView addButtonWithTitle:s];
            [self addButtonWithTitle:s];
        }
        
        dismissed = false;
        //self = [_alertView copy];
    }
        return self;
}
    
-(int)getButton{
    return selectedButton;
}

-(bool)isDismissed{
    return dismissed;
}

-(string)getTitle{
    // return the title of the alert. to differentiate between separate alert views
    return [[self title] UTF8String];
}

/*
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;
{
    
}
*/
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    selectedButton = buttonIndex;
    dismissed = true;
    NSLog(@"Selected button: %d",selectedButton);
}

/*
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView;

- (void)willPresentAlertView:(UIAlertView *)alertView;  // before animation and showing view
- (void)didPresentAlertView:(UIAlertView *)alertView;  // after animation

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
*/

-(void) dealloc{
    [_alertView release];
    [super dealloc];
}

@end
