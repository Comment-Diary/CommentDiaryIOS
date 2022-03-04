//
//  OAuthAuthenticator.swift
//  CommentDiary
//
//  Created by 류창휘 on 2022/03/03.
//

//import Foundation
//import Alamofire
//
//class OAuthAuthenticator : Authenticator {
//
//     // 헤더에 인증 추가
//     func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
//             // 헤더에 Authrization 키로 Bearer 토큰값
////             urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
//         urlRequest.headers.add(name: "X-AUTH-TOKEN", value: credential.accessToken)
//         urlRequest.headers.add(name: "REFRESH-TOKEN", value: credential.refreshToken)
//
//             // 만약에 커스텀이면
// //            urlRequest.headers.add(name: "ACCESS_TOKEN", value: credential.accessToken)
//         }
//
//     // 토큰 리프레시
//     func refresh(_ credential: OAuthCredential,
//                  for session: Session,
//                  completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
//
//         print("OAuthAuthenticator - refresh() called")
//         // 여기서 토큰 재발행 api 태우면 됩니다.
//
//         let request = session.request(AuthRouter.tokenRefresh)
//
//         request.responseDecodable(of: TokenResponse.self){ result in
//             switch result.result {
//
//             case .success(let value):
//
//                 // 재발행 받은 토큰 저장
//                 UserDefaultManager.shared.setTokens(accessToken: value.result.accessToken, refreshToken: value.result.refreshToken)
//
//                 let expiration = Date(timeIntervalSinceNow: 30)
//
//                 // 새로운 크리덴셜
//                 let newCredential = OAuthCredential(accessToken: value.result.accessToken,
//                                                     refreshToken: value.result.refreshToken,
//                                                     expiration: expiration)
//                 completion(.success(newCredential))
//             case .failure(let error):
//                 completion(.failure(error))
//             }
//         }
//
//
//     }
//
//     // api 요청 완료
//     func didRequest(_ urlRequest: URLRequest,
//                     with response: HTTPURLResponse,
//                     failDueToAuthenticationError error: Error) -> Bool {
//
//         print("OAuthAuthenticator - didRequest() called")
//
//         // 401 코드가 떨어지면 리프레시 토큰으로 액세스 토큰을 재발행 하라고 요청
//         switch response.statusCode {
//             case 401: return true
//             default: return false
//         }
//
//     }
//
//     func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
//         // If authentication server CANNOT invalidate credentials, return `true`
//         return true
//
//         // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
//         // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
//         // let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
//         // return urlRequest.headers["Authorization"] == bearerToken
//     }
// }
