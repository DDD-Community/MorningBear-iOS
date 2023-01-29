// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SortedMyMorningPhotoQuery: GraphQLQuery {
  public static let operationName: String = "SortedMyMorningPhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query SortedMyMorningPhoto($size: Int, $sort: String) {
        findPhotoByOrderType(orderInput: {size: $size, orderType: $sort}) {
          __typename
          photoId
          photoLink
          createdAt
        }
      }
      """
    ))

  public var size: GraphQLNullable<Int>
  public var sort: GraphQLNullable<String>

  public init(
    size: GraphQLNullable<Int>,
    sort: GraphQLNullable<String>
  ) {
    self.size = size
    self.sort = sort
  }

  public var __variables: Variables? { [
    "size": size,
    "sort": sort
  ] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findPhotoByOrderType", [FindPhotoByOrderType?]?.self, arguments: ["orderInput": [
        "size": .variable("size"),
        "orderType": .variable("sort")
      ]]),
    ] }

    ///  순서별 사진 조회 
    public var findPhotoByOrderType: [FindPhotoByOrderType?]? { __data["findPhotoByOrderType"] }

    /// FindPhotoByOrderType
    ///
    /// Parent Type: `Photo`
    public struct FindPhotoByOrderType: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.Photo }
      public static var __selections: [Selection] { [
        .field("photoId", String?.self),
        .field("photoLink", String?.self),
        .field("createdAt", String?.self),
      ] }

      ///  사진ID 
      public var photoId: String? { __data["photoId"] }
      ///  사진 링크 
      public var photoLink: String? { __data["photoLink"] }
      ///  생성 일자 
      public var createdAt: String? { __data["createdAt"] }
    }
  }
}
