//
//  Task.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import Foundation


struct Task {
    var id: UUID
    var name: String
    var details: String
    var done: Bool
}

struct TaskModel: Codable {
    let id: UUID
    let name: String
    let details: String
    let done: Bool
}
