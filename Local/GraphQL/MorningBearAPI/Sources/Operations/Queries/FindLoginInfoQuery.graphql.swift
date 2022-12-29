// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FindLoginInfoQuery: GraphQLQuery {
  public static let operationName: String = "FindLoginInfo"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query FindLoginInfo {
        findLoginInfo {
          __typename
          redirectUri
          jsKey
          nativeKey
          state
        }
      }
      """
    ))

  public init() {}

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findLoginInfo", [FindLoginInfo?]?.self),
    ] }

    ///  로그인 기본정보 조회 
    public var findLoginInfo: [FindLoginInfo?]? { __data["findLoginInfo"] }

    /// FindLoginInfo
    ///
    /// Parent Type: `Login`
    public struct FindLoginInfo: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.Login }
      public static var __selections: [Selection] { [
        .field("redirectUri", String?.self),
        .field("jsKey", String?.self),
        .field("nativeKey", String?.self),
        .field("state", String?.self),
      ] }

      public var redirectUri: String? { __data["redirectUri"] }
      public var jsKey: String? { __data["jsKey"] }
      public var nativeKey: String? { __data["nativeKey"] }
      public var state: String? { __data["state"] }
    }
  }
}
