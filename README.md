# 야외 농구 매칭 및 커뮤니티 앱 🏀

## 프로젝트 소개
- 농구를 함께 하고싶은 야외 농구인들을 위해 야외 농구 매칭 및 커뮤니티 서비스를 만들었습니다.
- 지도에 마커를 등록하여 모집하는 농구장의 위치를 공유할 수 있습니다.
- 지역별로 게시글을 조회할 수 있어, 접근성을 높였습니다.
- 관심있는 게시글을 등록하거나 최근 본 게시글을 조회할 수 있습니다.

## 스크린샷
<img src="https://github.com/user-attachments/assets/216423e8-be63-43f4-9834-c089d2c69315" width="200" height="450" />
<img src="https://github.com/user-attachments/assets/38772103-f9bf-4961-a17c-7f55e5437e98" width="200" height="450" />
<img src="https://github.com/user-attachments/assets/3bc5d47f-2723-47b2-9f11-426ab1438af3" width="200" height="450" />
<img src="https://github.com/user-attachments/assets/53e6ceb9-f8ac-4887-af4b-3e16dd047980" width="200" height="450" />

## 디렉토링 구조

```
.
├── APIKey.swift
├── APIUrl.swift
├── Info.plist
├── MyPrivacyInfo.plist
├── Resource
│   ├── Assets.xcassets 
│   ├── Base.lproj
│   └── Font
└── Source
    ├── Application
    ├── Extension
    ├── Network
    │   ├── Base
    │   ├── Iamport
    │   ├── KakaoAddress
    │   ├── Onboarding
    │   ├── Refresh
    │   └── Yanong
    ├── Presentation
    │   ├── Base
    │   ├── Favorite
    │   ├── Home
    │   │   ├── Home
    │   │   └── Yanong
    │   │       ├── DetailYanong
    │   │       ├── PostYanong
    │   │       └── YanongList
    │   ├── KakaoMap
    │   ├── Onboarding
    │   │   ├── Join
    │   │   └── Login
    │   ├── Profile
    │   ├── Recent
    │   └── TabBar
    ├── Realm
    └── Util
```
