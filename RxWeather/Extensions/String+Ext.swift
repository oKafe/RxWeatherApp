//
//  String+Ext.swift
//  RxWeather
//
//  Created by Andy Orphan on 20.01.2021.
//

import Foundation
import Moya


extension String {
    public func stringByAddingPercentEncoding() -> String? {
      return addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)
    }
}
