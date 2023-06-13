import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    encoder.dateEncodingStrategy = .iso8601

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601

    ContentConfiguration.global.use(encoder: encoder, for: .json)
    ContentConfiguration.global.use(decoder: decoder, for: .json)

    app.databases.use(.postgres(hostname: "localhost", username: "abylayduzel",  password: "" ), as: .psql)

    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    app.migrations.add(CreateUsers())
    app.migrations.add(CreateTokens())

    // register routes
    try routes(app)
}
