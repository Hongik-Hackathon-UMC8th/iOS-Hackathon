import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    // MARK: 아이디 & 비밀번호
    
    /// Keychain에 사용자의 비밀번호를 저장합니다.
        /// 이미 동일한 계정과 서비스 조합의 항목이 존재하는 경우, 기존 항목을 삭제하고 새로 저장합니다.
        /// - Parameters:
        ///   - account: 저장할 비밀번호와 연결된 사용자 계정 (예: 이메일 주소)
        ///   - service: 비밀번호가 사용되는 서비스 이름 (예: "com.example.myapp.login")
        ///   - password: Keychain에 저장할 실제 비밀번호 문자열
        /// - Returns: 저장 작업의 결과 상태 코드 (예: `errSecSuccess`면 성공)
        @discardableResult
        func savePasswordToKeychain(account: String, service: String, password: String) -> OSStatus {
            // 1. 저장할 데이터를 Data 타입으로 변환
            guard let passwordData = password.data(using: .utf8) else {
                return errSecParam // 잘못된 데이터
            }

            // 2. Keychain Item 딕셔너리 구성
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,  // 저장 유형: 일반 비밀번호
                kSecAttrAccount as String: account,             // 계정 식별자
                kSecAttrService as String: service,             // 서비스 이름
                kSecValueData as String: passwordData,          // 실제 저장할 데이터
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked // 접근 가능 조건
            ]

            // 3. 이미 같은 항목이 있다면 삭제 (중복 방지)
            SecItemDelete(query as CFDictionary)

            // 4. 새 항목 추가
            let status = SecItemAdd(query as CFDictionary, nil)
            return status
        }

        /// Keychain에서 저장된 데이터를 불러옵니다.
        /// - Parameters:
        ///   - account: 계정 식별자 (예: 이메일 주소)
        ///   - service: 서비스 이름 (예: "com.myapp.login")
        /// - Returns: 저장된 문자열 데이터 (ex: 비밀번호, 토큰 등) 또는 nil
        @discardableResult
        func load(account: String, service: String) -> String? {
            // 1. 검색 쿼리 구성
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,   // 일반 비밀번호 클래스
                kSecAttrAccount as String: account,              // 계정
                kSecAttrService as String: service,              // 서비스
                kSecReturnData as String: true,                  // 데이터를 반환하도록 요청
                kSecMatchLimit as String: kSecMatchLimitOne      // 하나만 반환
            ]

            // 2. 검색 결과 저장 변수
            var item: CFTypeRef?

            // 3. Keychain에서 항목 검색
            let status = SecItemCopyMatching(query as CFDictionary, &item)

            // 4. 상태 확인 및 결과 처리
            guard status == errSecSuccess else {
                print("Keychain load 실패 - status: \(status)")
                return nil
            }

            // 5. Data → String 변환
            guard let data = item as? Data,
                  let result = String(data: data, encoding: .utf8) else {
                print("Keychain load 실패 - 데이터 디코딩 실패")
                return nil
            }

            return result
        }
        
        /// Keychain에서 지정된 계정과 서비스에 해당하는 항목을 삭제합니다.
           /// - Parameters:
           ///   - account: 계정 식별자 (예: 사용자 이메일)
           ///   - service: 서비스 이름 (예: "com.example.myapp")
           /// - Returns: Keychain 삭제 작업의 상태 코드 (`errSecSuccess` 등)
           @discardableResult
           func delete(account: String, service: String) -> OSStatus {
               // 1. 삭제할 항목을 식별할 쿼리 구성
               let query: [String: Any] = [
                   kSecClass as String: kSecClassGenericPassword,   // 삭제 대상 유형
                   kSecAttrAccount as String: account,              // 계정 식별자
                   kSecAttrService as String: service               // 서비스 구분자
               ]

               // 2. 항목 삭제 시도
               let status = SecItemDelete(query as CFDictionary)

               // 3. 상태 확인 및 로그 출력
               if status == errSecSuccess {
                   print("Keychain 삭제 성공 - [\(service) : \(account)]")
               } else if status == errSecItemNotFound {
                   print("Keychain 항목 없음 - [\(service) : \(account)]")
               } else {
                   print("Keychain 삭제 실패 - status: \(status)")
               }

               return status
           }
    
    /// 과제를 위한...
    func getAllAccounts() -> [String] {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let items = result as? [[String: Any]] else {
            print("Keychain 목록 불러오기 실패 - status: \(status)")
            return []
        }

        let accounts = items.compactMap { $0[kSecAttrAccount as String] as? String }
        return accounts
    }

    
    // MARK: Token
    private init() {}
    
    private let account = "authToken"
    private let service = "com.myKeychain.tokenInfo"
    
    @discardableResult
    private func saveTokenInfo(_ tokenInfo: TokenInfo) -> OSStatus {
        do {
            let data = try JSONEncoder().encode(tokenInfo)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
            ]
            
            SecItemDelete(query as CFDictionary)
            
            return SecItemAdd(query as CFDictionary, nil)
        } catch {
            print("JSON 인코딩 실패:", error)
            return errSecParam
        }
    }
    
    private func loadTokenInfo() -> TokenInfo? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data else {
            print("토큰 정보 불러오기 실패 - status:", status)
            return nil
        }
        
        do {
            return try JSONDecoder().decode(TokenInfo.self, from: data)
        } catch {
            print("❌ JSON 디코딩 실패:", error)
            return nil
        }
    }
    
    @discardableResult
    private func deleteTokenInfo() -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    public func saveToken(_ tokenInfo: TokenInfo) {
        let saveStatus = self.saveTokenInfo(tokenInfo)
        print(saveStatus == errSecSuccess ? "저장 성공" : "저장 실패")
    }
    
    public func loadToken() {
        if let loadedToken = self.loadTokenInfo() {
            print("accessToken:", loadedToken.accessToken)
            print("RefreshToken:", loadedToken.refreshToken)
        } else {
            print("토큰 정보 없음")
        }
    }
    
    public func deleteToken() {
        let deleteStatus = self.deleteTokenInfo()
        print(deleteStatus == errSecSuccess ? "삭제 성공" : "삭제 실패")
    }
}
