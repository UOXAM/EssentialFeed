//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by ROUX Maxime on 06/12/2023.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
  @discardableResult
  func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: CodableFeedStore) -> Error? {
    let exp = expectation(description: "Wait for cache insertion")
    var insertionError: Error?
    sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
      insertionError = receivedInsertionError
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1.0)
    return insertionError
  }

  @discardableResult
  func deleteCache(from sut: CodableFeedStore) -> Error? {
    let exp = expectation(description: "Wait for cache deletion")
    var deletionError: Error?
    sut.deleteCachedFeed { receivedDeletionError in
      deletionError = receivedDeletionError
      exp.fulfill()
    }
    wait(for: [exp], timeout: 2.0)
    return deletionError
  }

  func expect(_ sut: CodableFeedStore, toRetrieveTwice expectedResult: RetreivecachedFeedResult, file: StaticString = #file, line: UInt = #line) {
    expect(sut, toRetrieve: expectedResult)
    expect(sut, toRetrieve: expectedResult)
  }
  
  func expect(_ sut: CodableFeedStore, toRetrieve expectedResult: RetreivecachedFeedResult, file: StaticString = #file, line: UInt = #line) {
    let exp = expectation(description: "Wait for cache retrieval")
    
    sut.retrieve { retrieveResult in
      switch (expectedResult, retrieveResult) {
      case (.empty, .empty), (.failure, .failure):
        break
        
      case let (.found(expected), .found(retrieved)) :
        XCTAssertEqual(retrieved.feed, expected.feed, file: file, line: line)
        XCTAssertEqual(retrieved.timestamp, expected.timestamp, file: file, line: line)
        
      default:
        XCTFail("Expected to retrieve \(expectedResult), got \(retrieveResult) instead", file: file, line: line)
      }
      exp.fulfill()
    }
    
    wait(for: [exp], timeout: 1.0)
  }
}
