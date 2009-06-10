/*
 *  ofxiPhoneAlertView.h
 *  iPhoneParticles
 *
 *  Created by Robert Carlsen on 6/10/09.
 *  Copyright 2009 recv'd productions. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import "ofMain.h"

@interface ofxiPhoneAlertViewDelegate : UIAlertView <UIAlertViewDelegate>
{
	UIAlertView*			_alertView;
    int                     selectedButton;
    bool                    dismissed;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

-(int)getButton;
-(bool)isDismissed;
-(string)getTitle;

@end

class ofxiPhoneAlertView 
    {
	public:
        ofxiPhoneAlertView(string title, string message, string cancelButtonTitle, vector<string> otherButtonTitles);
		~ofxiPhoneAlertView();
    
        void show();
        int getSelectedButton();
        bool isVisible();
        bool isDismissed();
        string getTitle();
        
    protected:
        ofxiPhoneAlertViewDelegate *alertViewDelegate;
};