//
// RSSearchBar.h
//
// Copyright (c) Rushi Sangani.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#define kSearchBarTintColor [UIColor colorWithRed:(239/255.f) green:(239/255.f) blue:(241/255.f) alpha:0.8]

#import <UIKit/UIKit.h>

static CGFloat kDefaultSearchBarHeight = 50;

@interface RSSearchBar : UISearchBar

@property (nonatomic, strong) UIFont  *prefferedTextFont;            // font

@property (nonatomic, strong) UIColor *prefferedTextColor;           // text color

/* init */
-(id)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder font:(UIFont *)font andTextColor:(UIColor *)textColor;

@end
