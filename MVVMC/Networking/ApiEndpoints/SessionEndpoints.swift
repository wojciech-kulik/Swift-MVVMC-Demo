import Foundation

enum SessionEndpoints {
    
    class SignIn: BaseApiRequest<SignInResponse> {
        init(credentials: Credentials) {
            super.init(resource: "login",
                       method: .post,
                       json: SignInRequest(username: credentials.username, password: credentials.password).toJson())
        }
    }
    
    class SignOut: BaseApiRequest<VoidResponse> {
        init() {
            super.init(resource: "logout",
                       method: .post)
        }
    }
    
    class FetchMe: BaseApiRequest<MeResponse> {
        init() {
            super.init(resource: "me")
        }
    }
}
