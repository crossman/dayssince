#import <Cocoa/Cocoa.h>

@interface DaysSince : NSObject {
	IBOutlet NSMenu *daysSinceMenu;
	IBOutlet NSMenuItem *daysSinceDay;
	NSStatusItem *statusItem;
	NSDate *lastAccident;
}


- (void) attachToSystemMenu;
- (void) updateStatusItem;
- (void)setLastAccidentMenuItem;

- (IBAction) resetDaysSince:(id)sender;
@end
