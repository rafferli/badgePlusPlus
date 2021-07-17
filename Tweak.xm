#import <UIKit/UIKit.h>
@interface SBIconBadgeView : UIView
@property (nonatomic,assign) CGRect frame;
@property (nonatomic,assign) CGPoint center;
@end

@interface SBIconView : UIView
@end


int width = 65;
int height = 65;
int x = 45;
int y = -11;

int totalNotif;

%hook SBIconBadgeView

  -(void)configureForIcon:(id)arg1 infoProvider:(id)arg2 {
    %orig;

	totalNotif = [MSHookIvar<NSString *>(self, "_text") floatValue];

	if(totalNotif > 9){



    UIImageView *textView = MSHookIvar<UIImageView *>(self, "_textView");
	if (textView != nil){

	//remove original low res image
	textView.image = nil;


	NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentCenter;
	textStyle.lineBreakMode = NSLineBreakByWordWrapping;

	//lets render a new one!
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0);

	NSString *text = MSHookIvar<NSString *>(self, "_text");

	float largestFontSize = 0;
	while(
	[text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].height < (0.9 * width) && 
	[text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].width < (0.9 * height) &&
	largestFontSize < 100)
	{largestFontSize++;}


	float yOffset = (height - [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].height)/2;
	//set up new font and text style
	UIFont *font = [UIFont systemFontOfSize:largestFontSize];

	CGRect rect = CGRectMake(0, yOffset, width, height);
    [text drawInRect:rect withAttributes:@{NSParagraphStyleAttributeName:textStyle, NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

	//set our new high res image !
	textView.image = newImage;
	}

	CGRect newFrame = self.frame;
	newFrame.size.width = width;
	newFrame.size.height = height;
	self.frame = newFrame;
	}

  }


- (CGSize)badgeSize {
	%orig;

	CGSize orig = %orig;

	if(totalNotif > 9){
	CGPoint newPoint = self.center;
	newPoint.x = x;
	newPoint.y = y;
	self.center = newPoint;
	}
	//NSLog(@"testRaffer%@", NSStringFromCGSize(orig));
	//NSLog(@"testRaffer%@", MSHookIvar<NSString *>(self, "_text"));
	return orig;
}




%end


%hook SBIconView

-(void)drawRect:(CGRect)rect {
  %orig(rect);

  if(totalNotif > 9){
  UIView *_accessoryView = MSHookIvar<UIView *>(self, "_accessoryView");
  if (_accessoryView != nil && [_accessoryView isKindOfClass: %c(SBIconBadgeView)]){

		CGPoint newPoint = _accessoryView.center;
		newPoint.x = x;
		newPoint.y = y;
		_accessoryView.center = newPoint;

	}
}
}

%end