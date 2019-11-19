
import { NativeModules } from 'react-native'

const { RNTToast } = NativeModules

export default {

  show(options) {
    RNTToast.show({
      type: options.type || 'text',
      text: options.text || 'default text',
      duration: options.duration || 'short',
      position: options.position || 'center',
    })
  }

}
