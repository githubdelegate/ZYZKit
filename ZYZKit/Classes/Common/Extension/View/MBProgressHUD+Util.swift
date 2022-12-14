//
//  File.swift
//  
//
//  Created by edz on 2021/1/14.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    @MainActor
    /// debug 模式下 提示，用来展示代码逻辑出错点
    /// - Parameter message: message description
    public static func debugshowToastMain(_ message: String?) {
        #if DEBUG
        DispatchQueue.main.async {
            MBProgressHUD.hide()
            guard let view:UIView =  UIApplication.fastKeyWindow else { return }
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.isUserInteractionEnabled = true
            hud.mode = .text
            hud.label.text = message
            hud.label.numberOfLines = 0
            hud.hide(animated: true, afterDelay: 1.5)
        }
        #endif
    }
    
    
    @MainActor
    public static func showToastMain(_ message: String?) {
        MBProgressHUD.hide()
        guard let view:UIView =  UIApplication.fastKeyWindow else { return }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = true
        hud.mode = .text
        hud.label.text = message
        hud.label.numberOfLines = 0
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    
    private class func show(_ text: String?, icon: String?) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.label.text = text
        // 设置图片
        if let icon = icon {
            let image = UIImage(named: "JXMBProgressHUD.bundle/\(icon)")?.withRenderingMode(.alwaysTemplate)
            hud.customView = UIImageView(image: image)
        }
        // 再设置模式
        hud.mode = .customView
        hud.isSquare = true
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 0.9秒之后再消失
        hud.hide(animated: true, afterDelay: 0.89)
    }

    private class func showMessage(_ message: String?, btnTitle: String?, target: Any?, action: Selector) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.label.text = message
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 需要蒙版效果
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.button.setTitle(btnTitle, for: .normal)
        hud.button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// 仅显示文字提示
    public class func showToast(_ message: String?) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.text = message
        hud.label.numberOfLines = 0
//        hud.offset = CGPoint(x: 0.0, y: MBProgressMaxOffset - 49)
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    public class func showTopToast(_ message: String?) {
        guard let view:UIView = UIApplication.shared.keyWindow else { return }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.text = message
        hud.offset = CGPoint(x: 0.0, y: -200)
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    public class func showTopToastOnView(view: UIView, message: String?) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        // 允许背景可点击
        hud.isUserInteractionEnabled = false
        hud.mode = .text
        hud.label.text = message
        hud.offset = CGPoint(x: 0.0, y: -200)
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    
    /// 显示菊花
    @discardableResult
    public class func show(_ message: String?) -> MBProgressHUD? {
        guard let view:UIView = UIApplication.fastKeyWindow else { return nil}
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = true
        hud.label.text = message
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 需要蒙版效果
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        return hud
    }
    
    @MainActor
    @discardableResult
    public class func showMain(_ message: String?) -> MBProgressHUD? {
        MBProgressHUD.hide()
        guard let view:UIView = UIApplication.fastKeyWindow else { return nil}
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = true
        hud.label.text = message
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 需要蒙版效果
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        return hud
    }
    
    /// 普通提示
    public class func showInfo(_ message: String?) {
        self.show(message, icon: "info")
    }
    /// 线束正确提示
    public class func showSuccess(_ message: String?) {
        self.show(message, icon: "success")
    }
    /// 显示错误提示
    public class func showError(_ message: String?) {
        self.show(message, icon: "error")
    }
    
    @MainActor
    /// 隐藏
    public class func hide() {
        guard let view:UIView = UIApplication.fastKeyWindow else { return }
        self.hide(for: view, animated: true)
    }
}
