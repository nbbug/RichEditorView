//
//  Data+Ext.swift
//  Stock
//
//  Created by chang on 2017/5/19.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation

extension Data{
    var md5: String{
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        _ = self.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
            CC_MD5(body, CC_LONG(self.count), &digest)
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
