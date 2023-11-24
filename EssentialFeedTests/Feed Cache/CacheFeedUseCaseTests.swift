//
//  CacheFeedUseCaseTests.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/11/2023.
//

import XCTest

class LocalFeedLoader {
  
  init(store: FeedStore) {
  }
  
}

class FeedStore {
  var deleteCachedFeedCallCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {
  
  func test() {
    let store = FeedStore()
    let sut = LocalFeedLoader(store: store)
    
    XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
  }
  
}
