//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 24/10/2023.
//

import Foundation

public struct FeedItem: Equatable {
  let id: UUID
  let description: String?
  let location: String?
  let imageUrl: URL
}
