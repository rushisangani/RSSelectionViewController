//
// RSSearchBar.m
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


#import "RSSearchBar.h"

CGFloat kDefaultMargin = 5;

@interface RSSearchBar ()
{
    UITextField *searchTextField;
    
    UIColor *_prefferedTextColor;
    UIFont  *_prefferedTextFont;
}
@end

@implementation RSSearchBar
@synthesize prefferedTextColor = _prefferedTextColor, prefferedTextFont = _prefferedTextFont;

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (id)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder font:(UIFont *)font andTextColor:(UIColor *)textColor {
    
    self = [super initWithFrame:frame];
    if(self){
    
        self.placeholder = placeHolder;
        self.prefferedTextFont = font;
        self.prefferedTextColor = textColor;
        
        self.searchBarStyle = UISearchBarStyleProminent;
        self.translucent = NO;
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    
    NSUInteger index = [self indexOfTextFieldInSubViews];
    
    if(index){
        searchTextField = (UITextField *)(self.subviews[0]).subviews[index];
        
        searchTextField.frame = CGRectMake(kDefaultMargin, kDefaultMargin, self.frame.size.width - 2*kDefaultMargin, self.frame.size.height - 2*kDefaultMargin);
        
        searchTextField.font = self.prefferedTextFont;
        searchTextField.textColor = self.prefferedTextColor;
        searchTextField.backgroundColor = self.barTintColor;
    }
    
    [self drawBottomLine];
    [super drawRect:rect];
}

#pragma mark- Private methods

-(NSUInteger)indexOfTextFieldInSubViews {
    
    NSUInteger index = NSNotFound;
    UIView *searchBarView = self.subviews[0];
    
    for (int i = 0; i < searchBarView.subviews.count; ++i) {
        
        if([searchBarView.subviews[i] isKindOfClass:[UITextField class]]){
            index = i;
            break;
        }
    }
    return index;
}

-(void)drawBottomLine {
    
    CGPoint startPoint = CGPointMake(0.0, self.frame.size.height);
    CGPoint endPoint = CGPointMake(self.frame.size.width, self.frame.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth = 3;
    
    [self.layer addSublayer:shapeLayer];
}

#pragma mark- Getter {

-(UIFont *)prefferedTextFont {
    
    if(!_prefferedTextFont){
        _prefferedTextFont = [UIFont systemFontOfSize:16];
    }
    return _prefferedTextFont;
}

-(UIColor *)prefferedTextColor {
    
    if(!_prefferedTextColor){
        _prefferedTextColor = [UIColor darkTextColor];
    }
    return _prefferedTextColor;
}

@end
