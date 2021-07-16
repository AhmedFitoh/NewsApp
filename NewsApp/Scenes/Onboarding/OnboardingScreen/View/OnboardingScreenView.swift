//
//  OnboardingScreenView.swift
//
//  Created by AhmedFitoh on 7/16/21.
//  
//

import UIKit

class OnboardingScreenView: UIViewController, Alertable {
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - VIPER Stack
    var presenter: OnboardingScreenViewToPresenterProtocol!
    
    // MARK:- Life Cycle
    let countryPicker: UIPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidFinishLoading()
    }
    
    private func setupUI(){
        setupPickerView()
        setupTableView()
        changeContinueButtonAvailability(to: false)
    }
    
    private func setupTableView(){
        categoriesTableView.tableFooterView = UIView()
        categoriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
    }
    
    private func setupPickerView(){
        // Delegates
        countryPicker.dataSource = self
        countryPicker.delegate = self
        // Toolbar
        let toolbar = UIToolbar()
        let spaceButton = UIBarButtonItem(systemItem: .flexibleSpace)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneSelected))
        toolbar.setItems([doneButton, spaceButton], animated: false)
        countryTextField.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        countryTextField.inputView = countryPicker
    }
    
    private func changeContinueButtonAvailability(to isAvailable: Bool){
        continueButton.alpha = isAvailable ? 1 : 0.4
        continueButton.isEnabled = isAvailable
    }
    
    private func validateCategorySelection(){
        if categoriesTableView.indexPathsForSelectedRows?.count ?? 0 >= 3 {
            changeContinueButtonAvailability(to: true)
        } else {
            changeContinueButtonAvailability(to: false)
        }
    }
    
    @objc private func doneSelected(){
        countryTextField.resignFirstResponder()
    }


    @IBAction func continueAction(_ sender: UIButton) {
        let catIndices = categoriesTableView.indexPathsForSelectedRows?.compactMap { $0.row} ?? []
        presenter?.userSelectedCountry(atIndex: countryPicker.selectedRow(inComponent: 0), categoriesWithIndex: catIndices)
    }
    
}

// MARK: - CountryPicker Protocol
extension OnboardingScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.categoriesList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)")
        cell?.textLabel?.text = presenter?.categoriesList [indexPath.row]
        if ((tableView.indexPathsForSelectedRows?.contains(indexPath)) != nil) {
            cell?.accessoryType = .checkmark
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        validateCategorySelection()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        validateCategorySelection()
    }
    
}


// MARK: - CountryPicker Protocol
extension OnboardingScreenView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter?.countriesList.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.countriesList [row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text = presenter?.countriesList [row].name
    }
}

// MARK: - Presenter to View Protocol
extension OnboardingScreenView: OnboardingScreenPresenterToViewProtocol {
    func reloadInfoViews() {
        countryPicker.reloadAllComponents()
        if !(presenter?.countriesList.isEmpty ?? false) {
            pickerView(countryPicker, didSelectRow: 0, inComponent: 0)
        }
        categoriesTableView.reloadData()
    }
    
    
}
