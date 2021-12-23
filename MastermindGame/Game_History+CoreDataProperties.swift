//
//  Game_History+CoreDataProperties.swift
//  MastermindGame
//
//  Created by Shen Licheng on 21/11/2021.
//
//

import Foundation
import CoreData


extension Game_History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game_History> {
        return NSFetchRequest<Game_History>(entityName: "Game_History")
    }

    @NSManaged public var num_of_time: String?
    @NSManaged public var user_name: String?

}

extension Game_History : Identifiable {

}
