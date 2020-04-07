#import "RNTToast.h"
#import "react_native_pure_toast-Swift.h"

Toast *toast;

@implementation RNTToast

+ (void)bind:(UIView *)rootView {

    ToastConfiguration *configuration = [[ToastConfiguration alloc] init];
    
    toast = [[Toast alloc] initWithView:rootView configuration:configuration];
    
}

- (dispatch_queue_t)methodQueue {
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE(RNTToast);

RCT_EXPORT_METHOD(show:(NSDictionary*)options) {

    [toast showWithText:options[@"text"] type:options[@"type"] duration:options[@"duration"] position:options[@"position"]];
    
}

@end
