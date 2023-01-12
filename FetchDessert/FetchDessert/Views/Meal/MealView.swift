//
//  MealView.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import Foundation
import UIKit

class MealView: BaseView {
    
    internal var meal: MealDataModel? {
        didSet {
            guard let meal = meal else { return }
            mealLabel.text = meal.mealName
            createInstructionsSteps(instructions: meal.instructions)
            createIngredientsList(ingredients: meal.getIngredientsList())
                        
            if meal.image != nil {
                meal.image = meal.image
            } else {
                if let url = URL(string: meal.mealImageStr) {
                    mealImage.load(url: url, completion: { image in
                        meal.image = image
                    })
                }
            }
        }
    }
    
    private let mealScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let mealLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FetchFont.bold(size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private let mealImage: RemoteImageView = {
        let remoteImage = RemoteImageView()
        remoteImage.translatesAutoresizingMaskIntoConstraints = false
        remoteImage.contentMode = .scaleAspectFill
        remoteImage.clipsToBounds = true
        return remoteImage
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FetchFont.bold(size: 22)
        label.text = "Instructions:"
        label.numberOfLines = 0
        return label
    }()
        
    private let instructionsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
        
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FetchFont.bold(size: 19)
        label.text = "Ingredients"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let ingredientsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    private func createIngredientsList(ingredients: [IngredientModel]) {
        for ingredient in ingredients {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = FetchFont.medium(size: 14)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = "\(ingredient.ingredient) - \(ingredient.measurement)"
            ingredientsStackView.addArrangedSubview(label)
        }
    }
    
    private func createInstructionsSteps(instructions: String) {
        let lines = instructions.split(whereSeparator: \.isNewline)
        for (index, line) in lines.enumerated() {
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let stepLabel = UILabel()
            stepLabel.translatesAutoresizingMaskIntoConstraints = false
            stepLabel.text = "Step \(index + 1)"
            stepLabel.font = FetchFont.bold(size: 18)
            view.addSubview(stepLabel)
            stepLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            stepLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            stepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = FetchFont.medium(size: 14)
            label.text = String(line)
            label.numberOfLines = 0
            
            view.addSubview(label)
            label.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 5).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            view.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
            instructionsStackView.addArrangedSubview(view)
        }
    }
    
    override func setupView() {
        self.backgroundColor = FetchColor.background
        self.addSubview(mealScrollView)
        mealScrollView.addSubview(mealLabel)
        mealScrollView.addSubview(mealImage)
        mealScrollView.addSubview(instructionsLabel)
        mealScrollView.addSubview(instructionsStackView)
        mealScrollView.addSubview(ingredientsLabel)
        mealScrollView.addSubview(ingredientsStackView)
    }
    
    override func layoutView() {
        NSLayoutConstraint.activate([
            mealScrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mealScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mealScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mealScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mealLabel.topAnchor.constraint(equalTo: mealScrollView.topAnchor),
            mealLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mealLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            mealImage.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: 15),
            mealImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mealImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mealImage.heightAnchor.constraint(equalToConstant: 200),
            
            instructionsLabel.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            instructionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            instructionsStackView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 8),
            instructionsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            instructionsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            ingredientsLabel.topAnchor.constraint(equalTo: instructionsStackView.bottomAnchor, constant: 15),
            ingredientsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ingredientsLabel.widthAnchor.constraint(lessThanOrEqualTo: mealScrollView.widthAnchor),
    
            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            ingredientsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            ingredientsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            ingredientsStackView.bottomAnchor.constraint(equalTo: mealScrollView.bottomAnchor, constant: -15),
        ])
    }
}
