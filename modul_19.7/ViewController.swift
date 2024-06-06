//
//  ViewController.swift
//  modul_19.7
//
//  Created by Admin on 23/05/24.
//

import SnapKit
import UIKit
import Alamofire




class ViewController: UIViewController {
    

    
    private let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
    private var movies: [Movie] = []
    private var popularMovies: [MoviePoular] = []
    private let refrechControl = UIRefreshControl() // update tableView
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "тут пользовательский текст"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let urlSessionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Поиск", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(urlSesionButtonTaped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    let alomafireButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Популярные фильмы", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(alomafireButtonTaped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .systemGray6
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 8.0
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        return textView
    }()
    
    
    let resultTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let  activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .red
        return activityIndicator
    }()
    
    let horizontalLine: UIView = {
        let horizontalLine  = UIView()
        horizontalLine.backgroundColor = .black
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLine
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.tintColor = .red
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
        setupRefrech()
    }
    
    
    private func setupRefrech() {
        refrechControl.addTarget(self, action: #selector(refrech), for: .valueChanged)
        tableView.refreshControl = refrechControl
    }
    
    @objc func refrech() {
        DispatchQueue.main.async {
            self.refrechControl.endRefreshing()
        }
    }
    
    
    func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(urlSessionButton)
        view.addSubview(alomafireButton)
        view.addSubview(resultTextLabel)
        view.addSubview(activityIndicator)
        self.view.addSubview(horizontalLine)
        view.addSubview(tableView)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        urlSessionButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        alomafireButton.snp.makeConstraints { make in
            make.top.equalTo(urlSessionButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        resultTextLabel.snp.makeConstraints { make in
            make.top.equalTo(alomafireButton.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.top.equalTo(alomafireButton.snp.bottom).offset(85)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(horizontalLine).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(alomafireButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    
    @objc func urlSesionButtonTaped() {
        guard let query = searchTextField.text, !query.isEmpty else { return }
        fetchMoviesSearch(keyword: query)
    }
    
    
    func fetchMoviesSearch(keyword: String) {
        
        guard let movieId = searchTextField.text, !movieId.isEmpty else {
            print("Movie is empty")
            return
        }

        guard let movieId1 = movieId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid movie ID encoding")
            return
        }
        
        let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(movieId1)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        activityIndicator.startAnimating()
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            guard let self = self else { return }
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.movies = movieResponse.films
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.resultTextLabel.text = "Поиск по запросу: \(self.searchTextField.text ?? "search is not find") "
                    self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
    
    
    
    
    
    
    @objc func alomafireButtonTaped() {

        fetchMovies(type: "TOP_250_BEST_FILMS")
        
    }
    
    func fetchMovies(type: String) {
            let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
            let urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=\(type)"
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
            activityIndicator.startAnimating()
        
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                
                guard let self = self else { return }
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data")
                    return
                }
                
                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    self.movies = movieResponse.films
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.resultTextLabel.text = "Популярные филмы"
                        self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            
            task.resume()
        }
    
 

    

    

    
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.title.text = movie.nameEn
        
        if let imageUrl = movie.profileImageUrl {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.posterUrl.image = UIImage(data: data)
                }
            }.resume()
        } else {
            cell.posterUrl.image = UIImage(systemName: "photo")
        }
        
        cell.configure(with: movie)
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(movie)
        present(detailVC, animated: true)
    }
    
    
}






/*
 
 import SnapKit
 import UIKit
 import Alamofire




 class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     

     
     let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
     var movies: [Movie] = []
     
     let searchTextField: UITextField = {
         let textField = UITextField()
         textField.placeholder = "тут пользовательский текст"
         textField.borderStyle = .roundedRect
         textField.layer.borderWidth = 1.0
         textField.layer.borderColor = UIColor.black.cgColor
         textField.layer.cornerRadius = 5
         return textField
     }()
     
     let urlSessionButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("Поиск", for: .normal)
         button.backgroundColor = .systemBlue
         button.addTarget(nil, action: #selector(urlSesionButtonTaped), for: .touchUpInside)
         button.layer.cornerRadius = 6
         return button
     }()
     
     
     let alomafireButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("Популярные фильмы", for: .normal)
         button.backgroundColor = .systemBlue
         button.addTarget(nil, action: #selector(alomafireButtonTaped), for: .touchUpInside)
         button.layer.cornerRadius = 6
         
         return button
     }()
     
     let resultTextView: UITextView = {
         let textView = UITextView()
         textView.isEditable = false
         textView.isScrollEnabled = true
         textView.backgroundColor = .systemGray6
         textView.layer.borderWidth = 1.0
         textView.layer.borderColor = UIColor.black.cgColor
         textView.layer.cornerRadius = 8.0
         textView.font = .systemFont(ofSize: 14, weight: .medium)
         return textView
     }()
     
     
     let resultTextLabel: UILabel = {
         let label = UILabel()
         label.text = ""
         label.textColor = UIColor.black
         label.font = .systemFont(ofSize: 14)
         return label
     }()
     
     let  activityIndicator: UIActivityIndicatorView = {
         let activityIndicator = UIActivityIndicatorView()
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.style = .large
         activityIndicator.color = .red
         return activityIndicator
     }()
     
     let horizontalLine: UIView = {
         let horizontalLine  = UIView()
         horizontalLine.backgroundColor = .black
         horizontalLine.translatesAutoresizingMaskIntoConstraints = false
         return horizontalLine
     }()
     
     let tableView: UITableView = {
         let table = UITableView()
         table.tintColor = .red
         return table
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
         tableView.translatesAutoresizingMaskIntoConstraints = false
         setupUI()
     }
     
     
     
     func setupUI() {
         view.addSubview(searchTextField)
         view.addSubview(urlSessionButton)
         view.addSubview(alomafireButton)
         view.addSubview(resultTextView)
         view.addSubview(resultTextLabel)
         view.addSubview(activityIndicator)
         self.view.addSubview(horizontalLine)
         view.addSubview(tableView)
         
         searchTextField.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
             make.leading.equalToSuperview().offset(20)
             make.trailing.equalToSuperview().offset(-20)
             make.height.equalTo(40)
         }
         
         urlSessionButton.snp.makeConstraints { make in
             make.top.equalTo(searchTextField.snp.bottom).offset(20)
             make.centerX.equalToSuperview()
             make.height.equalTo(40)
             make.width.equalTo(100)
         }
         
         alomafireButton.snp.makeConstraints { make in
             make.top.equalTo(urlSessionButton.snp.bottom).offset(20)
             make.centerX.equalToSuperview()
             make.height.equalTo(40)
             make.width.equalTo(200)
         }
         
         resultTextLabel.snp.makeConstraints { make in
             make.top.equalTo(alomafireButton.snp.bottom).offset(60)
             make.leading.equalToSuperview().offset(20)
         }
         
         horizontalLine.snp.makeConstraints { make in
             make.top.equalTo(alomafireButton.snp.bottom).offset(85)
             make.height.equalTo(1)
             make.leading.equalToSuperview().offset(20)
             make.trailing.equalToSuperview().offset(-20)
         }
         
         
         tableView.snp.makeConstraints { make in
             make.top.equalTo(horizontalLine).offset(10)
             make.leading.equalToSuperview().offset(20)
             make.trailing.equalToSuperview().offset(-20)
             make.height.equalTo(300)
         }
         
         resultTextView.snp.makeConstraints{ make in
             make.top.equalTo(alomafireButton.snp.bottom).offset(450)
             make.leading.equalToSuperview().offset(20)
             make.trailing.equalToSuperview().offset(-20)
             make.height.equalTo(100)
         }
         
         activityIndicator.snp.makeConstraints { make in
             make.top.equalTo(alomafireButton.snp.bottom).offset(20)
             make.centerX.equalToSuperview()
         }
     }
     
     
     @objc func urlSesionButtonTaped() {

         view.endEditing(true) // Скрытие клавиатуры

         guard let movieId = searchTextField.text, !movieId.isEmpty else {
             print("Movie is empty")
             return
         }

         guard let movieId1 = movieId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
             print("Invalid movie ID encoding")
             return
         }
         let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(movieId1)"
         //let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/\(movieId1)"

         guard let url = URL(string: urlString) else {
             print("Invalid URL")
             return
         }


         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")

         activityIndicator.startAnimating() // Запуск индикатора загрузки

         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating() // Остановка индикатора загрузки
             }
             if let error = error {
                 print("Error: \(error.localizedDescription)")
                 return
             }

             guard let data = data else {
                 print("No data returned")
                 return
             }

 //            if let jsonString = String(data: data, encoding: .utf8) {
 //                DispatchQueue.main.async {
 //                    self.resultTextView.text = jsonString
 //                }
 //
 //                DispatchQueue.main.async {
 //                    self.resultTextLabel.text = "Поиск по запросу: \(self.searchTextField.text ?? "search is not find") "
 //                    self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
 //                }
 //            }

             do {

                 let movieInfo = try JSONDecoder().decode(Movie.self, from: data)
                 let movie = Movie(filmID: movieInfo.filmID, nameRu: movieInfo.nameRu, nameEn: movieInfo.nameEn, type: movieInfo.type, year: movieInfo.year, description: movieInfo.description, filmLength: movieInfo.filmLength, rating: movieInfo.rating, ratingVoteCount: movieInfo.ratingVoteCount, posterURL: movieInfo.profileImageUrl?.absoluteString, posterURLPreview: movieInfo.posterURLPreview)
                 DispatchQueue.main.async {
                     self.movies = [movie]
                     //self.movies.append(movie)
                     self.tableView.reloadData()

                     //self.resultTextLabel.text = "Поиск по запросу: \(self.searchTextField.text ?? "search is not find") "
                     //self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                 }
             } catch {
                 print("Error decoding data: \(error.localizedDescription)")
                 print(String(data: data, encoding: .utf8) ?? "No data")

                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                     self.resultTextLabel.text = "Поиск по запросу: \(self.searchTextField.text ?? "search is not find") "
                     self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                 }
             }

         }
         task.resume()
         //ApiManager.shared.getFilm()

     }
     
     
     @objc func alomafireButtonTaped() {

         view.endEditing(true) // Скрытие клавиатуры

         guard let movieId = searchTextField.text, !movieId.isEmpty else {
                     print("Movie ID is empty")
                     return
                 }

         guard let movieId1 = movieId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
             print("Invalid movie ID encoding")
             return
         }
                 let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(movieId1)"
         // "https://kinopoiskapiunofficial.tech/api_key=8444fa56-7af6-40e6-b27f-fdbcbab43f60 &language=en-US&page=1"

                 let headers: HTTPHeaders = [
                     "X-API-KEY": apiKey
                 ]

         activityIndicator.startAnimating() // Запуск индикатора загрузки

                 AF.request(urlString, headers: headers).response { response in
                     DispatchQueue.main.async {
                         self.activityIndicator.stopAnimating() // Остановка индикатора загрузки
                     }

                     if let error = response.error {
                         print("Error: \(error.localizedDescription)")
                         return
                     }

                     guard let data = response.data else {
                         print("No data returned")
                         return
                     }

                     if let jsonString = String(data: data, encoding: .utf8) {
                         DispatchQueue.main.async {
                             self.resultTextView.text = jsonString
                         }

                         DispatchQueue.main.async {
                             self.resultTextLabel.text = "Популярные фильмы"
                             self.resultTextLabel.font = .systemFont(ofSize: 18, weight: .semibold)
                         }
                     }
                 }
         
     }
     
  
     
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return movies.count
         //return 10
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
         let movie = movies[indexPath.row]
         cell.textLabel?.numberOfLines = 0
         cell.textLabel?.text = movie.nameEn
         //cell.textLabel?.text = "hello"
         //cell.imageView?.image = movie.posterUrl
         cell.configure(with: movie)
         return cell
     }
     
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         let movie = movies[indexPath.row]
         let detailVC = MovieDetailViewController()
         detailVC.movie = movie
         navigationController?.pushViewController(detailVC, animated: true)
     }
     
 }
 
 */
