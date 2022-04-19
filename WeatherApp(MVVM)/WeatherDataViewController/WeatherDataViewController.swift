import Foundation
import UIKit

class WeatherDataViewController: UIViewController {
    //MARK: - properties
    private let viewModel = WeatherDataViewModel()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.text = viewModel.cityName.value
        return label
    }()
    
    private let presentCityList: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = LayerManager.shared.cornerRadius
        button.addTarget(self, action: #selector(presentCitiesListViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var weatherTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier)
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: DailyWeatherTableViewCell.identifier)
        tableView.register(HourlyWeatherTableViewCell.self, forCellReuseIdentifier: HourlyWeatherTableViewCell.identifier)
        tableView.register(SunriseAndSunsetTableViewCell.self, forCellReuseIdentifier: SunriseAndSunsetTableViewCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    init(currentWeatherData: CurrentWeatherInfo?, weeklyWeatherData: WeeklyWeatherData?, cityName: String?) {
        viewModel.weeklyWeatherData.value = weeklyWeatherData
        viewModel.currentWeatherData.value = currentWeatherData
        viewModel.cityName.value = cityName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        constraintsSetup()
        bind()
    }
    
    //MARK: - methods
    private func addSubview() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(weatherTableView)
        backgroundImageView.addSubview(presentCityList)
        backgroundImageView.addSubview(cityNameLabel)
    }
    
    private func constraintsSetup() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 100),
            weatherTableView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cityNameLabel.bottomAnchor.constraint(equalTo: weatherTableView.topAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: presentCityList.trailingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: weatherTableView.trailingAnchor, constant: -50),
            cityNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            presentCityList.bottomAnchor.constraint(equalTo: weatherTableView.topAnchor, constant: -10),
            presentCityList.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            presentCityList.widthAnchor.constraint(equalToConstant: 50),
            presentCityList.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func bind() {
        viewModel.cityName.bind { [weak self] cityName in
            self?.cityNameLabel.text = cityName
        }
    }
    
    @objc private func presentCitiesListViewController() {
        viewModel.cityListViewController.bind { [weak self] citiesListViewController in
            self?.present(citiesListViewController, animated: true, completion: nil)
            citiesListViewController.viewModel.delegate = self
        }
    }
}

extension WeatherDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return viewModel.weeklyWeatherData.value?.daily?.count ?? 0
            
        case 3:
            return 1
            
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let currentWeatherCell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherTableViewCell.identifier, for: indexPath) as? CurrentWeatherTableViewCell else { return UITableViewCell() }
            
            guard let currentWeatherData = viewModel.currentWeatherData.value else { return UITableViewCell() }
            
            currentWeatherCell.viewModel.configureCurrentWeatherData(with: currentWeatherData)
            return currentWeatherCell
            
        case 1:
            guard let hourlyWeatherCell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherTableViewCell.identifier, for: indexPath) as? HourlyWeatherTableViewCell else { return UITableViewCell() }
            
            guard let hourlyWeatherData = viewModel.weeklyWeatherData.value else { return UITableViewCell() }
            
            hourlyWeatherCell.viewModel.initHourlyWeatherData(with: hourlyWeatherData)
            return hourlyWeatherCell
            
        case 2:
            guard let dailyWeatherCell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.identifier, for: indexPath) as? DailyWeatherTableViewCell else { return UITableViewCell() }
            
            guard let dailyWeatherData = viewModel.weeklyWeatherData.value else { return UITableViewCell() }
            
            dailyWeatherCell.viewModel.configureDailyWeatherData(with: dailyWeatherData, indexPath: indexPath)
            return dailyWeatherCell
            
        case 3:
            guard let sunriseAndSunsetCell = tableView.dequeueReusableCell(withIdentifier: SunriseAndSunsetTableViewCell.identifier, for: indexPath) as? SunriseAndSunsetTableViewCell else { return UITableViewCell() }
            
            guard let sunriseAndSunsetData = viewModel.currentWeatherData.value else { return UITableViewCell() }
            
            sunriseAndSunsetCell.viewModel.configureSunriseAndSunsetTime(with: sunriseAndSunsetData)
            return sunriseAndSunsetCell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
            
        case 1:
            return 150
            
        case 2:
            return 100
            
        case 3:
            return 150
            
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "current weather"
            
        case 1:
            return "hourly weather"
            
        case 2:
            return "weekly weather"
            
        case 3:
            return "sunrise and sunset time"
            
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .clear
            headerView.textLabel?.textAlignment = .left
            headerView.backgroundView?.backgroundColor = .clear
            headerView.textLabel?.textColor = .white
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getSectionAmount()
    }
}

extension WeatherDataViewController: CitiesViewModelDelegate {
    func requestForPickedCity(cityName: String) {
        viewModel.fetchRequestBy(cityName: cityName) {
            self.weatherTableView.reloadData()
        }
    }
}
