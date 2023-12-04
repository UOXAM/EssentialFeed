//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by ROUX Maxime on 03/12/2023.
//

import Foundation
import EssentialFeed
    
func uniqueImage() -> FeedImage {
  return FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}
  
func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
  let models = [uniqueImage(), uniqueImage()]
  let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
  return (models, local)
}

extension Date {
  private var feedcacheMaxAgeIndays: Int {
    return 7
  }
  
  func minusFeedCacheMaxAge() -> Date {
    return adding(days: -feedcacheMaxAgeIndays)
  }
  
  private func adding(days: Int) -> Date {
    return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
  }
}
  
extension Date {
  func adding(seconds: TimeInterval) -> Date {
    return self + seconds
  }
}
