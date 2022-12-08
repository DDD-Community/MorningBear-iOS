// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SaveMyInfoMutation: GraphQLMutation {
  public static let operationName: String = "SaveMyInfo"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      mutation SaveMyInfo {
        saveMyInfo {
          __typename
          accountId
          nickName
          photoLink
          memo
          wakeUpAt
        }
      }
      """
    ))

  public init() {}

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Mutation }
    public static var __selections: [Selection] { [
      .field("saveMyInfo", SaveMyInfo?.self),
    ] }

    ///  내정보 저장 
    public var saveMyInfo: SaveMyInfo? { __data["saveMyInfo"] }

    /// SaveMyInfo
    ///
    /// Parent Type: `MyProfileInfo`
    public struct SaveMyInfo: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.MyProfileInfo }
      public static var __selections: [Selection] { [
        .field("accountId", String?.self),
        .field("nickName", String?.self),
        .field("photoLink", String?.self),
        .field("memo", String?.self),
        .field("wakeUpAt", String?.self),
      ] }

      public var accountId: String? { __data["accountId"] }
      public var nickName: String? { __data["nickName"] }
      public var photoLink: String? { __data["photoLink"] }
      public var memo: String? { __data["memo"] }
      public var wakeUpAt: String? { __data["wakeUpAt"] }
    }
  }
}
