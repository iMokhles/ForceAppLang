#import <UIKit/UIKit.h>


%hook NSUserDefaults
+ (id)standardUserDefaults {
	
	NSUserDefaults *userDefaults = %orig();

	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.f7k.forceapplangsettings.plist"];
	NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
	NSString *bundleKey = [NSString stringWithFormat:@"FORCEAPPLANGEnabled-%@", bundleId];
	NSArray *appLangs = [userDefaults objectForKey:@"AppleLanguages"];

	float customLang = [[prefs objectForKey:@"AppleLanguages"] floatValue];

	if (customLang == 0.0)
    {
    	NSString *lang = [appLangs firstObject];
    	if ([lang isEqualToString:@"ar"] & [appLangs count] == 1){
    		 [userDefaults removeObjectForKey:@"AppleLanguages"];
    	}
  	}
}
%end
