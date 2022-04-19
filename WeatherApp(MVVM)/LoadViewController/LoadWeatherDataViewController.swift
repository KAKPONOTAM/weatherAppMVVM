import UIKit
import CoreLocation

class LoadWeatherDataViewController: UIViewController {
    //MARK: - properties
    private let viewModel = LoadViewModel()
    
    private let locationManager = CLLocationManager()
    
    private let greetingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "greetingImage")
        imageView.startAnimating()
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .white
        activityView.center = view.center
        activityView.hidesWhenStopped = true
        activityView.startAnimating()
        return activityView
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.checkGeoDataEnabled(locationManager: locationManager)
        addSubview()
        setupConstraints()
        viewModel.locationDisabledDescriptionAlertInitialization()
        setupLocationManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bind()
    }
    
    //MARK: - methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            greetingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            greetingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            greetingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func addSubview() {
        view.addSubview(greetingImageView)
        view.addSubview(activityIndicator)
    }
    
    private func bind() {
        viewModel.locationDisabledDescriptionAlert.bind { [weak self] alert in
            guard let alert = alert,
                  let self = self else { return }
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.weatherViewController.bind { [weak self] weatherViewController in
            guard let weatherViewController = weatherViewController,
                  let self = self else { return }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                weatherViewController.modalPresentationStyle = .overFullScreen
                self.present(weatherViewController, animated: true, completion: nil)
            }
        }
    }
}

extension LoadWeatherDataViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        viewModel.checkAuthorizationStatus(locationManager: locationManager)
    }
}



