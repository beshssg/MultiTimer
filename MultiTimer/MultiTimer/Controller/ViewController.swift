//
//  ViewController.swift
//  MultiTimer
//
//  Created by beshssg on 05.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UIProperties:
    private var timerArray = [TimerModel]()
    
    
    var nameLabel: UILabel = {
        let label = PaddingLabel(withInsets: 34, 0, 16, 0)
        label.text = "Добавление таймеров"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.backgroundColor = #colorLiteral(red: 0.8979505897, green: 0.8981013894, blue: 0.9022359252, alpha: 1)
        label.layer.borderColor = UIColor.systemGray4.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var textTimer: UITextField = {
        var text = UITextField()
        text.placeholder = "Название таймера"
        text.backgroundColor = #colorLiteral(red: 0.9763746858, green: 0.9765377641, blue: 0.9763532281, alpha: 1)
        text.indentText(size: 10)
        text.layer.cornerRadius = 9
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray4.cgColor
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        return text
    }()
    
    var textTimerSecond: UITextField = {
        var text = UITextField()
        text.placeholder = "Время в секундах"
        text.backgroundColor = #colorLiteral(red: 0.9763746858, green: 0.9765377641, blue: 0.9763532281, alpha: 1)
        text.indentText(size: 10)
        text.layer.cornerRadius = 9
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray4.cgColor
        text.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        text.textColor = .black
        return text
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonMethod), for: .touchUpInside)
        button.backgroundColor = .systemGray6
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4780977368, blue: 0.9984350801, alpha: 1), for: .normal)
        button.layer.cornerRadius = 14
        return button
    }()
    
    var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
      
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Мульти-Таймер"
        view.backgroundColor = .white
        
        setups()
    }
    
    // MARK: - Methods:
    func setups() {
        [nameLabel, textTimer, textTimerSecond, addButton, tableView].forEach { view.addSubview($0) }
        [nameLabel, textTimer, textTimerSecond, addButton, tableView].forEach { mask in
            mask.translatesAutoresizingMaskIntoConstraints = false }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimerTableViewCell.self, forCellReuseIdentifier: String(describing: TimerTableViewCell.self))
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 70),
            
            textTimer.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 90),
            textTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textTimer.heightAnchor.constraint(equalToConstant: 30),
            textTimer.widthAnchor.constraint(equalToConstant: 250),
            
            textTimerSecond.topAnchor.constraint(equalTo: textTimer.topAnchor, constant: 45),
            textTimerSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textTimerSecond.heightAnchor.constraint(equalToConstant: 30),
            textTimerSecond.widthAnchor.constraint(equalToConstant: 250),
            
            addButton.topAnchor.constraint(equalTo: textTimerSecond.topAnchor, constant: 60),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: addButton.topAnchor, constant: 90),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func addButtonMethod() {
        guard let textName = textTimer.text else { return }
        guard let textTime = textTimerSecond.text else { return }
        var index = Int()
        
        if  !textName.isEmpty && !textTime.isEmpty {
            let timer = TimerModel(name: textTimer.text, time: Int(textTimerSecond.text ?? "nil"), currentTime: Int(textTimerSecond.text ?? "nil"))
            
            if timerArray.isEmpty {
                timerArray.append(timer)
            } else {
                index = insertElement(newElement: timer)
            }
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .none)
            }
            textTimerSecond.resignFirstResponder()
            textTimerSecond.text = nil
            textTimer.text = nil
        } else {
            let alert = UIAlertController(title: "Заполните все поля", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func insertElement(newElement: TimerModel) -> Int {
        var index = Int()
        
        if newElement.currentTime ?? 0 >= timerArray[0].currentTime ?? 0 {
            timerArray.insert(newElement, at: 0)
            index = 0
        } else if newElement.currentTime ?? 0 <= timerArray.last?.currentTime ?? 0 {
            index = timerArray.count
            timerArray.append(newElement)
        } else {
            for secondIndex in 0..<timerArray.count - 1 {
                if newElement.currentTime ?? 0 < timerArray[secondIndex].currentTime ?? 0 &&
                newElement.currentTime ?? 0 >= timerArray[secondIndex + 1].currentTime ?? 0 {
                    timerArray.insert(newElement, at: secondIndex + 1)
                    index = secondIndex + 1
                    }
                }
            }
        return index
    }
}

     // MARK: - Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TimerTableViewCell.self),
                                                           for: indexPath) as? TimerTableViewCell else { return UITableViewCell()}
        cell.nameLabel.text = timerArray[indexPath.row].name
        timerArray[indexPath.row].countdown(cell.timerLabel, cell: cell)
            
        cell.callback = { currentCell in
            guard let actualIndexPath = tableView.indexPath(for: currentCell) else { return }
            self.timerArray.remove(at: actualIndexPath.row)
            tableView.deleteRows(at: [actualIndexPath], with: .left)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Таймеры"
    }
        
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timerArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


