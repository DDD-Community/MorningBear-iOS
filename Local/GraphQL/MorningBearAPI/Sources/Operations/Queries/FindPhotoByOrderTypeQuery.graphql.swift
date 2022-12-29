// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FindPhotoByOrderTypeQuery: GraphQLQuery {
  public static let operationName: String = "FindPhotoByOrderType"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query FindPhotoByOrderType($order: OrderInput) {
        findPhotoByOrderType(orderInput: $order) {
          __typename
          photoId
          photoLink
          photoDesc
          accountId
          categoryId
          startAt
          endAt
          updatedBadge {
            __typename
            badgeId
            badgeTitle
            badgeDesc
          }
          updatedAt
          createdAt
        }
      }
      """
    ))

  public var order: GraphQLNullable<OrderInput>

  public init(order: GraphQLNullable<OrderInput>) {
    self.order = order
  }

  public var __variables: Variables? { ["order": order] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findPhotoByOrderType", [FindPhotoByOrderType?]?.self, arguments: ["orderInput": .variable("order")]),
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
        .field("photoDesc", String?.self),
        .field("accountId", String?.self),
        .field("categoryId", String?.self),
        .field("startAt", String?.self),
        .field("endAt", String?.self),
        .field("updatedBadge", [UpdatedBadge?]?.self),
        .field("updatedAt", String?.self),
        .field("createdAt", String?.self),
      ] }

      ///  사진ID 
      public var photoId: String? { __data["photoId"] }
      ///  사진 링크 
      public var photoLink: String? { __data["photoLink"] }
      ///  사진 설명 
      public var photoDesc: String? { __data["photoDesc"] }
      ///  사용자ID 
      public var accountId: String? { __data["accountId"] }
      ///  카테고리ID 
      public var categoryId: String? { __data["categoryId"] }
      ///  시작시간(format: HHmm) 
      public var startAt: String? { __data["startAt"] }
      ///  종료시간(format: HHmm) 
      public var endAt: String? { __data["endAt"] }
      ///  신규 획득 뱃지 
      public var updatedBadge: [UpdatedBadge?]? { __data["updatedBadge"] }
      ///  업데이트 일자 
      public var updatedAt: String? { __data["updatedAt"] }
      ///  생성 일자 
      public var createdAt: String? { __data["createdAt"] }

      /// FindPhotoByOrderType.UpdatedBadge
      ///
      /// Parent Type: `Badge`
      public struct UpdatedBadge: MorningBearAPI.SelectionSet {
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
}
