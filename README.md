# Brandi
브랜디 iOS 과제전형 레포


### 고려한 부분들

**아키텍쳐 선택**

뷰가 많지 않고, 프로젝트의 크기가 크지 않기 때문에 MVC 및 MVVM 패턴을 사용하는 것이 적합하다고 생각이 들어 MVVM 구조로 작성하였음.

**라이브러리 선택**

SnapKit
RxSwift
Alamofire
Kingfisher
Toast

**최소 지원 버젼**

4년간 나온 장치 중 iOS 14 이상 비율이 98%고, 모든 장치에서는 93% 이상.
따라서, 최소 지원 버젼을 iOS 13이상으로 설정해두어 거의 모든 사용자들이 사용할 수 있도록 설정함.

![스크린샷 2022-03-25 오전 12.29.16.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e7dcb156-0914-47e7-ae62-d740d22cbbb0/스크린샷_2022-03-25_오전_12.29.16.png)

**커밋 컨벤션**

언제 커밋을 할 것인가?
모듈 하나를 완성했을 때 및 중요한 기능을 추가했을 때

무엇을 커밋할 것인가?
Add → 추가
Mod → 수정
Delete → 삭제

**API Key 관리**

APIKey.swift 파일에 구조체를 만들어두었음.
구조체의 key 프로퍼티에 “KakaoAK {Your Key}” 를 입력하는 방식으로 API 사용 가능
gitignore로 추적금지 처리완료

### 로직

**홈 화면**

- [x]  UISearchBar에 글자 입력 시 1초 뒤 자동 검색
- [x]  검색어가 바뀔 경우, 목록 리셋 후 데이터 페칭
    검색어를 바꾸려다가 다시 원래 검색어로 돌아올 경우 -> ```distinctUntilChanged``` 연산자를 이용해 같은 검색어를 입력한 경우 필터링
    검색어를 다 지울 경우 -> ```filter``` 연산자를 이용해 검색어가 비어있는 경우 필터링
    검색어가 바뀌었을 경우 -> 목록을 리셋하고 새로운 데이터를 받아옴. ```collectionView.scrollsToTop``` 메서드를 활용, 사용자가 새로운 데이터의 첫번째 부터 확인할 수 있도록 구성 
    
- [x]  검색 결과가 없을 경우
    - [x]  “검색 결과가 없습니다.” 메세지 표시
- [x]  스크롤 할 경우, 키보드 내려주기
- [x]  페이지네이션
    어느 시점에 페이지네이션 해줄 것인가?
    ```willDisplayCell``` 메서드를 이용했음. 사용자가 마지막 셀을 보게됐을 때 데이터 페칭이 일어나도록 구현

**디테일 화면(이미지를 클릭했을 때 보여지는 화면)**

- [x]  전체 화면으로 이미지를 보여줌
    - [x]  좌우 여백 0, 이미지 비율 유지
    - [x]  이미지가 길 경우, 스크롤 가능하도록
    - [x]  response 데이터에 출처 'display_sitename', 문서 작성 시간 'datetime'이 있을 경우 전체 화면 이미지 밑에 표시

### UI

검색결과 목록은 ```uicollectionview compositional layout``` 및 ```Diffable datasource```를 사용하여 UI 구성
검색결과 셀을 탭했을 때 나타나는 Detail View는 SwiftUI로 구성
라이트모드, 다크모드에서 일관된 UI를 보여줄 수 있도록 대응

### 회고

iOS 14 시뮬레이터에서 Detail View의 X 버튼을 눌렀을 때 액션이 동작하지 않는 이슈가 있음
-> iOS 15 시뮬레이터 및 실제 디바이스에서는 정상적으로 작동
-> SwiftUI의 버젼 이슈인지, 시뮬레이터에서의 버그인지 확인이 필요함

페이지네이션이 동작할 때, ```refreshControl```을 이용하는 방법으로 사용자에게 데이터 페칭이 되고있다는 것을 보여줘도 괜찮았을 것 같음

Kingfisher를 사용하지 않는 상황에서 이미지 캐싱 처리가 필요함



