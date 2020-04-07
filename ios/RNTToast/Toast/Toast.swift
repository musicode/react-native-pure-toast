
import UIKit
import Foundation

class ToastTask {
    
    public var text: String
    
    public var type: String
    
    public var duration: String
    
    public var position: String
    
    public init(text: String, type: String, duration: String, position: String) {
        self.text = text
        self.type = type
        self.duration = duration
        self.position = position
    }
    
}

@objc public class Toast : NSObject {
    
    private var view: UIView
    private var configuration: ToastConfiguration
    
    private var currentTask: ToastTask?
    private var currentToast: UIView?
    
    private var hideTimer: Timer?
    private var isAnimating = false
    
    private var queue = [ToastTask]()
    
    @objc public init(view: UIView, configuration: ToastConfiguration) {
        self.view = view
        self.configuration = configuration
    }
    
    @objc public func show(text: String, type: String, duration: String, position: String) {

        // 一样的内容就算了
        if currentTask?.text == text {
            return
        }

        queue.append(ToastTask(text: text, type: type, duration: duration, position: position))
        
        // 如果有正在显示的 toast，则先隐藏
        if currentToast != nil {
            hide()
            return
        }
        
        // 如果正在执行隐藏动画，则直接等动画完成回调就行了
        // 如果是显示动画，会走进上一个 if
        if isAnimating {
            return
        }
        
        show()
        
    }
    
    private func show() {

        guard let task = queue.popLast() else {
            return
        }
        
        let toast = UIView()
        
        toast.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toast)
        
        
        // 作用于 toast 的布局约束
        var toastLayoutConstraints = [
            NSLayoutConstraint(item: toast, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            // 模仿安卓两侧自动有一些留白，两侧各 40dp
            NSLayoutConstraint(item: toast, attribute: .width, relatedBy: .lessThanOrEqual, toItem: view, attribute: .width, multiplier: 1, constant: -80),
        ]
        
        // 作用于 toast 子元素的布局约束
        var childLayoutConstraints = [NSLayoutConstraint]()
        
        
        
        // ==================================================================
        // 背景 + 边框
        // ==================================================================
        toast.backgroundColor = configuration.backgroundColor
        toast.layer.borderColor = configuration.borderColor.cgColor
        toast.layer.borderWidth = configuration.borderWidth
        toast.layer.cornerRadius = configuration.borderRadius
        
        
        // ==================================================================
        // 添加文字
        // ==================================================================
        let textView = UILabel()
        textView.textColor = configuration.textColor
        textView.font = configuration.textFont
        textView.numberOfLines = 3
        textView.sizeToFit()
        textView.translatesAutoresizingMaskIntoConstraints = false
        toast.addSubview(textView)
        
        // 设置行间距
        if configuration.lineSpacing > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byTruncatingTail
            paragraphStyle.lineSpacing = configuration.lineSpacing

            let attributedString = NSMutableAttributedString(string: task.text)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            textView.attributedText = attributedString
        }
        else {
            textView.textAlignment = .center
            textView.lineBreakMode = .byTruncatingTail
            textView.text = task.text
        }
        

        
        
        // ==================================================================
        // 添加图标
        // ==================================================================

        
        switch task.type {
        case "success":
            
            let imageView = UIImageView()
            imageView.image = configuration.successImage
            imageView.translatesAutoresizingMaskIntoConstraints = false
            toast.addSubview(imageView)
            
            toastLayoutConstraints.append(
                NSLayoutConstraint(item: toast, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: configuration.imageMinWidth)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: toast, attribute: .centerX, multiplier: 1, constant: 0)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: toast, attribute: .top, multiplier: 1, constant: configuration.imageIconMarginTop)
            )
            
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: configuration.imageIconTextSpacing)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: toast, attribute: .bottom, multiplier: 1, constant: -configuration.imageTextMarginBottom)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: toast, attribute: .left, multiplier: 1, constant: configuration.imagePaddingHorizontal)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: toast, attribute: .right, multiplier: 1, constant: -configuration.imagePaddingHorizontal)
            )
            
            break
            
        case "error":
            
            let imageView = UIImageView()
            imageView.image = configuration.errorImage
            imageView.translatesAutoresizingMaskIntoConstraints = false
            toast.addSubview(imageView)
            
            toastLayoutConstraints.append(
                NSLayoutConstraint(item: toast, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: configuration.imageMinWidth)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: toast, attribute: .centerX, multiplier: 1, constant: 0)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: toast, attribute: .top, multiplier: 1, constant: configuration.imageIconMarginTop)
            )
            
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: configuration.imageIconTextSpacing)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: toast, attribute: .bottom, multiplier: 1, constant: -configuration.imageTextMarginBottom)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: toast, attribute: .left, multiplier: 1, constant: configuration.imagePaddingHorizontal)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: toast, attribute: .right, multiplier: 1, constant: -configuration.imagePaddingHorizontal)
            )
            
            break
            
        default:
            
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: toast, attribute: .top, multiplier: 1, constant: configuration.textPaddingVertical)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: toast, attribute: .bottom, multiplier: 1, constant: -configuration.textPaddingVertical)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .left, relatedBy: .equal, toItem: toast, attribute: .left, multiplier: 1, constant: configuration.textPaddingHorizontal)
            )
            childLayoutConstraints.append(
                NSLayoutConstraint(item: textView, attribute: .right, relatedBy: .equal, toItem: toast, attribute: .right, multiplier: 1, constant: -configuration.textPaddingHorizontal)
            )
            
            break
            
        }


        switch task.position {
        case "top":
            
            var top: CGFloat = 0
            
            if #available(iOS 11.0, *) {
                top = view.safeAreaInsets.top
            }
            
            toastLayoutConstraints.append(
                NSLayoutConstraint(item: toast, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: top + configuration.yOffset)
            )
            break
        case "bottom":
            
            var bottom: CGFloat = 0
            
            if #available(iOS 11.0, *) {
                bottom = view.safeAreaInsets.bottom
            }
            
            toastLayoutConstraints.append(
                NSLayoutConstraint(item: toast, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -(bottom + configuration.yOffset))
            )
            break
        default:
            toastLayoutConstraints.append(
                NSLayoutConstraint(item: toast, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
            )
            break
        }
        
        
        
        
        
        toast.addConstraints(childLayoutConstraints)
        view.addConstraints(toastLayoutConstraints)
        

        
        toast.alpha = 0.4
        
        currentTask = task
        currentToast = toast
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, animations: {
            toast.alpha = 1.0
        }) { done in
            // 如果非正常结束，则不需要定时隐藏
            guard done else {
                return
            }
            
            self.isAnimating = false
            
            self.hideTimer = Timer.scheduledTimer(
                // 参照安卓的时间
                timeInterval: task.duration == "long" ? 4 : 2,
                target: self,
                selector: #selector(Toast.onHide),
                userInfo: nil,
                repeats: false
            )
            
        }
        
    }
    
    @objc private func onHide() {
    
        DispatchQueue.main.async {
            self.hide()
        }
        
    }
    
    private func hide() {
        
        guard let toast = currentToast else {
            return
        }

        if let timer = hideTimer {
            timer.invalidate()
            hideTimer = nil
        }
        
        if isAnimating {
            toast.layer.removeAllAnimations()
        }
        
        isAnimating = true
        
        currentTask = nil
        currentToast = nil
        
        UIView.animate(withDuration: 0.1, animations: {
            toast.alpha = 0.4
        }) { done in
            
            toast.removeFromSuperview()
            
            self.isAnimating = false
            self.show()
            
        }
        
    }
    
}
