//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/10/2023.
//

import Foundation

enum LoadFeedResult {
  case success([FeedItem])
  case error(Error)
}

protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
