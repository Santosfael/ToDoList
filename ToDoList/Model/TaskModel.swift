//
//  Task.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import Foundation

struct TaskModel: Codable {
    var id: UUID
    var name: String
    var details: String
    var done: Bool
}
