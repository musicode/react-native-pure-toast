
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface RNTToast : NSObject <RCTBridgeModule>

+ (void)bind:(UIView *)rootView;

@end
