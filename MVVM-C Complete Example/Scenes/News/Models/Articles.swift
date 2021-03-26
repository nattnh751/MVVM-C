//
//  Articles.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation

public struct Articles : Codable {
  var articles : [Article]
}
public struct Article : Codable {
  var id : Int
  var title : String
  private var createdAt : CustomDecodeableDate<DefaultDateFormatter>
  var source : String
  var description : String
  var favorite : Bool
  var heroImage : URL
  var link : URL
  
  public func getDateFromCreatedAt() -> Date? {
    switch createdAt {
    case .error(_): return nil
    case .value(let date): return date
    }
  }
}

