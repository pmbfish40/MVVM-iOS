//
//  BaseTargetType.swift
//  MVVM-ios
//
//  Created by Hovhannes Stepanyan on 11/7/18.
//  Copyright © 2018 Matevos Ghazaryan. All rights reserved.
//

import Foundation
import Moya

enum BaseTargetType {
    case configs
}

extension BaseTargetType: TargetType {
    var baseURL: URL {
        return try! "https://test-arca.helix.am/api/en".asURL()
    }
    
    var path: String {
        switch self {
        case .configs:
            return "config"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .configs:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .configs:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .configs:
            let params = [
                "deviceType": "iPhone",
                "applicationId": BaseTargetType.getUDID(),
                "applicationVersion": BaseTargetType.getApplicationVersionNumber(),
                "deviceScale": BaseTargetType.getDeviceScale()
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding(destination: .queryString))
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .configs:
            return nil
        }
    }
    
    static func getUDID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static func getApplicationVersionNumber() -> String {
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!
    }
    
    static func getDeviceScale() -> String {
        return String(describing: UIScreen.main.scale)
    }
}
