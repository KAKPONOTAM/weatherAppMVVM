import UIKit
import Kingfisher

class DailyWeatherTableViewCell: UITableViewCell {
    let viewModel = DailyWeatherViewModel()
    
    private let dailyWeatherContainer: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.clipsToBounds = true
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
    
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let temperatureLabel: UILabel = {
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
    
    //MARK: - override inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        addSubview()
        setupConstraints()
        bind()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - methods
    private func addSubview() {
        contentView.addSubview(dailyWeatherContainer)
        dailyWeatherContainer.contentView.addSubview(weekdayLabel)
        dailyWeatherContainer.contentView.addSubview(weatherDescriptionImageView)
        dailyWeatherContainer.contentView.addSubview(maximalTemperatureLabel)
        dailyWeatherContainer.contentView.addSubview(minimalTemperatureLabel)
        dailyWeatherContainer.contentView.addSubview(temperatureLabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dailyWeatherContainer.topAnchor.constraint(equalTo: self.topAnchor),
            dailyWeatherContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dailyWeatherContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dailyWeatherContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weekdayLabel.topAnchor.constraint(equalTo: dailyWeatherContainer.topAnchor, constant: 5),
            weekdayLabel.leadingAnchor.constraint(equalTo: dailyWeatherContainer.leadingAnchor, constant: 10),
            weekdayLabel.bottomAnchor.constraint(equalTo: dailyWeatherContainer.bottomAnchor, constant: -5),
            weekdayLabel.widthAnchor.constraint(equalTo: dailyWeatherContainer.widthAnchor, multiplier: 1 / 6)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionImageView.topAnchor.constraint(equalTo: dailyWeatherContainer.topAnchor, constant: 5),
            weatherDescriptionImageView.leadingAnchor.constraint(equalTo: weekdayLabel.trailingAnchor, constant: 10),
            weatherDescriptionImageView.bottomAnchor.constraint(equalTo: dailyWeatherContainer.bottomAnchor, constant: -5),
            weatherDescriptionImageView.widthAnchor.constraint(equalTo: dailyWeatherContainer.widthAnchor, multiplier: 1 / 6)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: dailyWeatherContainer.topAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherDescriptionImageView.trailingAnchor, constant: 10),
            temperatureLabel.bottomAnchor.constraint(equalTo: dailyWeatherContainer.bottomAnchor, constant: -5),
            temperatureLabel.widthAnchor.constraint(equalTo: dailyWeatherContainer.widthAnchor, multiplier: 1 / 6)
        ])
        
        NSLayoutConstraint.activate([
            minimalTemperatureLabel.topAnchor.constraint(equalTo: dailyWeatherContainer.topAnchor, constant: 5),
            minimalTemperatureLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10),
            minimalTemperatureLabel.bottomAnchor.constraint(equalTo: dailyWeatherContainer.bottomAnchor, constant: -5),
            minimalTemperatureLabel.widthAnchor.constraint(equalTo: dailyWeatherContainer.widthAnchor, multiplier: 1 / 6)
        ])
        
        NSLayoutConstraint.activate([
            maximalTemperatureLabel.topAnchor.constraint(equalTo: dailyWeatherContainer.topAnchor, constant: 5),
            maximalTemperatureLabel.leadingAnchor.constraint(equalTo: minimalTemperatureLabel.trailingAnchor, constant: 10),
            maximalTemperatureLabel.bottomAnchor.constraint(equalTo: dailyWeatherContainer.bottomAnchor, constant: -5),
            maximalTemperatureLabel.widthAnchor.constraint(equalTo: dailyWeatherContainer.widthAnchor, multiplier: 1 / 6)
        ])
    }
    
    private func bind() {
        viewModel.weekDay.bind { [weak self] weekDay in
            guard let weekDay = weekDay else { return }
            self?.weekdayLabel.text = weekDay
        }
        
        viewModel.maximalTemperature.bind { [weak self] maximalTemperature in
            guard let maximalTemperature = maximalTemperature else { return }
            
            self?.maximalTemperatureLabel.text = """
                                    Max:
                                    \(Int(maximalTemperature))°C
                                    """
        }
        
        viewModel.temperature.bind { [weak self] temperature in
            guard let temperature = temperature else { return }
            
            self?.temperatureLabel.text = """
                                    Temp:
                                    \(Int(temperature))°C
                                    """
        }
        
        viewModel.minimalTemperature.bind { [weak self] minimalTemperature in
            guard let minimalTemperature = minimalTemperature else { return }
            
            self?.minimalTemperatureLabel.text = """
                                           Min:
                                           \(Int(minimalTemperature))°C
                                           """
        }
        
        viewModel.weatherImageDescription.bind { [weak self] weatherImageDescription in
            guard let weatherImageDescription = weatherImageDescription else { return }
            self?.weatherDescriptionImageView.image = weatherImageDescription
        }
    }
}
