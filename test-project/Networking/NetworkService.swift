//
//  Networking.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - NetworkTypes
typealias NetworkCompletionBlock<T: Decodable> = (Result<T, APIError>) -> Void
private typealias NetworkOutput = (data: Data?, response: URLResponse?, error: Error?)

// MARK: - NetworkService
final class NetworkService {
    // MARK: - LogsLevel
    enum LogsLevel {
        /// Very detailing logs
        case debug
        /// Logs which show just method, url and success code for request
        case short
        /// Logs disabled
        case none
    }

    // MARK: - Constant
    private enum Constant {
        static let authorizationKey = "Authorization"
        static let bearerPrefix = "Bearer "
    }

    // MARK: - Private Properies
    private let logsLevel: LogsLevel = .debug
    private let mainSession = URLSession(configuration: .default)
    private let refreshSemaphore = DispatchSemaphore(value: 1)

    // MARK: - Public Methods
    @discardableResult
    func performRequest<T: Decodable>(session: URLSession? = nil,
                                      route: BaseRouter,
                                      isAthorizedRequired: Bool = true,
                                      completion: @escaping NetworkCompletionBlock<T>) -> URLSessionDataTask? {

        return performRequest(session: session ?? mainSession, route: route, completion: completion)
    }

    // MARK: - Private Methods
    @discardableResult
    private func performRequest<T: Decodable>(session: URLSession,
                                              route: BaseRouter,
                                              completion: @escaping NetworkCompletionBlock<T>) -> URLSessionDataTask? {
        do {
            let request = try route.asURLRequest()

            logRequest(request: request)

            let task = session.dataTask(with: request) { [weak self] data, response, error in
                
                let output = NetworkOutput(data: data, response: response, error: error)

                self?.handleOutput(output, session: session, for: route, completion: completion)
            }

            task.resume()

            return task
        } catch {
            completion(.failure(APIError.default()))
            return nil
        }
    }

    private func handleOutput<T: Decodable>(_ output: NetworkOutput,
                                            session: URLSession,
                                            for route: BaseRouter,
                                            completion: @escaping NetworkCompletionBlock<T>) {
        logOutput(output: output)
        switch (output.response as? HTTPURLResponse)?.statusCode {
        case .some(200):
            decode(data: output.data, completion: completion)
        case .some(201), .some(204):
            decode(data: EmptyResponse().data, completion: completion)
        default:
            decodeError(data: output.data, completion: completion)
        }
    }

    private func decode<T: Decodable>(data: Data?, completion: @escaping NetworkCompletionBlock<T>) {
        DispatchQueue.main.async {
            guard let data = data else {
                completion(.failure(.default()))
                return
            }

            do {
                completion(.success(try CodableService.decode(T.self, from: data)))
            } catch {
                completion(.failure(.default()))
            }
        }
    }

    private func decodeError<T: Decodable>(data: Data?, completion: @escaping NetworkCompletionBlock<T>) {
        DispatchQueue.main.async {
            guard let data = data else {
                completion(.failure(.default()))
                return
            }

            do {
                completion(.failure(try CodableService.decode(ErrorResponse.self, from: data).apiError))
            } catch {
                completion(.failure(.default()))
            }
        }
    }

}

// MARK: - NetworkLogger
extension NetworkService {
    private func logRequest(request: URLRequest) {
        guard logsLevel != .none else {
            return
        }

        var log = "\(request.httpMethod!) \(request.url!)\n"

        if logsLevel == .debug,
           !(request.allHTTPHeaderFields?.isEmpty ?? true) {
            log += "Headers: [\n"
            request.allHTTPHeaderFields?.forEach({ log += "\($0.key): \($0.value)\n" })
            log += "]\n"
        }

        if logsLevel == .debug && !(request.url?.absoluteString.contains("/upload/") ?? true),
           let body = request.httpBody {
            let json = body.prettyPrintedJSONString
            log += "Body:\n\(json ?? String(decoding: body, as: UTF8.self))\n"
        }

        Log.networkRequest(log)
    }

    private func logOutput(output: NetworkOutput) {
        guard logsLevel != .none,
              let response = output.response as? HTTPURLResponse else {
            return
        }

        var log = "\(response.statusCode) \(response.url!)\n"

        if logsLevel == .debug, let data = output.data {
            let json = data.prettyPrintedJSONString
            log += "Response:\n\(json ?? String(decoding: data, as: UTF8.self))\n"
        }

        Log.networkResponce(log)
    }
}

fileprivate extension Log {
    static func networkRequest(_ message: String) {
        Log.aprint(message, emoji: "🌎⬆️")
    }

    static func networkResponce(_ message: String) {
        Log.aprint(message, emoji: "🌎⬇️")
    }
}

// MARK: - LogJSONSerialization
fileprivate extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }

        return prettyPrintedString
    }
}
