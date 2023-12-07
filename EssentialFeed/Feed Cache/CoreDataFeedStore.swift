//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 07/12/2023.
//

import Foundation

public final class CoreDataFeedStore : FeedStore {
  
  public init() {}
  
  public func retrieve(completion: @escaping RetrievalCompletion) {
    completion(.empty)
  }
    
  public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
  }
    
  public func deleteCacheFeed(completion: @escaping DeletionCompletion) {
  }
}
