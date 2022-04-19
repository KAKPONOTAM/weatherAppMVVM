import UIKit
import Kingfisher

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyWeatherCollectionViewCell"
    
    let viewModel = HourlyWeatherCollectionViewModel()
    
     private let weatherDescriptionImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
     
     private let hourLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.textColor = .white
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     private let temperatureLabel: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.textColor = .white
         label.numberOfLines = 0
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     //MARK: - override init
     override init(frame: CGRect) {
         super.init(frame: frame)
         addSubview()
         setupConstraints()
         bind()
     }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     //MARK: - methods
    private func addSubview() {
        contentView.addSubview(weatherDescriptionImageView)
        contentView.addSubview(hourLabel)
        contentView.addSubview(temperatureLabel)
    }
    
     private func setupConstraints() {
         NSLayoutConstraint.activate([
             hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
             hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             hourLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 4),
             hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
         ])
         
         NSLayoutConstraint.activate([
             weatherDescriptionImageView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 5),
             weatherDescriptionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             weatherDescriptionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
             weatherDescriptionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3)
         ])
         
         NSLayoutConstraint.activate([
             temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionImageView.bottomAnchor, constant: 0),
             temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
             temperatureLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1 / 3),
             temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
         ])
     }
    
    private func bind() {
        viewModel.hourTemperature.bind { [weak self] temperatureValue in
            guard let temperatureValue = temperatureValue else { return }
            self?.temperatureLabel.text = "\(temperatureValue)°C"
        }
        
        viewModel.weatherHour.bind { [weak self] correctHour in
            guard let hour = correctHour else { return }
            self?.hourLabel.text = hour
        }
        
        viewModel.weatherImageDescription.bind { [weak self] savedImage in
            guard let savedImage = savedImage else { return }
            self?.weatherDescriptionImageView.image = savedImage
        }
    }
}
