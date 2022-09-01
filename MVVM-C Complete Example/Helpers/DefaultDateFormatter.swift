//
//  DefaultDateFormatter.swift
//  MVVM-C Complete Example
//
//  Created by Nathan Walsh on 3/26/21.
//

import Foundation
public class DefaultDateFormatter: StaticDateFormatterInterface {
  public static var value: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
}
