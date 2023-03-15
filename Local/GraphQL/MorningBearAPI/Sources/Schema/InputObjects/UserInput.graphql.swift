// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

///  내정보 저장을 위한 입력데이터 
public struct UserInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    nickName: GraphQLNullable<String> = nil,
    photoLink: GraphQLNullable<String> = nil,
    memo: GraphQLNullable<String> = nil,
    wakeUpAt: GraphQLNullable<String> = nil,
    goal: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "nickName": nickName,
      "photoLink": photoLink,
      "memo": memo,
      "wakeUpAt": wakeUpAt,
      "goal": goal
    ])
  }

  ///  닉네임 
  public var nickName: GraphQLNullable<String> {
    get { __data["nickName"] }
    set { __data["nickName"] = newValue }
  }

  ///  프로필사진 링크 
  public var photoLink: GraphQLNullable<String> {
    get { __data["photoLink"] }
    set { __data["photoLink"] = newValue }
  }

  ///  자기소개글 
  public var memo: GraphQLNullable<String> {
    get { __data["memo"] }
    set { __data["memo"] = newValue }
  }

  ///  기상시간(format: HHmm) 
  public var wakeUpAt: GraphQLNullable<String> {
    get { __data["wakeUpAt"] }
    set { __data["wakeUpAt"] = newValue }
  }

  ///  목표 
  public var goal: GraphQLNullable<String> {
    get { __data["goal"] }
    set { __data["goal"] = newValue }
  }
}
