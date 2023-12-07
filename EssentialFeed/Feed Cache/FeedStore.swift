//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 27/11/2023.
//

import Foundation

public enum RetreivecachedFeedResult {
  case empty
  case found(feed: [LocalFeedImage], timestamp: Date)
  case failure(Error)
}

public protocol FeedStore {
  typealias RetrievalCompletion = (RetreivecachedFeedResult) -> Void
  typealias InsertionCompletion = (Error?) -> Void
  typealias DeletionCompletion = (Error?) -> Void

  /// The completion handler can be invoked in any thread.
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func retrieve(completion: @escaping RetrievalCompletion)

  /// The completion handler can be invoked in any thread.
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
  
  /// The completion handler can be invoked in any thread.
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func deleteCacheFeed(completion: @escaping DeletionCompletion)
}
