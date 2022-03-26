//
//  TaskTableViewHeader.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import UIKit

class TaskTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "TaskTableViewHeader"
    
    lazy var cleanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Limpar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    lazy var doneAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Finalizar todos", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        contentView.addSubview(cleanButton)
        contentView.addSubview(doneAllButton)
    }
    
    private func constraints() {
        //clearButton
        NSLayoutConstraint.activate([
            cleanButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            cleanButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            doneAllButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            doneAllButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
}
