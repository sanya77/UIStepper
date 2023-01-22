//
//  ViewController.swift
//  UIStepper
//
//  Created by Александр Травин on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var titleLabel = UILabel()
    var segmentedControl = UISegmentedControl(items: ["pizza 32", "pizza 48", "pizza 52"])
    var itemImageView = UIImageView()
    var desctriptionLabel = UILabel()
    var stepper = UIStepper()
    var sendButton = UIButton()
    var addButton = UIButton()
    
    var itemDescription = "пицца Пепперони 32 см в количестве - 1шт." {
        didSet {
            desctriptionLabel.text = itemDescription
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(itemImageView)
        view.addSubview(desctriptionLabel)
        view.addSubview(stepper)
        view.addSubview(sendButton)
        view.addSubview(addButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        desctriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            // Разместили titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        // Под ним разместили картинку и задали ей размеры
            itemImageView.widthAnchor.constraint(equalToConstant: 300),
            itemImageView.heightAnchor.constraint(equalToConstant: 300),
            itemImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        // Далее сегмент контроллер
            segmentedControl.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            desctriptionLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            desctriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            desctriptionLabel.widthAnchor.constraint(equalToConstant: 200),
        
            stepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stepper.centerYAnchor.constraint(equalTo: desctriptionLabel.centerYAnchor),
        
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.widthAnchor.constraint(equalToConstant: 100),
            sendButton.topAnchor.constraint(equalTo: desctriptionLabel.bottomAnchor, constant: 16),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
//            addButton.heightAnchor.constraint(equalToConstant: 30),
//            addButton.widthAnchor.constraint(equalToConstant: 100),
//            addButton.topAnchor.constraint(equalTo: desctriptionLabel.bottomAnchor, constant: -16),
//            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        
        
        
        titleLabel.text = "Пепперони"
        titleLabel.font = UIFont.systemFont(ofSize: 33)
        titleLabel.textAlignment = .center
        
        
        itemImageView.layer.cornerRadius = 15 // закругление картинки
        itemImageView.clipsToBounds = true // значение, чтобы картинка не выходила за границы
        itemImageView.contentMode = .scaleToFill
        itemImageView.image = UIImage(named: "1")
        
        segmentedControl.selectedSegmentIndex = 0 // первый элемент сегмент контрллера
        segmentedControl.addTarget(self, action: #selector(segmentAction(sender:)), for: .valueChanged)
        
        desctriptionLabel.textAlignment = .center // Выравнивание текста по центру
        desctriptionLabel.numberOfLines = 0 // неограниченное количество строк внутри себя
        desctriptionLabel.text = itemDescription
    
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperAction(sender:)), for: .valueChanged)
        
        sendButton.setTitle("Добавить", for: .normal)
        sendButton.setTitleColor(.blue, for: .normal) // по умолчанию текст синий
        sendButton.setTitleColor(.darkGray, for: .highlighted) // если нажмем кнопку, цвет будет серый
        sendButton.layer.cornerRadius = 10 // закругление углов кнопки
        sendButton.backgroundColor = UIColor(red: 220/252, green: 220/252, blue: 220/252, alpha: 0.9)// цвет фона кнопки
        sendButton.addTarget(self, action: #selector(sendAction), for: .touchUpInside)
        
    }
    
    @objc func segmentAction(sender: UISegmentedControl) {
        itemDescription = "пицца Пепперони \(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!) см в количестве - \(stepper.value) шт."
        switch sender.selectedSegmentIndex {
        case 0: changePizza(for: 1)
        case 1: changePizza(for: 2)
        case 2: changePizza(for: 3)
        default: break
        }
        
    }
    func changePizza(for index: Int) {
        UIView.animate(withDuration: 0.5, animations: {
            self.itemImageView.alpha = 0
        }){ _ in
            UIView.animate(withDuration: 0.5, animations:{
                self.itemImageView.alpha = 1
                self.itemImageView.image = UIImage(named: "\(index)")
            })
        }
    }
    @objc func stepperAction(sender: UIStepper) {
        itemDescription = "пицца Пепперони \(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)!) см в количестве - \(sender.value) шт."
        
    }
    @objc func sendAction() {
        
        print("Добавлено в количестве - \(stepper.value)")
    }


}

