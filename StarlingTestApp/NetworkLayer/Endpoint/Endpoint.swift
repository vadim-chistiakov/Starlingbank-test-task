//
//  Endpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

enum Consts {
    static let bearer = "Bearer eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty47bMAz8lcLn5SJ25Ed8660_0A-gRCoR1pYMSc52UfTfK0dOHAd788yQQ1Kk_xYmhKIvcDJAPLr3ENEPxp4l2o935cbirQizTBFlpRWiUNC2ZQOiQwlSVBWI6sBSN1rXtU7B_Gcq-rI51VXVdifxVhiMmShFKRYClXKzjb_cQOx_G1q96UgCKl0qENhIOImSoFNVV5OgWtZl8o7ug-2a0ammOx5a6Jq2A6HbBrqDPIA-NtR0JOlQHVNGGuunUhzCVqctJUEpqxrECTXI5pTKtiRqpWotarkMrNzEy6PkTuFyaxUsjtx7RvrxIsSv6UUwxDYabdjv-cGEuGNWQORTkz2TiQ-QlRhRXUZ-RM7x4rwJaUNgLJmroRmHrEkc0Kq1E4WeQDkbvRuy78KsmrPa-BGjcRacBj1bWuupOUQ33tvmEc2aPaIljNwTDxz5AW9hI0dMCHuV4CLe8S1zwi_mu5TBapLBFgRmxPPqmbXtE6JHG1AtPT9oGJxK02_emQC3PMMru2Z5p81wL5Vr76hblGfFZoo7EPbSpzfJPeA1rSLA2W197Lh11B1383lm8nA6Pfs3Fpv4jdcmZlN1YZoHJkhjb1cTOMY04DytcML7maTfPV1ROibn6an8nr3X3bPf5IP7tA8-8tIAqHB9pSbSmXre6W0Vr0su_v0Hzf8CIqEEAAA.JnNsxzbie_tIujQ-x6KasE0FpNylXFas4MUWNarZeobRJwzM0wENqzexaZzouCQVZUTcBsq0s7iL9wpTK8fOSE9ArvAg0YdXVSpcW9n11LoDlBrPEcflT5fCJFbJOIzaQmegRNSbGOJLNtZwdwdwa_QH2Z8sYyUaI_-JPBmYblviUtIb3mpf2KhzWB7SxXnbeDlVlxiMbMuIr_jmDn6sWao6XiiCiWNkO4EgsoKE9N_gE1ac-RR-Y3SpI-AaWQheVbmFjPs9juPi1jdYLB8-6q2r_XcAR3pRpHPci5Vj1XbulFMP8vIA4lU8joB6EQH14wBQH4Sg9LDF9t6JedCcqAhr3ufoWuvtdo6bbrQZlcpUT-FJk4YhP36_UYxH-ttFrb4VogFFtmV-k8Ayfbc1yKxSqeZklawxlit3oQj4H-NHpzdgOcHos2A2v9IIs7JZ6LAPlxAFcMo4wkecovJEtk4C1MspJDZ9vyDy3f0aADccrewmIsss2LoMthmINvxH55zR6GZseIFwmC-9SvyeUfV-kCWXWMFbUfB2D0q5pthqExdjhuZUoKFP92lfDperl1XMWA02mMw7LmrzubP-OR5ORjKOuRIlShePCdzSEB4zPtCwKiO7X8o7MZwYN4yGGyDHlaozU94U0N0z4mFwMrCbCiUQHDiEupxtsuwvLWs"
}

typealias Header = [String: String]

protocol Endpoint {
    associatedtype Body: Encodable
    
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
