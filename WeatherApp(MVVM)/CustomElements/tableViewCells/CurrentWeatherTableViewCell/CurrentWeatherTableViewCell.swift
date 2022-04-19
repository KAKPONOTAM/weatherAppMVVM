import UIKit
import Kingfisher

class CurrentWeatherTableViewCell: UITableViewCell {
    static let identifier = "CurrentWeatherTableViewCell"
    let viewModel = CurrentWeatherViewModel()
    
    private let currentWeatherInfoContainer: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weatherDescriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let maximalTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minimalTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - override inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
        self.backgroundColor = .clear
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    private func addSubview() {
        contentView.addSubview(currentWeatherInfoContainer)
        currentWeatherInfoContainer.contentView.addSubview(temperatureLabel)
        currentWeatherInfoContainer.contentView.addSubview(temperatureFeelsLikeLabel)
        currentWeatherInfoContainer.contentView.addSubview(maximalTemperatureLabel)
        currentWeatherInfoContainer.contentView.addSubview(minimalTemperatureLabel)
        currentWeatherInfoContainer.contentView.addSubview(windSpeedLabel)
        currentWeatherInfoContainer.contentView.addSubview(descriptionWeatherLabel)
        currentWeatherInfoContainer.contentView.addSubview(weatherDescriptionImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            currentWeatherInfoContainer.topAnchor.constraint(equalTo: self.topAnchor),
            currentWeatherInfoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currentWeatherInfoContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            currentWeatherInfoContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionImageView.topAnchor.constraint(equalTo: currentWeatherInfoContainer.topAnchor),
            weatherDescriptionImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherDescriptionImageView.heightAnchor.constraint(equalTo: currentWeatherInfoContainer.heightAnchor, multiplier: 1 / 3)
        ])
        
        NSLayoutConstraint.activate([
            descriptionWeatherLabel.topAnchor.constraint(equalTo: currentWeatherInfoContainer.topAnchor),
            descriptionWeatherLabel.leadingAnchor.constraint(equalTo: currentWeatherInfoContainer.leadingAnchor, constant: 5),
            descriptionWeatherLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 4),
            descriptionWeatherLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: currentWeatherInfoContainer.leadingAnchor, constant: 5),
            temperatureLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 6),
            temperatureLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            temperatureFeelsLikeLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            temperatureFeelsLikeLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10),
            temperatureFeelsLikeLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 6),
            temperatureFeelsLikeLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        
        NSLayoutConstraint.activate([
            minimalTemperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            minimalTemperatureLabel.leadingAnchor.constraint(equalTo: temperatureFeelsLikeLabel.trailingAnchor, constant: 10),
            minimalTemperatureLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 6),
            minimalTemperatureLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            maximalTemperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            maximalTemperatureLabel.leadingAnchor.constraint(equalTo: minimalTemperatureLabel.trailingAnchor, constant: 10),
            maximalTemperatureLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 6),
            maximalTemperatureLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            windSpeedLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 10),
            windSpeedLabel.leadingAnchor.constraint(equalTo: maximalTemperatureLabel.trailingAnchor, constant: 10),
            windSpeedLabel.widthAnchor.constraint(equalTo: currentWeatherInfoContainer.widthAnchor, multiplier: 1 / 6),
            windSpeedLabel.bottomAnchor.constraint(equalTo: currentWeatherInfoContainer.bottomAnchor, constant: -5)
        ])
    }
    
    private func bind() {
        viewModel.temperature.bind { [weak self] temperature in
            guard let temperature = temperature else { return }
            self?.temperatureLabel.text = """
                                    Temp:
                                    \(temperature)°C
                                    """
        }
        
        viewModel.temperatureFeelsLike.bind { [ weak self] feelsLikeTemperature in
            guard let feelsLikeTemperature = feelsLikeTemperature else { return }
            self?.temperatureFeelsLikeLabel.text = """
                                             FL:
                                             \(feelsLikeTemperature)°C
                                             """
        }
        
        viewModel.minimalTemperature.bind { [weak self] minimalTemperature in
            guard let minimalTemperature = minimalTemperature else { return }
            
            self?.minimalTemperatureLabel.text = """
                                           Min:
                                           \(minimalTemperature)°C
                                           """
        }
        
        viewModel.maximalTemperature.bind { [weak self] maximalTemperature in
            guard let maximalTemperature = maximalTemperature else { return }
            
            self?.maximalTemperatureLabel.text = """
                                           Max:
                                           \(maximalTemperature)°C
                                           """
        }
        
        viewModel.windSpeed.bind { [weak self] windSpeed in
            guard let windSpeed = windSpeed else { return }
            
            self?.windSpeedLabel.text = """
                                  Wind:
                                  \(windSpeed) m/s
                                  """
        }
        
        viewModel.weatherDescription.bind { [weak self] weatherDescription in
            guard let weatherDescription = weatherDescription else { return }
            
            self?.descriptionWeatherLabel.text = weatherDescription
        }
        
        viewModel.weatherImageDescription.bind { [ weak self] weatherImageDescription in
            guard let weatherImageDescription = weatherImageDescription else { return }
            
            self?.weatherDescriptionImageView.image = weatherImageDescription
        }
    }
}
