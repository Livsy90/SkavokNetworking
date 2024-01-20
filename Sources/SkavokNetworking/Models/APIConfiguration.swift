import Foundation

/// The configuration for ``APIClient``.
public struct Configuration: @unchecked Sendable {
    /// A base URL. For example, `"https://api.github.com"`.
    public var baseURL: URL?
    /// By default, `URLSessionConfiguration.default`.
    public var sessionConfiguration: URLSessionConfiguration = .default
    /// The (optional) URLSession delegate that allows you to monitor the underlying URLSession.
    public var sessionDelegate: URLSessionDelegate?
    /// Overrides the default delegate queue.
    public var sessionDelegateQueue: OperationQueue?
    /// By default, uses `.iso8601` date decoding strategy.
    public var decoder: JSONDecoder
    /// By default, uses `.iso8601` date encoding strategy.
    public var encoder: JSONEncoder

    /// Initializes the configuration.
    public init(
        baseURL: URL?,
        sessionConfiguration: URLSessionConfiguration = .default
    ) {
        self.baseURL = baseURL
        self.sessionConfiguration = sessionConfiguration
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }
}
