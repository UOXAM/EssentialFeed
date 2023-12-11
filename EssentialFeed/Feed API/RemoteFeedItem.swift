//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 01/12/2023.
//

import Foundation

 struct RemoteFeedItem: Decodable {
   let id: UUID
   let description: String?
   let location: String?
   let image: URL
}
