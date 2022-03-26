//
//  ViewController.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var tasks = [TaskModel]() {
        didSet {
            tasks.sort { _, current in
                current.done
            }
        }
    }
    
    lazy var tasksTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configNavigationBar()
    }
    
    private func configView() {
        title = "ToDo"
        view.backgroundColor = .systemBackground
        view.addSubview(tasksTableView)
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        tasksTableView.register(TaskTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TaskTableViewHeader.identifier)
        tasksTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tasks = [
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: true),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
            TaskModel(id: UUID(), name: "Titulo", details: "Descrição", done: false),
        ]
        constraints()
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(handleAddNewTaks))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @IBAction private func handleAddNewTaks() {
        print("cliquei")
    }
    
    private func constraints() {
        //Tableview
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskTableViewHeader.identifier) as? TaskTableViewHeader else { return UIView()}
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
    
    
}

