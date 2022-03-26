//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Victor Pizetta on 26/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Components
    lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    func setupTitle(titulo: String) {
        taskTitle.text = titulo
    }
    
    lazy var textView: UITextView = {
        let textLabel = UITextView()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor.black
        textLabel.backgroundColor = #colorLiteral(red: 0.8980627656, green: 0.8980627656, blue: 0.8980627656, alpha: 1)
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()
    
    func setupTextView(texto: String) {
        textView.text = texto
    }
    
    //MARK: - Botão Adicionar
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Adicionar", for: .normal)
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        return button
    }()
    
    @objc func saveTask() {
        print("task salva")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationBarSetup()
        title = "Nova Tarefa"
        setupView()
        setupTitle(titulo: "Tarefas de casa")
        setupTextView(texto: "Terminar o desafio do whatsapp")
    }
    
    //MARK: - Close button
    func navigationBarSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = #colorLiteral(red: 0.6953114867, green: 0.5059730411, blue: 0.9276791215, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let addButton = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .plain, target: self, action: #selector(callViewController))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc private func callViewController() {
        let homeVC = HomeViewController()
        navigationController?.present(homeVC, animated: true)
    }
}

extension DetailViewController: ViewCodable {
    
    func buildHierarchy() {
        view.addSubview(taskTitle)
        view.addSubview(textView)
        view.addSubview(addButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            //titleLabel
            taskTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            taskTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            taskTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -200),
            
            //textView
            textView.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 30),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 350),
            
            //buttonAdicionar
            addButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
