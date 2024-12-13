import Foundation

public protocol ApiClientProtocol: Actor {
    func send<T: Decodable & Sendable>(
        _ request: Request<T>,
        delegate: URLSessionDataDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<T>
    
    func send(
        _ request: Request<Void>,
        delegate: URLSessionDataDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<Void>
    
    func data<T>(
        for request: Request<T>,
        delegate: URLSessionDataDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<Data>
    
    // MARK: Upload
    /// Convenience method to upload data from a file.
    ///
    /// - parameters:
    ///   - request: The URLRequest for which to upload data.
    ///   - fileURL: File to upload.
    ///   - delegate: A task-specific delegate.
    ///   - configure: Modifies the underlying `URLRequest` before sending it.
    ///
    /// - returns: A response with a decoded body. If the response type is
    /// optional and the response body is empty, returns `nil`.
    func upload<T: Decodable & Sendable>(
        for request: Request<T>,
        fromFile fileURL: URL,
        delegate: URLSessionTaskDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<T>

    /// Convenience method to upload data from a file.
    ///
    /// - parameters:
    ///   - request: The URLRequest for which to upload data.
    ///   - fileURL: File to upload.
    ///   - delegate: A task-specific delegate.
    ///   - configure: Modifies the underlying `URLRequest` before sending it.
    ///
    /// - returns: Empty response.
    func upload(
        for request: Request<Void>,
        fromFile fileURL: URL,
        delegate: URLSessionTaskDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<Void>

    // MARK: Upload Data
    /// Convenience method for uploading data.
    ///
    /// - parameters:
    ///   - request: The URLRequest for which to upload data.
    ///   - data: Data to upload.
    ///   - delegate: A task-specific delegate.
    ///   - configure: Modifies the underlying `URLRequest` before sending it.
    ///
    /// - returns: A response with a decoded body. If the response type is
    /// optional and the response body is empty, returns `nil`.
    func upload<T: Decodable & Sendable>(
        for request: Request<T>,
        from data: Data,
        delegate: URLSessionTaskDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<T>

    /// Convenience method for uploading data.
    ///
    /// - parameters:
    ///   - request: The URLRequest for which to upload data.
    ///   - data: Data to upload.
    ///   - delegate: A task-specific delegate.
    ///   - configure: Modifies the underlying `URLRequest` before sending it.
    ///
    /// Returns decoded response.
    func upload(
        for request: Request<Void>,
        from data: Data,
        delegate: URLSessionTaskDelegate?,
        configure: sending ((inout URLRequest) throws -> Void)?
    ) async throws -> Response<Void>

    // MARK: Making Requests
    /// Creates `URLRequest` for the given request.
    func makeURLRequest<T>(for request: Request<T>) async throws -> URLRequest
}

public extension ApiClientProtocol {
    func send<T: Decodable & Sendable>(_ request: Request<T>) async throws -> Response<T> {
        try await send(request, delegate: nil, configure: nil)
    }
    
    @discardableResult
    func send(_ request: Request<Void>) async throws -> Response<Void> {
        try await send(request, delegate: nil, configure: nil)
    }
    
    @discardableResult
    func upload(for request: Request<Void>, from data: Data) async throws -> Response<Void> {
        try await upload(for: request, from: data, delegate: nil, configure: nil)
    }
}
