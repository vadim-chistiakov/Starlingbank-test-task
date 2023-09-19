//
//  NetworkLayer.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

enum Consts {
    static let bearer = "Bearer eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty3LbMAz8lY7OQcaSKflx660_0A8AATDmRCI1JOU00-m_lzJlK_Lkpt0FFgAB_a1sjNW5wtECy-BfY8LQW_em0b2_kh-qlypOOkfUjSFERXA41B2oI2rQqmlANTvRpjOmbU0Olj9jda67U1vvj6dD91JZTIXYtU07E0jkJ5d--Z4l_La8ePOeFTSmJlDYaTipmuFIzbFlxa1u6-yd_Lu4NYOOuoH9Sdeg9rsOtFEMOy2K9t2R64ZzRh7rJ5HEuGYdas1Q66YFdUIDujvlsgdWLVFrVKvngcmPMj9K6RQut1bB4SDnIMg_noT0OT4JlsUla6yELd_bmDbMAphDbvIsbNMDFCUlpMsgj8gpXXywMW8IrGN7tTxhXzSNPTpaOiEMDORdCr4vvjOzaN4ZGwZM1jvwBszkeKlHU0x-uLctA9ole0DHmOTM0kuSB7yFDZIwIzxThrN4x7fMET9F7lIBi0kBaxDYAd8Wz6Ktn5ACuog09_ygofeUp1-9CwF-foZndskK3tj-XqrU3lC3qCAkdkwbELfSR7DZPeI1ryLCm1_72HDLqBvu5vOVKcOZ_OzfWKziN16rWEzpIjz1wpDHXq8mSkp5wGlc4Ij3M8m_e76ifEw-8JfyW_Zed8t-kw_-wz34JHMDQPH6TI1sCvV1p7dVPC-5-vcfaAUqTKEEAAA.e1LyKoDkbL2R4WgjHjyYdqwKYQUzZpAmKcYv5ugeqtzMeB8E0d6TKpf4k5sldIPzLXQ0B3i8XCov6fI5oKTBCaPUOA74b8zyyyxO8xdd4y5B1mJCnpv9-p8z_lgE2Mo-WLTH4qCaXRj3IgfIrrrJ33bm6Fjzp9GSMvq4QkWvG1rHdEmM7Qf48VR7xtoG4eoLQjyI3ihE_cWwv65Mw7-DhGqn-6OLRbzbBcdum-HiVmMs0NrmrGcbzFku42ne1PFAOyn3KNUTpD5aS8EoiKtciY__q5TF_Gkt_994Xbmq8KF5oqvRV-QMzQc6RPccFWw13q8tL4jM05u9J0zGjKXYuIa4oZzS0tBelnJrtfSHmxMGj8000MIZJCtdHlFdSPgBjSvAFXv6Gai4PaT45FtbSvttzgD-oabb3jcSWlkECnV5eYxOS7am-CyV4BA_oaLzBTuYperKFq0yEpZckXmHd0TARf1pGVfLIgYCCV3SKJpfmTTwGVEITviEaqyf2DFwOz1IgLag45oDmZ6L3nlpAS5mNvRIqqiTyyzld0kLaFOeEXOuzUTnWeA9UKg1h6SZS9T_eC-1Lpb5zN7B38t28-kETyNMyDuKG3kXJjsIPH3Ut-3QGTn0viYIK0zJ280hTFxynm30M3ukSV7BIOkNf9In9ZmcgKWnOZfFERd3lWc"
}

typealias Header = [String: String]
typealias Body = [String: String]

protocol Endpoint {
    var method: RequestMethod { get }
    var header: Header? { get }
    var scheme: Scheme { get }
    var host: String { get }
    var path: String { get }
    var body: Body? { get }
    var params: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: Scheme {
        .https
    }
    
    var header: Header? {
        [
            "Authorization": Consts.bearer,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var host: String {
        "api-sandbox.starlingbank.com"
    }
    
}
