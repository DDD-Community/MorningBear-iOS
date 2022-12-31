// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EncodeQuery: GraphQLQuery {
  public static let operationName: String = "Encode"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query Encode($state: String, $token: String) {
        encode(state: $state, token: $token)
      }
      """
    ))

  public var state: GraphQLNullable<String>
  public var token: GraphQLNullable<String>

  public init(
    state: GraphQLNullable<String>,
    token: GraphQLNullable<String>
  ) {
    self.state = state
    self.token = token
  }

  public var __variables: Variables? { [
    "state": state,
    "token": token
  ] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("encode", String?.self, arguments: [
        "state": .variable("state"),
        "token": .variable("token")
      ]),
    ] }

    ///  토큰정보 인코딩 
    public var encode: String? { __data["encode"] }
  }
}
