//
//  HomeViewModel.swift
//  DemoTanvirMVVM
//
//  Created by Tanvir Alam on 26/4/22.
//

import Foundation

class HomeViewModel:ObservableObject{
    @Published var users = [UserModel]()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    init(){
        Task{
            await fetchUsersAsync()
        }
        //fetchUsers()
    }
    
    //New Way of fetching data
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
    
    //Old Way of fetching data
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

extension HomeViewModel{
    convenience init(forPreview:Bool = false) {
        self.init()
        if forPreview{
            self.users = UserModel.mockUsers
        }
    }
}

