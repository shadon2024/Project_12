//
//  MovieTableViewCell.swift
//  modul_19.7
//
//  Created by Admin on 24/05/24.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let filmId = UILabel()
    let title = UILabel()
    let posterUrl = UIImageView()
    
    func setupViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        posterUrl.translatesAutoresizingMaskIntoConstraints = false
        posterUrl.contentMode = .scaleAspectFit
        title.numberOfLines = 0
        
        contentView.addSubview(title)
        contentView.addSubview(posterUrl)
        self.addSubview(title)
        self.addSubview(posterUrl)
        
        
        
        posterUrl.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(posterUrl.snp.trailing).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(200)
        }

    }
    
    
    
    
    
    func configure(with movie: Movie) {
        title.text = movie.title
        
        if let url = URL(string: movie.posterURL ?? "nil") {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.posterUrl.image = UIImage(data: data)
                            }
                        }
                    }
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.posterUrl.image = UIImage(data: data)
                            }
                        }
                    }
        }
        
    }
    
    
}
