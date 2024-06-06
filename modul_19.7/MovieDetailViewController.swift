//
//  MovieDetailViewController.swift
//  modul_19.7
//
//  Created by Admin on 27/05/24.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    //var movie: Movie?
    
    lazy var posterURL: UIImageView = {
        let image = UIImageView()
        //image.clipsToBounds = true
        return image
    }()
    
    
    lazy var titleRU: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var titleEN: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 5
        //label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    lazy var ratingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    

    lazy var ratingVoteCountServer: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    lazy var type: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var showMoreLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTaped), for: .touchUpInside)
        button.layer.cornerRadius = 7
        return button
    }()
    
    @objc private func closeButtonTaped()  {
        dismiss(animated: true, completion: nil)
    }
    
    private var isExpanded = false
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configure()
        setupShowMoreLabel()
    }
    
    let movies: Movie
    
    init(_ movies: Movie) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        posterURL.translatesAutoresizingMaskIntoConstraints = false
        titleRU.translatesAutoresizingMaskIntoConstraints = false
        titleEN.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingVoteCountServer.translatesAutoresizingMaskIntoConstraints = false
        

        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
        scrollView.addSubview(contentView)

        
        contentView.addSubview(posterURL)
        contentView.addSubview(titleRU)
        contentView.addSubview(titleEN)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingsLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(ratingVoteCountServer)
        contentView.addSubview(type)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        posterURL.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(20)
            make.width.equalTo(130)
            make.height.equalTo(180)
        }
        
        
        ratingsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(posterURL.snp.trailing).offset(20)
            make.width.equalTo(100)
        }
        
        ratingVoteCountServer.snp.makeConstraints { make in
            make.top.equalTo(ratingsLabel.snp.bottom).offset(15)
            make.leading.equalTo(posterURL.snp.trailing).offset(20)
            make.width.equalTo(100)
        }
        
        type.snp.makeConstraints { make in
            make.top.equalTo(ratingVoteCountServer.snp.bottom).offset(15)
            make.leading.equalTo(posterURL.snp.trailing).offset(20)
            make.width.equalTo(100)
        }
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(ratingsLabel.snp.trailing).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        titleRU.snp.makeConstraints { make in
            make.top.equalTo(posterURL.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(380)
        }
        
        titleEN.snp.makeConstraints { make in
            make.top.equalTo(titleRU.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(380)
        }
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleEN.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.width.equalTo(360)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(40)
            make.leading.equalTo(20)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
    


    }
    

    private func setupShowMoreLabel() {
        view.addSubview(showMoreLabel)
        showMoreLabel.text = "Показать больше"
        showMoreLabel.textColor = .blue
        showMoreLabel.isUserInteractionEnabled = true
        showMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        showMoreLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(2)
            make.leading.equalTo(20)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureTaped))
        showMoreLabel.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func tapGestureTaped() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 5
        showMoreLabel.text = isExpanded ? "Показать меньше" : "Показать больше"
    }
    
    private func configure() {
        //guard let movie = movie else { return }
        
        if let imageUrl = movies.profileImageUrl {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.posterURL.image = UIImage(data: data)
                }
            }.resume()
        } else {
            self.posterURL.image = UIImage(systemName: "photo")
        }
        
        ratingsLabel.text = "KinoPoisk:  \(movies.rating ?? "0")"
        
        ratingVoteCountServer.text = "VoteCount: \(movies.ratingVoteCount ?? 0)"
        
        titleRU.text = movies.nameRu
        
        titleEN.text = movies.nameEn
        
        descriptionLabel.text = movies.description
        
        yearLabel.text = "Год производства\n\(movies.year ?? "0")"
        
        durationLabel.text = "Продолжительность\n\(movies.filmLength ?? "0")"
        
        type.text = movies.type
    }
}
