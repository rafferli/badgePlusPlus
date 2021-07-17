#line 1 "Tweak.xm"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBIconView; @class SBIconBadgeView; 
static void (*_logos_orig$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$)(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST, SEL, id, id); static CGSize (*_logos_orig$_ungrouped$SBIconBadgeView$badgeSize)(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST, SEL); static CGSize _logos_method$_ungrouped$SBIconBadgeView$badgeSize(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBIconView$drawRect$)(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, CGRect); static void _logos_method$_ungrouped$SBIconView$drawRect$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, CGRect); 
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$SBIconBadgeView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("SBIconBadgeView"); } return _klass; }
#line 18 "Tweak.xm"


  static void _logos_method$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    _logos_orig$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$(self, _cmd, arg1, arg2);

	totalNotif = [MSHookIvar<NSString *>(self, "_text") floatValue];

	if(totalNotif > 9){



    UIImageView *textView = MSHookIvar<UIImageView *>(self, "_textView");
	if (textView != nil){

	
	textView.image = nil;


	NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.alignment = NSTextAlignmentCenter;
	textStyle.lineBreakMode = NSLineBreakByWordWrapping;

	
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0);

	NSString *text = MSHookIvar<NSString *>(self, "_text");

	float largestFontSize = 0;
	while(
	[text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].height < (0.9 * width) && 
	[text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].width < (0.9 * height) &&
	largestFontSize < 100)
	{largestFontSize++;}


	float yOffset = (height - [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largestFontSize]}].height)/2;
	
	UIFont *font = [UIFont systemFontOfSize:largestFontSize];

	CGRect rect = CGRectMake(0, yOffset, width, height);
    [text drawInRect:rect withAttributes:@{NSParagraphStyleAttributeName:textStyle, NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

	
	textView.image = newImage;
	}

	CGRect newFrame = self.frame;
	newFrame.size.width = width;
	newFrame.size.height = height;
	self.frame = newFrame;
	}

  }


static CGSize _logos_method$_ungrouped$SBIconBadgeView$badgeSize(_LOGOS_SELF_TYPE_NORMAL SBIconBadgeView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$SBIconBadgeView$badgeSize(self, _cmd);

	CGSize orig = _logos_orig$_ungrouped$SBIconBadgeView$badgeSize(self, _cmd);

	if(totalNotif > 9){
	CGPoint newPoint = self.center;
	newPoint.x = x;
	newPoint.y = y;
	self.center = newPoint;
	}
	
	
	return orig;
}









static void _logos_method$_ungrouped$SBIconView$drawRect$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGRect rect) {
  _logos_orig$_ungrouped$SBIconView$drawRect$(self, _cmd, rect);

  if(totalNotif > 9){
  UIView *_accessoryView = MSHookIvar<UIView *>(self, "_accessoryView");
  if (_accessoryView != nil && [_accessoryView isKindOfClass: _logos_static_class_lookup$SBIconBadgeView()]){

		CGPoint newPoint = _accessoryView.center;
		newPoint.x = x;
		newPoint.y = y;
		_accessoryView.center = newPoint;

	}
}
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBIconBadgeView = objc_getClass("SBIconBadgeView"); { MSHookMessageEx(_logos_class$_ungrouped$SBIconBadgeView, @selector(configureForIcon:infoProvider:), (IMP)&_logos_method$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$, (IMP*)&_logos_orig$_ungrouped$SBIconBadgeView$configureForIcon$infoProvider$);}{ MSHookMessageEx(_logos_class$_ungrouped$SBIconBadgeView, @selector(badgeSize), (IMP)&_logos_method$_ungrouped$SBIconBadgeView$badgeSize, (IMP*)&_logos_orig$_ungrouped$SBIconBadgeView$badgeSize);}Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); { MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(drawRect:), (IMP)&_logos_method$_ungrouped$SBIconView$drawRect$, (IMP*)&_logos_orig$_ungrouped$SBIconView$drawRect$);}} }
#line 118 "Tweak.xm"
