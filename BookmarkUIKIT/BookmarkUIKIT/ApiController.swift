////
////  ApiController.swift
////  BookmarkUIKIT
////
////  Created by Abylay Duzel on 12.05.2023.
////
//
//import UIKit
//
//class ApiController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    
//
//}
////
////  ViewController.swift
////  testApi
////
////  Created by Abylay Duzel on 11.05.2023.
////
//
//import UIKit
//import Alamofire
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        parseNameAndLinkFromApi{ nameAndLinksArray in}
//       
//    }
//    
//    func parseNameAndLinkFromApi(completion: @escaping ([nameAndLink]) -> Void? ){
//        var nameAndLinksArray = [nameAndLink]()
//        
//        let url = String(format: "https://api.nobelprize.org/2.1/laureates")
//        
//        guard let formatUrl = URL(string: url) else {return}
//        let request = URLRequest(url: formatUrl)
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            do{
//                if let error = error{
//                    print(error)
//                }
//                if let data = data{
//                    let jsonFile = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] // Serialize JSON
//                    if let laureates = jsonFile?["laureates"] as? [[String:Any]]{
//                        for laureat in laureates{
//                            
//                            let name = laureat["fullName"] as! [String:Any]
//                            let nameInEng = name["en"] as! String
//                            
//                            let wiki = laureat["wikipedia"] as! [String:Any]
//                            let wikipediaLink = wiki["english"] as! String
//                            
//                            nameAndLinksArray.append(nameAndLink(name: nameInEng, link: wikipediaLink))
//                            
//                        }
//                        completion(nameAndLinksArray)
//                        
//                    }
//                   
//                    //nameAndLinksArray.append(nameAndLink(name: "something", link: "someLink"))
//                }
//
//            }
//            catch {
//                print(error)
//            }
//            
//        }.resume()
//        
//        
//                
//    }
//
//
//}
//struct nameAndLink:Decodable{
//        var name: String?
//        var link:String?
//}
