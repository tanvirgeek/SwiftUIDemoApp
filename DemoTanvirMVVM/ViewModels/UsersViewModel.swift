//
//  HomeViewModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation
import Combine

class UsersViewModel:ObservableObject{
    @Published var users = [UserModel]()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    var cancellables = Set<AnyCancellable>()
    
    let service:UsersGetable
    
    //Dependency injection for testing purpose
    init(service:UsersGetable = UserService(networkRequest: APIServiceCombine(), environment:.development )){
        
        // MARK: - With Combine and Dependency Injection for Testing , Check Unit Testing Files
        self.service = service
        getUserByCombineAndServiceProtocol()
        
        // MARK: - Without Combine
//        Task{
//            await fetchUsersAsync()
//        }
        
//        fetchUsers()
//        fetchUsersByCombine()
    }
    
    // Fetching Users by combine datataskpublisher, Protocol Oriented Way with a service layer, for testing purpose
    func getUserByCombineAndServiceProtocol(){
        service.getUsers()
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("debug: well done users")
                case .failure(let failMessage):
                    self?.showAlert = true
                    self?.errorMessage = "\(failMessage.localizedDescription)"
                }
                
                print("debug: Something is wrong while fetchin Users, Contact to developer, \(completion)")
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
    
    //Fetching Data by Combine
    func fetchUsersByCombine(){
        isLoading = true
        defer{
            isLoading = false
        }
        APIService.getRequestWithCombine(ofUrl: EndPointSouce.getEndPoint(type: .users), as: [UserModel].self)
            .sink { [weak self] completion in
                switch completion{
                case .finished:
                    print("debug: well done users")
                case .failure(let failMessage):
                    self?.showAlert = true
                    self?.errorMessage = "\(failMessage.localizedDescription)"
                }
                
                print("debug: Something is wrong while fetchin Users, Contact to developer, \(completion)")
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
        print("debug: Fetching Data by combine")

    }
    
    //Async Await
    @MainActor
    func fetchUsersAsync() async{
        isLoading = true
        defer{
            isLoading = false
        }
    
        do{
            users = try await APIService.getRequestAsync(url: EndPointSouce.getEndPoint(type: .users))
        }catch{
            showAlert = true
            errorMessage =  error.localizedDescription + ". \n Please contact the developer and show him the error."
        }
    }
    
    //Old Way of fetching data completion handler
    func fetchUsers(){
        isLoading = true
        print("debug: fetching users")
        APIService.getRequest(urlString: EndPointSouce.getEndPoint(type: .users)) { (completion: Result<[UserModel], NetworkingError>) in
            
            defer {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            
            switch completion {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                    print("debug: ", error.localizedDescription)
                }
            }
        }
    }
}


// for preview
extension UsersViewModel{
    convenience init(forPreview:Bool = false) {
        self.init(service: UserService(networkRequest: APIServiceCombine(), environment:.development ))
        if forPreview{
            self.users = UserModel.mockUsers
        }
    }
}


