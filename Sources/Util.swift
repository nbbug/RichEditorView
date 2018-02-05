//
//  Util.swift
//  RichEditorView
//
//  Created by chang on 2017/6/9.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation

class Util{
    class func pathForWKWebViewSandboxBugWithOriginalPath(_ filePath: String)-> String?{
        guard let filePath = URL(string: filePath) else{
            return nil
        }
        
        let manager = FileManager.default
        guard let tempPath = URL(string: NSTemporaryDirectory())?.appendingPathComponent("www") else {
            return nil
        }
        
        do{
            try manager.createDirectory(atPath: tempPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            let destPath = tempPath.appendingPathComponent(filePath.lastPathComponent)
            
            if !manager.fileExists(atPath: destPath.absoluteString){
                do {
                    try manager.copyItem(at: filePath, to: destPath)
                } catch {
                    return nil
                }
            }
            
            return destPath.absoluteString
        }catch{
            return nil
        }
    }
    
    class func pathForImage(image: UIImage)->String?{
        let data = image.uploadData()
        let filename = data.md5 + ".jpg"
        
        let manager = FileManager.default
        
        guard let tempPath = URL(string: NSTemporaryDirectory())?.appendingPathComponent("img") else {
            return nil
        }
        do{
            try manager.createDirectory(atPath: tempPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            let destPath = URL(fileURLWithPath:  tempPath.appendingPathComponent(filename).absoluteString)
            if !manager.fileExists(atPath: destPath.absoluteString){
                do{
                    try data.write(to: destPath)
                    return destPath.absoluteString
                }catch{
                    return nil
                }
            }else{
                return destPath.absoluteString
            }
        }catch{
            return nil
        }
    }
}
