//
//  PostListViewModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation

class PostListViewModel:ObservableObject{
    @Published var posts = [PostModel]()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage =  ""
    
    init(){
        
    }
    
    var userID : Int? {
        didSet{
            Task{
                await fetchPostsAsync()
            }
            //fetchPosts()
        }
    }
    
    @MainActor
    func fetchPostsAsync() async{
        isLoading = true
        defer{
            isLoading = false
        }
    
        do{
            posts = try await APIService.getRequestAsync(url: EndPointSouce.getEndPoint(type: .usersPosts(userId: userID ?? 1)))
        }catch{
            showAlert = true
            errorMessage =  error.localizedDescription + ". \n Please contact the developer and show him the error."
        }
    }
    
    func fetchPosts(){
        isLoading = true
        APIService.getRequest(urlString: EndPointSouce.getEndPoint(type: .usersPosts(userId: userID ?? 1))) { (result: Result<[PostModel],NetworkingError>) in
            
            defer{
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                print("Debug: ",error)
            }
        }
    }
}

extension PostListViewModel{
    convenience init(forPreview:Bool = false) {
        self.init()
        if forPreview{
            self.posts = PostModel.mockPosts
        }
    }
}
