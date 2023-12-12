//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 04/12/2023.
//

import Foundation

 final class FeedCachePolicy {
  private init() {}
  
  static let calendar = Calendar(identifier: .gregorian)
  
  static var maxCacheAgeInDays: Int {
    return 7
  }
  
   static func validate(_ timestamp: Date, against date: Date) -> Bool {
    guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
      return false
    }
    return date < maxCacheAge
  }
}
