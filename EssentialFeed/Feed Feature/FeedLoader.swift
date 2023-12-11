//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/10/2023.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
