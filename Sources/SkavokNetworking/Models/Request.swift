import Foundation

public typealias EncodableModel = Encodable & Sendable

/// An HTTP network request.
public struct Request<Response>: @unchecked Sendable {
    /// HTTP method, e.g. "GET".
    public var method: HTTPMethod
    /// Resource URL. Can be either absolute or relative.
    public var url: URL?
    /// Request query items.
    public var query: [(String, String?)]?
    /// Request body.
    public var body: EncodableModel?
    /// Request headers to be added to the request.
    public var headers: [String: String]?
    /// ID provided by the user. Not used by the API client.
    public var id: String?
    /// The constants used to specify interaction with the cached responses.
    public var cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad

    /// Initializes the request with the given parameters.
    public init(
        url: URL,
        method: HTTPMethod = .get,
        query: [(String, String?)]? = nil,
        body: EncodableModel? = nil,
        headers: [String: String]? = nil,
        id: String? = nil,
        cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad
    ) {
        self.method = method
        self.url = url
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
        self.cachePolicy = cachePolicy
    }

    /// Initializes the request with the given parameters.
    public init(
        path: String,
        method: HTTPMethod = .get,
        query: [(String, String?)]? = nil,
        body: EncodableModel? = nil,
        headers: [String: String]? = nil,
        id: String? = nil,
        cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad
    ) {
        self.method = method
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
        self.cachePolicy = cachePolicy
    }

    private init(optionalUrl: URL?, method: HTTPMethod) {
        self.url = optionalUrl
        self.method = method
    }

    /// Changes the response type keeping the rest of the request parameters.
    public func withResponse<T>(_ type: T.Type) -> Request<T> {
        var copy = Request<T>(optionalUrl: url, method: method)
        copy.query = query
        copy.body = body
        copy.headers = headers
        copy.id = id
        copy.cachePolicy = cachePolicy
        return copy
    }
}

extension Request where Response == Void {
    /// Initializes the request with the given parameters.
    public init(
        url: URL,
        method: HTTPMethod = .get,
        query: [(String, String?)]? = nil,
        body: EncodableModel? = nil,
        headers: [String: String]? = nil,
        id: String? = nil,
        cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad
    ) {
        self.method = method
        self.url = url
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
        self.cachePolicy = cachePolicy
    }

    /// Initializes the request with the given parameters.
    public init(
        path: String,
        method: HTTPMethod = .get,
        query: [(String, String?)]? = nil,
        body: EncodableModel? = nil,
        headers: [String: String]? = nil,
        id: String? = nil,
        cachePolicy: NSURLRequest.CachePolicy = .returnCacheDataElseLoad
    ) {
        self.method = method
        self.url = URL(string: path.isEmpty ? "/" : path)
        self.query = query
        self.headers = headers
        self.body = body
        self.id = id
        self.cachePolicy = cachePolicy
    }
}

public struct HTTPMethod: RawRepresentable, Hashable, ExpressibleByStringLiteral, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    public static let get: HTTPMethod = "GET"
    public static let post: HTTPMethod = "POST"
    public static let patch: HTTPMethod = "PATCH"
    public static let put: HTTPMethod = "PUT"
    public static let delete: HTTPMethod = "DELETE"
    public static let options: HTTPMethod = "OPTIONS"
    public static let head: HTTPMethod = "HEAD"
    public static let trace: HTTPMethod = "TRACE"
}
