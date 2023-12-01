//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/10/2023.
//

import Foundation

public enum LoadFeedResult {
  case success([FeedImage])
  case failure(Error)
}

public protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
