# react-native-pure-toast

This is a module which help you to show a toast like android.

## Installation

```
npm i react-native-pure-toast
// link below 0.60
react-native link react-native-pure-toast
```

## Setup

### iOS

modify `AppDelegate.m`

```oc
#import <RNTToast.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  ...
  // add this line
  [RNTToast bind:rootView];
  return YES;
}
```

`Targets` -> `Build Phase` -> `Copy Bundle Resources`, click `+` button, pick the folder `node_modules/react-native-pure-toast/ios/RNTToast/Assets.xcassets` to your project.

### Android

nothing to do.

## Usage

```js
import toast from 'react-native-pure-toast'

toast.show({
  text: 'hello world',
  // text|success|error, default value: text
  type: 'text',
  // short|long, default value: short
  duration: 'short',
  // center|top|bottom, default value: center
  position: 'center',
})
```