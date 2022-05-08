//
//  PostListViewModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation
import Combine

class PostListViewModel:ObservableObject{
    @Published var posts = [PostModel]()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage =  ""
    
    var cancellables = Set<AnyCancellable>()
    
    let service:PostsGetable
    
    // MARK: - With Combine and Dependency Injection for Testing. Protocol Oriented Way, Check Unit Testing Files
    init(service:PostsGetable = PostsService(networkRequest: APIServiceCombine(), environment:.development )){
        self.service = service
        getPostsByCombineAndServiceProtocol()
    }
    
    func getPostsByCombineAndServiceProtocol(){
        service.getPosts()
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("debug: well done Posts")
                case .failure(let failMessage):
                    self?.showAlert = true
                    self?.errorMessage = "\(failMessage.localizedDescription)"
                }
                
                print("debug: Something is wrong while fetchin Users, Contact to developer, \(completion)")
            } receiveValue: { [weak self] users in
                self?.posts = users
            }
            .store(in: &cancellables)
    }
    
    // Async Await
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
    
    // Old way, completion handler
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
    
    var userID : Int? {
        didSet{
            Task{
                await fetchPostsAsync()
            }
            //fetchPosts()
        }
    }
}

// for preview
extension PostListViewModel{
    convenience init(forPreview:Bool = false) {
        self.init(service:PostsService(networkRequest: APIServiceCombine(), environment:.development))
        if forPreview{
            self.posts = PostModel.mockPosts
        }
    }
}
