//
//  RemoveTaskCell.swift
//  ToDoList
//
//  Created by SP11793 on 26/03/22.
//

import Foundation
import UIKit

class UpdateStatusTaskCell {

    let controller: UIViewController

    init(controller: UIViewController) {
        self.controller = controller
    }

    func exibe(_ task: TaskModel, handlerDelete: @escaping (UIAlertAction) -> Void, handlerUpdate: @escaping (UIAlertAction) -> Void) {

        let alert = UIAlertController(title: "Atualizar Tarefa", message: "Deseja atualizar o estado da tarefa \(task.name)?",
                                      preferredStyle: .alert)
        
        let doneButton = UIAlertAction(title: "Finalizar Tarefa", style: .default, handler: handlerUpdate)
        let removeButton = UIAlertAction(title: "Remover Tarefa", style: .destructive, handler: handlerDelete)
        let backButton = UIAlertAction(title: "Voltar", style: .cancel, handler: nil)
        
        alert.addAction(doneButton)
        alert.addAction(removeButton)
        alert.addAction(backButton)

        controller.present(alert, animated: true, completion: nil)
    }
}
