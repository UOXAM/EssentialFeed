//
//  CoreDataHelpers.swift
//  EssentialFeed
//
//  Created by ROUX Maxime on 07/12/2023.
//

import CoreData

 extension NSPersistentContainer {
  enum Loadingerror: Swift.Error {
    case modelNotFound
    case failedToLoadPersistentStores(Swift.Error)
  }
  
  static func load(modelName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
    guard let model = NSManagedObjectModel.with(name: name, in: bundle) else {
      throw Loadingerror.modelNotFound
    }
    
    let description = NSPersistentStoreDescription(url: url)
    let container = NSPersistentContainer(name: name, managedObjectModel: model)
    container.persistentStoreDescriptions = [description]
    
    var loadError: Swift.Error?
    container.loadPersistentStores { loadError = $1 }
    try loadError.map { throw Loadingerror.failedToLoadPersistentStores($0) }
    
    return container
  }
}

private extension NSManagedObjectModel {
  static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
    return bundle
      .url(forResource: name, withExtension: "momd")
      .flatMap { NSManagedObjectModel(contentsOf: $0) }
  }
}
