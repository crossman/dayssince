#import "DaysSince.h"

#define DAY 86400

@implementation DaysSince

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
	lastAccident = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastAccident"];
	if (!lastAccident)
		[self resetDaysSince:self];

	[self attachToSystemMenu];
	[self updateStatusItem];
}

- (void) updateStatusItem{
	int days = (int)[lastAccident timeIntervalSinceNow] * -1/DAY;
	[statusItem setTitle:[NSString stringWithFormat:@"%d", days]];
	[statusItem setToolTip:[NSString stringWithFormat:@"%d day%@ since the last accident", days, days > 1 || days == 0 ? @"s" : @""]];
	[self performSelector:@selector(updateStatusItem) withObject:nil afterDelay:DAY -((int)[lastAccident timeIntervalSinceNow] * -1)%DAY];
}

- (void) attachToSystemMenu{
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:daysSinceMenu];
	[statusItem setHighlightMode:YES];
	[self setLastAccidentMenuItem];
}

- (IBAction) resetDaysSince:(id)sender{
	lastAccident = [NSDate date];
	[[NSUserDefaults standardUserDefaults] setObject:lastAccident forKey:@"lastAccident"];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self setLastAccidentMenuItem];
	[self updateStatusItem];
}

- (void)setLastAccidentMenuItem{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];

	[daysSinceDay setTitle:[dateFormatter stringFromDate:lastAccident]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
