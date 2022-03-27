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
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(closeDetailViewController), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Fechar", for: .normal)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = screenTitle
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
        textField.text = taskname
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
    
    lazy var taskDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.label
        textField.placeholder = "Descrição da Tarefa"
        textField.text = taskDescription
        textField.borderStyle = .roundedRect
        textField.contentVerticalAlignment = .top
        textField.clearButtonMode = .always
        textField.font = UIFont.systemFont(ofSize: 12)
        return textField
    }()
    
    lazy var taskDoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Concluída?"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var taskDoneSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.isOn = taskDone
        return uiSwitch
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
        let task = TaskModel(id: UUID(), name: taskTitle.text!, details: taskDescriptionTextField.text!, done: taskDoneSwitch.isOn)
        ManagedObjectContext.shared.saveTask(task: task) { res in
            print(res)
            closeDetailViewController()
        }
    }
    
    //MARK: - Botão Atualizar

    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setTitle("Atualizar", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(updateTask), for: .touchUpInside)
        return button
    }()

    @objc func updateTask() {
        
        var taskList: TaskModel
        
        taskList = TaskModel(id: taskId, name: taskTitle.text!, details: taskDescriptionTextField.text!, done: taskDoneSwitch.isOn)
        
        ManagedObjectContext.shared.updateTask(task: taskList) { res in
            print(res)
            closeDetailViewController()
        }
    }
    
    //MARK: - Botão Remover

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.setTitle("Remover", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
        return button
    }()

    @objc func deleteTask() {
        
        ManagedObjectContext.shared.deleteTask(id: taskId) { res in
            print(res)
            closeDetailViewController()
        }
    }
    
    
    public var screenMode: String = ""
    
    public var taskId: UUID = UUID()
    public var taskname: String = ""
    public var taskDescription: String = ""
    public var taskDone: Bool = Bool()
    
    private var screenTitle: String = ""

    //MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        if screenMode == "NewTask" {
            initNewTaskScreenMode()
            //setupView()
        } else if screenMode == "UpdateTask" {
            initUpdateTaskScreenMode()
        }
    }
    
    @objc private func closeDetailViewController() {
        dismiss(animated: true)
    }
    
    private func initNewTaskScreenMode() {
        screenTitle = "Adicionar Tarefa"
        
        view.addSubview(titleLabel)
        view.addSubview(taskNameLabel)
        view.addSubview(taskTitle)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(taskDescriptionTextField)
        view.addSubview(taskDoneLabel)
        view.addSubview(taskDoneSwitch)
        view.addSubview(addButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            /*titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),*/
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //taskNameLabel
            taskNameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 140),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskTitle
            taskTitle.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskTitle.widthAnchor.constraint(equalToConstant: 200),
            
            //taskDescriptionLabel
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 60),
            taskDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskDescription
            taskDescriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            taskDescriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescriptionTextField.widthAnchor.constraint(equalToConstant: 200),
            taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 60),
            
            //taskDoneLabel
            taskDoneLabel.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 60),
            taskDoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskDoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskDone
            taskDoneSwitch.topAnchor.constraint(equalTo: taskDoneLabel.bottomAnchor, constant: 10),
            taskDoneSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            /*taskDoneSwitch.widthAnchor.constraint(equalToConstant: 200),
            taskDoneSwitch.heightAnchor.constraint(equalToConstant: 60),*/
            
            //buttonAdicionar
            addButton.topAnchor.constraint(equalTo: taskDoneSwitch.bottomAnchor, constant: 80),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            
            //closeButton
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func initUpdateTaskScreenMode() {
        screenTitle = "Atualizar Tarefa"
        
        view.addSubview(titleLabel)
        view.addSubview(taskNameLabel)
        view.addSubview(taskTitle)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(taskDescriptionTextField)
        view.addSubview(taskDoneLabel)
        view.addSubview(taskDoneSwitch)
        view.addSubview(updateButton)
        view.addSubview(deleteButton)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            /*titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),*/
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //taskNameLabel
            taskNameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 110),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskTitle
            taskTitle.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskTitle.widthAnchor.constraint(equalToConstant: 200),
            
            //taskDescriptionLabel
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 60),
            taskDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),

            
            //taskDescription
            taskDescriptionTextField.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            taskDescriptionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescriptionTextField.widthAnchor.constraint(equalToConstant: 200),
            taskDescriptionTextField.heightAnchor.constraint(equalToConstant: 60),
            
            //taskDoneLabel
            taskDoneLabel.topAnchor.constraint(equalTo: taskDescriptionTextField.bottomAnchor, constant: 60),
            taskDoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskDoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskDone
            taskDoneSwitch.topAnchor.constraint(equalTo: taskDoneLabel.bottomAnchor, constant: 10),
            taskDoneSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            /*taskDoneSwitch.widthAnchor.constraint(equalToConstant: 200),
            taskDoneSwitch.heightAnchor.constraint(equalToConstant: 60),*/
            
            //updateButton
            updateButton.topAnchor.constraint(equalTo: taskDoneSwitch.bottomAnchor, constant: 80),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 30),
            updateButton.widthAnchor.constraint(equalToConstant: 200),
            
            //deleteButton
            deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            
            //closeButton
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

}

/*extension DetailViewController: ViewCodable {
    
    func buildHierarchy() {
        
        view.addSubview(titleLabel)
        view.addSubview(taskNameLabel)
        view.addSubview(taskTitle)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(taskDescription)
        view.addSubview(addButton)
        view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            //titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            /*titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),*/
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //taskNameLabel
            taskNameLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 140),
            taskNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //taskTitle
            taskTitle.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 10),
            taskTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskTitle.widthAnchor.constraint(equalToConstant: 200),
            
            //taskDescriptionLabel
            taskDescriptionLabel.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 60),
            taskDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            /*//textView
            textView.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            /*textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),*/
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100),
            textView.widthAnchor.constraint(equalToConstant: 200),*/
            
            //taskDescription
            taskDescription.topAnchor.constraint(equalTo: taskDescriptionLabel.bottomAnchor, constant: 10),
            taskDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //taskDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskDescription.widthAnchor.constraint(equalToConstant: 200),
            taskDescription.heightAnchor.constraint(equalToConstant: 60),
            
            //buttonAdicionar
            addButton.topAnchor.constraint(equalTo: taskDescription.bottomAnchor, constant: 80),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 200),
            
            //closeButton
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
*/
