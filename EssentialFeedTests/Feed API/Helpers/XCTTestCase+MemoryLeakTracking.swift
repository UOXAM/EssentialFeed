//
//  XCTTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by ROUX Maxime on 05/11/2023.
//

import XCTest

extension XCTestCase {
  func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
    }
  }
}

