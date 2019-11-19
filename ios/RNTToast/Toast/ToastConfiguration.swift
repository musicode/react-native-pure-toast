
import UIKit
import Foundation

@objc public class ToastConfiguration : NSObject {

    // 当位于顶部或底部时，到边的距离
    public var yOffset = CGFloat(30)
    
    // 背景色
    public var backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    
    // 边框色
    public var borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
    
    // 边框大小
    public var borderWidth = 1 / UIScreen.main.scale
    
    // 圆角大小
    public var borderRadius = CGFloat(5)
    
    
    
    // 最小宽度
    public var imageMinWidth = CGFloat(110)
    
    // toast 两侧留白
    public var imagePaddingHorizontal = CGFloat(15)
    
    // 图标到 toast 顶部的距离
    public var imageIconMarginTop = CGFloat(18)
    
    // 图标和文本的距离
    public var imageIconTextSpacing = CGFloat(6)
    
    // 文本到 toast 底部的距离
    public var imageTextMarginBottom = CGFloat(15)
    
    
    
    // 纯文本 toast 两侧留白
    public var textPaddingHorizontal = CGFloat(12)
    public var textPaddingVertical = CGFloat(8)
    
    // 文本颜色
    public var textColor = UIColor.white
    
    // 文本大小
    public var textFont = UIFont.init(name: "PingFang TC", size: 14)
    
    // 行间距
    public var lineSpacing = CGFloat(1)
    
    // 成功图标
    public var successImage = UIImage(named: "custom_toast_success")
    
    // 错误图标
    public var errorImage = UIImage(named: "custom_toast_error")

}
