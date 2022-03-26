//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Victor Pizetta on 26/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    //MARK: - Components
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(closeDetailViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Adicionar Tarefa"
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Título da Tarefa"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taskTitle: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.label
        textField.placeholder = "Nome da Tarefa"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 12)
        return textField
    }()
    
    lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descrição da Tarefa"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: UITextView = {
        let textLabel = UITextView()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor.label
        textLabel.backgroundColor = .lightGray
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()
    
    
    //MARK: - Botão Adicionar
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        return button
    }()
    
    @objc func saveTask() {
        let task = TaskModel(id: UUID(), name: taskTitle.text!, details: textView.text, done: false)
        ManagedObjectContext.shared.saveTask(task: task) { res in
            print(res)
            closeDetailViewController()
        }
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        //configNavigationBar()
        setupView()
    }
    
    @objc private func closeDetailViewController() {
        dismiss(animated: true)
    }
}

extension DetailViewController: ViewCodable {
    
    func buildHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(taskNameLabel)
        view.addSubview(taskTitle)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(textView)
        view.addSubview(addButton)
        view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            //taskNameLabel
            taskNameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 140),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskTitle
            taskTitle.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTitle.widthAnchor.constraint(equalToConstant: 200),
            
            //taskDescriptionLabel
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 40),
            taskDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //textView
            textView.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            //buttonAdicionar
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            
            //closeButton
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
