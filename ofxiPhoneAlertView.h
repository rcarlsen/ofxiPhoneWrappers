/*
 ofxiPhoneAlertView.h
 
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