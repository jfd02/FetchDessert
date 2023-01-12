//
//  MealView.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

class MealView: BaseView {

    internal var meal: MealDataModel? {
        didSet {
            setMeal()
        }
    }

    private let mealScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
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
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
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
    
    private func createStepLabel(step: Int) -> UILabel {
        let stepLabel = UILabel()
        stepLabel.translatesAutoresizingMaskIntoConstraints = false
        stepLabel.text = "Step \(step + 1)"
        stepLabel.font = FetchFont.bold(size: 18)
        return stepLabel
    }
    
    private func createInstructionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FetchFont.medium(size: 14)
        label.numberOfLines = 0
        label.text = text
        return label
    }

    private func createInstructionsSteps(instructions: String) {
        let lines = instructions.split(whereSeparator: \.isNewline)
        for (index, line) in lines.enumerated() {
            let wrapperView = UIView()
            wrapperView.translatesAutoresizingMaskIntoConstraints = false

            let stepLabel = createStepLabel(step: index)
            wrapperView.addSubview(stepLabel)
            stepLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
            stepLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
            stepLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true

            let instructionLabel = createInstructionLabel(text: String(line))

            wrapperView.addSubview(instructionLabel)
            instructionLabel.topAnchor.constraint(equalTo: stepLabel.bottomAnchor, constant: 5).isActive = true
            instructionLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
            instructionLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true

            wrapperView.bottomAnchor.constraint(equalTo: instructionLabel.bottomAnchor).isActive = true
            instructionsStackView.addArrangedSubview(wrapperView)
        }
    }
    
    private let marginsLayoutGuide = UILayoutGuide()

    override func setupView() {
        self.backgroundColor = FetchColor.background
        self.addSubview(mealScrollView)
        self.addLayoutGuide(marginsLayoutGuide)
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
                        
            marginsLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            marginsLayoutGuide.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15),

            mealLabel.topAnchor.constraint(equalTo: mealScrollView.topAnchor),
            mealLabel.leadingAnchor.constraint(equalTo: marginsLayoutGuide.leadingAnchor),
            mealLabel.trailingAnchor.constraint(equalTo: marginsLayoutGuide.trailingAnchor),

            mealImage.topAnchor.constraint(equalTo: mealLabel.bottomAnchor, constant: 15),
            mealImage.leadingAnchor.constraint(equalTo: marginsLayoutGuide.leadingAnchor),
            mealImage.trailingAnchor.constraint(equalTo: marginsLayoutGuide.trailingAnchor),
            mealImage.heightAnchor.constraint(equalToConstant: 200),

            instructionsLabel.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: marginsLayoutGuide.leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: marginsLayoutGuide.trailingAnchor),
            
            instructionsStackView.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 8),
            instructionsStackView.leadingAnchor.constraint(equalTo: marginsLayoutGuide.leadingAnchor),
            instructionsStackView.trailingAnchor.constraint(equalTo: marginsLayoutGuide.trailingAnchor),

            ingredientsLabel.topAnchor.constraint(equalTo: instructionsStackView.bottomAnchor, constant: 15),
            ingredientsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ingredientsLabel.widthAnchor.constraint(lessThanOrEqualTo: mealScrollView.widthAnchor),

            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            ingredientsStackView.leadingAnchor.constraint(equalTo: marginsLayoutGuide.leadingAnchor),
            ingredientsStackView.trailingAnchor.constraint(equalTo: marginsLayoutGuide.trailingAnchor),
            ingredientsStackView.bottomAnchor.constraint(equalTo: mealScrollView.bottomAnchor, constant: -15)
        ])
    }
}

extension MealView {
    private func setMeal() {
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
