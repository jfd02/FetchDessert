//
//  SearchBar.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func didSearch(text: String)
}

class SearchBar: BaseView {

    weak var delegate: SearchBarDelegate?

    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = FetchColor.background
        view.layer.borderColor = FetchColor.primary.cgColor
        view.layer.borderWidth = 2
        return view
    }()

    private let searchIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "SearchIcon")
        view.tintColor = FetchColor.primary
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let clearIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "SearchClear")
        view.contentMode = .scaleAspectFit
        view.tintColor = FetchColor.primary
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = FetchFont.medium(size: 18)
        textField.tintColor = FetchColor.primary
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search for desserts",
            attributes: [NSAttributedString.Key.foregroundColor: FetchColor.primary]
        )
        return textField
    }()

    private let searchMargins = UILayoutGuide()

    private let textFieldPlaceholderMargins = UILayoutGuide()

    private let textFieldMargins = UILayoutGuide()

    override func setupView() {
        self.addSubview(backgroundView)
        backgroundView.addLayoutGuide(searchMargins)
        backgroundView.addLayoutGuide(textFieldPlaceholderMargins)
        backgroundView.addLayoutGuide(textFieldMargins)
        backgroundView.addSubview(searchIcon)
        backgroundView.addSubview(clearIcon)
        clearIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedClear)))
        backgroundView.addSubview(textField)
        textField.delegate = self
    }

    override func layoutView() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            searchMargins.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            searchMargins.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            searchMargins.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.95),
            searchMargins.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.5),

            textFieldPlaceholderMargins.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor),
            textFieldPlaceholderMargins.trailingAnchor.constraint(equalTo: clearIcon.leadingAnchor),
            textFieldPlaceholderMargins.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldPlaceholderMargins.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.5),

            textFieldMargins.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldMargins.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            textFieldMargins.widthAnchor.constraint(equalTo: textFieldPlaceholderMargins.widthAnchor, multiplier: 0.95),
            textFieldMargins.heightAnchor.constraint(equalTo: backgroundView.heightAnchor, multiplier: 0.5),

            searchIcon.leadingAnchor.constraint(equalTo: searchMargins.leadingAnchor),
            searchIcon.heightAnchor.constraint(equalTo: searchMargins.heightAnchor),
            searchIcon.widthAnchor.constraint(equalTo: searchIcon.heightAnchor),
            searchIcon.centerYAnchor.constraint(equalTo: searchMargins.centerYAnchor),

            clearIcon.trailingAnchor.constraint(equalTo: searchMargins.trailingAnchor),
            clearIcon.heightAnchor.constraint(equalTo: searchMargins.heightAnchor),
            clearIcon.widthAnchor.constraint(equalTo: clearIcon.heightAnchor),
            clearIcon.centerYAnchor.constraint(equalTo: searchMargins.centerYAnchor),

            textField.leadingAnchor.constraint(equalTo: textFieldMargins.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: textFieldMargins.trailingAnchor),
            textField.heightAnchor.constraint(equalTo: searchMargins.heightAnchor),
            textField.centerYAnchor.constraint(equalTo: searchMargins.centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView.layer.cornerRadius = self.frame.size.height / 2
        textField.font = FetchFont.medium(size: backgroundView.frame.height * 0.3)
    }
}

extension SearchBar {
    @objc private func tappedClear() {
        textField.text = ""
        searchText()
    }

    func dismissKeyboard() {
        textField.resignFirstResponder()
    }

    func searchText() {
        guard let text = textField.text else { return }
        logger.debug("SearchBar | Searching for \(text)")
        delegate?.didSearch(text: text)
    }
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        searchText()
        clearIcon.isHidden = text.count <= 0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText()
        dismissKeyboard()
        return true
    }
}
