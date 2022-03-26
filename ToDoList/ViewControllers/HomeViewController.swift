//
//  ViewController.swift
//  ToDoList
//
//  Created by Idwall Go Dev 008 on 26/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var tasks = [TaskModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tasksTableView.reloadData()
            }
        }
    }
    
    lazy var tasksTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
        configNavigationBar()
    }

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
        getTasks()
        constraints()
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(handleAddNewTaks))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @IBAction private func handleAddNewTaks() {
        let detailsView = DetailViewController()
        detailsView.modalPresentationStyle = .fullScreen
        navigationController?.present(detailsView, animated: true)
    }
    
    @IBAction private func longPressAction(_ gesture: UIGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! TaskTableViewCell
            
            guard let indexPath = tasksTableView.indexPath(for: cell) else { return }
            
            var task = tasks[indexPath.row]
            
            UpdateStatusTaskCell(controller: self).exibe(task) { alert in
                ManagedObjectContext.shared.deleteTask(id: task.id) { res in
                    print(res)
                }
                self.tasks.remove(at: indexPath.row)
            } handlerUpdate: { alert in
                print(task)
                task.done = !task.done
                ManagedObjectContext.shared.updateTask(task: task) { res in
                    print(res)
                    print(task)
                }
            }
            
        }
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
    
    private func getTasks() {
        tasks = ManagedObjectContext.shared.getTask()
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
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        
        cell.addGestureRecognizer(longPress)
        
        cell.configure(with: tasks[indexPath.row])
        
        return cell
    }
    
    
}

