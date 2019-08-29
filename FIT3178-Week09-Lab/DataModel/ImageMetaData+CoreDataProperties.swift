//
//  ImageMetaData+CoreDataProperties.swift
//  FIT3178-Week09-Lab
//
//  Created by hideto on 26/8/19.
//  Copyright © 2019 Monash University. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageMetaData> {
        return NSFetchRequest<ImageMetaData>(entityName: "ImageMetaData")
    }

    @NSManaged public var filename: String?

}
