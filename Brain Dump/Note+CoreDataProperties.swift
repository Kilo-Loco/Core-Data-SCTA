//
//  Note+CoreDataProperties.swift
//  Brain Dump
//
//  Created by Kyle Lee on 6/20/18.
//  Copyright © 2018 Kyle Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String

}
