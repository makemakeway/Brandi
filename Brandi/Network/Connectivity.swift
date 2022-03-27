//
//  Connectivity.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import Foundation

import Alamofire

final class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
