//
//  File.swift
//  
//
//  Created by edz on 2020/12/9.
//

import Contacts
import Foundation
import Photos
import AVFoundation
import UIKit

public class PDFDocPrivacyTool {
    
    public class func jumpToAppPrivacySetting() {
        guard let appSetting = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if #available(iOS 10, *) {
            UIApplication.shared.open(appSetting, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(appSetting)
        }
    }
    
    public class func fetchCameraPrivacy(completion: @escaping (_ status: Bool) -> Void) {
        let granted = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch granted {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (s) in
                DispatchQueue.main.async {
                    completion(AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized)
                }
            }
        case .authorized:
            DispatchQueue.main.async {
                completion(true)
            }
        default:
            DispatchQueue.main.async {
                completion(AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized)
            }
        }
    }
    
    /// 获取权限
    public class func fetchPhotoPricy() async -> Bool {
        await withCheckedContinuation({ con in
            let s = PHPhotoLibrary.authorizationStatus()
            switch s {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { _ in
                    if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus()  == .limited {
                        con.resume(returning: true)
                    } else {
                        con.resume(returning: false)
                    }
                }
            case .authorized, .limited:
                con.resume(returning: true)
            default:
                con.resume(returning: false)
            }
        })
    }
    
    public class func fetchPhotoPrivacy(completion: @escaping (_ status: Bool) -> Void) {
        let s = PHPhotoLibrary.authorizationStatus()
        switch s {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { _ in
                DispatchQueue.main.async {
                    completion(PHPhotoLibrary.authorizationStatus() == .authorized)
                }
            }
        case .authorized:
            DispatchQueue.main.async {
                completion(true)
            }
        default:
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public class func fetchPhotoPrivacy() async -> Bool {
      return await  withCheckedContinuation { con in
          let s = PHPhotoLibrary.authorizationStatus()
          switch s {
          case .notDetermined:
              PHPhotoLibrary.requestAuthorization { _ in
                  DispatchQueue.main.async {
                      con.resume(returning: PHPhotoLibrary.authorizationStatus() == .authorized)
                  }
              }
          case .authorized:
              DispatchQueue.main.async {
//                  completion(true)
                  con.resume(returning: true)
              }
          default:
              DispatchQueue.main.async {
//                  completion(false)
                  con.resume(returning: false)
              }
          }
        }
   
    }

//    public class func fetchContactPrivacy(completion: @escaping (_ status: Bool) -> Void) {
//        let s = CNContactStore.authorizationStatus(for: .contacts)
//        switch s {
//        
//        case .denied, .restricted:
//            DispatchQueue.main.async {
//                completion(false)
//            }
//        case .notDetermined:
//            DispatchQueue.main.async {
//                CNContactStore().requestAccess(for: .contacts) { _, _ in
//                    DispatchQueue.main.async {
//                        completion(CNContactStore.authorizationStatus(for: .contacts) == .authorized )
//                    }
//                }
//            }
//        case .authorized:
//            DispatchQueue.main.async {
//                completion(true)
//            }
//        default:
//            DispatchQueue.main.async {
//                completion(false)
//            }
//        }
//    }
}
