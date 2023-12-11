//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/10/2023.
//

import Foundation

public protocol FeedLoader {
  typealias Result = Swift.Result<[FeedImage], Error>

  func load(completion: @escaping (Result) -> Void)
}
