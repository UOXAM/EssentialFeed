//
//  CodableFeedStore.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 06/12/2023.
//

import Foundation

public final class CodableFeedStore: FeedStore {
  private struct Cache: Codable {
    let feed: [CodableFeedImage]
    let timestamp: Date
    
    var localFeed: [LocalFeedImage] {
      return feed.map { $0.local }
    }
  }
  
  private struct CodableFeedImage: Codable {
    private let id: UUID
    private let description: String?
    private let location: String?
    private let url: URL
    
    init(_ image: LocalFeedImage) {
      id = image.id
      description = image.description
      location = image.location
      url = image.url
    }
    
    var local: LocalFeedImage {
      return LocalFeedImage(id: id, description: description, location: location, url: url)
    }
  }
  
  // DispatchQueue.global is concurrent, so we use a backgroundQueue which by default operation run serially. But we can also define as concurrent.
  private let queue = DispatchQueue(label: "\(CodableFeedStore.self)Queue", qos: .userInitiated, attributes: .concurrent)
  private let storeURL: URL
  
  public init(storeURL: URL) {
    self.storeURL = storeURL
  }
  
  public func retrieve(completion: @escaping FeedStore.RetrievalCompletion) {
    let storeURL = self.storeURL
    queue.async {
      guard let data = try? Data(contentsOf: storeURL) else {
        return completion(.empty)
      }
      
      do {
        let decoder = JSONDecoder()
        let cache = try decoder.decode(Cache.self, from: data)
        completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
  public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping FeedStore.InsertionCompletion) {
    let storeURL = self.storeURL
    queue.async(flags: .barrier) {
      do {
        let encoder = JSONEncoder()
        let cache = Cache(feed: feed.map(CodableFeedImage.init), timestamp: timestamp)
        let encoded = try encoder.encode(cache)
        try encoded.write(to: storeURL)
        completion(nil)
      } catch {
        completion(error)
      }
    }
  }
  
  public func deleteCacheFeed(completion: @escaping FeedStore.DeletionCompletion) {
    // we capture value instead a reference
    let storeURL = self.storeURL
    // As we define the queue concurrent, we have to use the flags .barrier to avoid conccurence when a specific command (with side-effects) is launched
    queue.async(flags: .barrier) {
      guard FileManager.default.fileExists(atPath: storeURL.path) else {
        return completion(nil)
      }
      
      do {
        try FileManager.default.removeItem(at: storeURL)
        completion(nil)
      } catch {
        completion(error)
      }
    }
  }
  
}

