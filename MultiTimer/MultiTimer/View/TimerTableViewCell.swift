//
//  TimerTableViewCell.swift
//  MultiTimer
//
//  Created by beshssg on 06.09.2021.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    // MARK: - UIProperties:
    public var nameLabel = UILabel()
    public var timerLabel = UILabel()
        
    public var callback: ((UITableViewCell)->())?
    
    // MARK: - Lifecycle:
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods:
    func setup() {
        [nameLabel, timerLabel].forEach { addSubview($0) }
        [nameLabel, timerLabel].forEach { mask in mask.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
