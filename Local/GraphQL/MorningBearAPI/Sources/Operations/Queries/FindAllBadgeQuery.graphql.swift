// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FindAllBadgeQuery: GraphQLQuery {
  public static let operationName: String = "FindAllBadge"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query FindAllBadge {
        findAllBadge {
          __typename
          badgeId
          badgeTitle
          badgeDesc
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
      .field("findAllBadge", [FindAllBadge?]?.self),
    ] }

    ///  전체 뱃지 조회 
    public var findAllBadge: [FindAllBadge?]? { __data["findAllBadge"] }

    /// FindAllBadge
    ///
    /// Parent Type: `Badge`
    public struct FindAllBadge: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.Badge }
      public static var __selections: [Selection] { [
        .field("badgeId", String?.self),
        .field("badgeTitle", String?.self),
        .field("badgeDesc", String?.self),
      ] }

      ///  뱃지 ID 
      public var badgeId: String? { __data["badgeId"] }
      ///  뱃지 타이틀 
      public var badgeTitle: String? { __data["badgeTitle"] }
      ///  뱃지 설명 
      public var badgeDesc: String? { __data["badgeDesc"] }
    }
  }
}
