//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    static let identifier = "TaskTableViewCell"
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.contentMode = .top
        stack.spacing = 10
        return stack
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Titulo"
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descrição"
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(descriptionLabel)
        addSubview(verticalStack)
    }
    
    func configure(with model: TaskModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.details
        taskDone(done: model.done)
    }
    
    private func taskDone(done: Bool) {
        if done {
            nameLabel.textColor = .gray
            descriptionLabel.textColor = .gray
            
            let nameLabelAtribute: NSMutableAttributedString =  NSMutableAttributedString(string: nameLabel.text ?? "")
            nameLabelAtribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, nameLabelAtribute.length))
            nameLabel.attributedText = nameLabelAtribute
            
            
            let descriptionLabelAtribute: NSMutableAttributedString =  NSMutableAttributedString(string: descriptionLabel.text ?? "")
            descriptionLabelAtribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, descriptionLabelAtribute.length))
            descriptionLabel.attributedText = descriptionLabelAtribute
        }
    }
    
    
    private func configConstraints() {
        //Stack view
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
}
