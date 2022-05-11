import UIKit

class CitiesListViewController: UIViewController {
    //MARK: - properties
    let viewModel = CitiesListViewModel()
    
    private lazy var citiesListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "search"
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        return textField
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
        viewModel.getCitiesList()
    }
    
    //MARK: - methods
    private func addSubview() {
        view.addSubview(searchTextField)
        view.addSubview(citiesListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            citiesListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            citiesListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            citiesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchTextField.bottomAnchor.constraint(equalTo: citiesListTableView.topAnchor, constant: -10)
        ])
    }
    
    @objc private func searchTextChanged() {
        viewModel.changeEditing(textFieldText: searchTextField.text)
        citiesListTableView.reloadData()
    }
}

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCityNames.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.filteredCityNames.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cityName = viewModel.filteredCityNames.value[indexPath.row] else { return }
        viewModel.getDataForPickedCityName(with: cityName)
        dismiss(animated: true)
    }
}
