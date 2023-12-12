//
//  FeedStoreFiles.swift
//  EssentialFeedTests
//
//  Created by ROUX Maxime on 01/12/2023.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {
  enum ReceivedMessage: Equatable {
    case deleteCachedFeed
    case insert([LocalFeedImage], Date)
    case retrieve
  }
  
  private(set) var receivedMessages = [ReceivedMessage]()
  
  private var deletionCompletions = [DeletionCompletion]()
  private var insertionCompletions = [InsertionCompletion]()
  private var retrievalCompletions = [RetrievalCompletion]()

  func deleteCachedFeed(completion: @escaping DeletionCompletion) {
    deletionCompletions.append(completion)
    receivedMessages.append(.deleteCachedFeed)
  }
  
  func completeDeletion(with error: Error, at index: Int = 0) {
    deletionCompletions[index](.failure(error))
  }
  
  func completeDeletionSuccessFully(at index: Int = 0) {
    deletionCompletions[index](.success(()))
  }
  
  func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
    insertionCompletions.append(completion)
    receivedMessages.append(.insert(feed, timestamp))
  }
  
  func completeInsertion(with error: Error, at index: Int = 0) {
    insertionCompletions[index](.failure(error))
  }

  func completeInsertionSuccessFully(at index: Int = 0) {
    insertionCompletions[index](.success(()))
  }

  func retrieve(completion: @escaping RetrievalCompletion) {
    retrievalCompletions.append(completion)
    receivedMessages.append(.retrieve)
  }
  
  func completeRetrieval(with error: Error, at index: Int = 0) {
    retrievalCompletions[index](.failure(error))
  }
  
  func completeRetrievalWithEmptyCache(at index: Int = 0) {
    retrievalCompletions[index](.success(.none))
  }
  
  func completeRetrieval(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0) {
    retrievalCompletions[index](.success(CachedFeed(feed: feed, timestamp: timestamp)))
  }
}
