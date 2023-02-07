// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

///  사진 저장을 위한 입력데이터 
public struct PhotoInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    photoId: GraphQLNullable<String> = nil,
    photoLink: GraphQLNullable<String> = nil,
    photoDesc: GraphQLNullable<String> = nil,
    categoryId: GraphQLNullable<String> = nil,
    startAt: GraphQLNullable<String> = nil,
    endAt: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "photoId": photoId,
      "photoLink": photoLink,
      "photoDesc": photoDesc,
      "categoryId": categoryId,
      "startAt": startAt,
      "endAt": endAt
    ])
  }

  ///  사진ID 
  public var photoId: GraphQLNullable<String> {
    get { __data["photoId"] }
    set { __data["photoId"] = newValue }
  }

  ///  사진 링크 
  public var photoLink: GraphQLNullable<String> {
    get { __data["photoLink"] }
    set { __data["photoLink"] = newValue }
  }

  ///  사진 설명 
  public var photoDesc: GraphQLNullable<String> {
    get { __data["photoDesc"] }
    set { __data["photoDesc"] = newValue }
  }

  ///  카테고리ID 
  public var categoryId: GraphQLNullable<String> {
    get { __data["categoryId"] }
    set { __data["categoryId"] = newValue }
  }

  ///  시작시간(format: HHmm) 
  public var startAt: GraphQLNullable<String> {
    get { __data["startAt"] }
    set { __data["startAt"] = newValue }
  }

  ///  종료시간(format: HHmm) 
  public var endAt: GraphQLNullable<String> {
    get { __data["endAt"] }
    set { __data["endAt"] = newValue }
  }
}
