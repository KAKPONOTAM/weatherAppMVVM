import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {
    
    let viewModel = HourlyWeatherViewModel()
    
    private let hourWeatherInfoContainer: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: effect)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hourWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(hourWeatherInfoContainer)
        hourWeatherInfoContainer.contentView.addSubview(hourWeatherCollectionView)
        setupConstraints()
        bind()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - methods
    private func bind() {
        viewModel.hourlyWeatherData.bind { [weak self] _ in
            self?.hourWeatherCollectionView.reloadData()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            hourWeatherInfoContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourWeatherInfoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourWeatherInfoContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourWeatherInfoContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hourWeatherCollectionView.topAnchor.constraint(equalTo: hourWeatherInfoContainer.topAnchor),
            hourWeatherCollectionView.leadingAnchor.constraint(equalTo: hourWeatherInfoContainer.leadingAnchor),
            hourWeatherCollectionView.trailingAnchor.constraint(equalTo: hourWeatherInfoContainer.trailingAnchor),
            hourWeatherCollectionView.bottomAnchor.constraint(equalTo: hourWeatherInfoContainer.bottomAnchor)
        ])
    }
}

extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.hourlyWeatherData.value?.hourly?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
        
        guard let hourlyWeatherData = viewModel.hourlyWeatherData.value else { return UICollectionViewCell() }
        
        cell.viewModel.configureHourlyWeatherData(hourlyData: hourlyWeatherData, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (hourWeatherInfoContainer.frame.width / 3) - 5
        let height = hourWeatherInfoContainer.frame.height - 10
        
        return CGSize(width: width, height: height)
    }
}
