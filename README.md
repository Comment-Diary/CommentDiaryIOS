![coda](https://user-images.githubusercontent.com/78063938/198697657-057dddae-3d8e-4efc-a84a-bd7b052bd067.png)

# 코멘트다이어리 - 코다

메이커스 9기 iOS 개발자로 참여해 만든 프로젝트 '코다'입니다.
[앱 스토어에서 구경하기(현재 서버 수정중)](https://apps.apple.com/kr/app/%EC%BD%94%EB%8B%A4/id1612201085)

### 팀구성
#### iOS개발자, 안드로이드 개발자, 서버 개발자, 기획자, 디자이너

## 개발 기간 및 사용 기술

### 총 기간: 2022.01.11 ~ 2022.04.09

#### 세부 기간
| 진행 사항 | 진행 기간 | 세부 내역 |
| ------ | ------ | ------ |
| 기획 및 디자인(초안) | 2022.01.11~2022.02.12 | 앱 기획, 디자인 |
| 앱 구현 | 2022.02.12~2022.03.29 | 자체 로그인, 익명 일기 앱 구현 |
| 앱 심사, 대처 | 2022.03.29~2022.04.09 | 익명 일기 신고와 일기 차단에 대한 내용 |
- 사용 기술, 라이브러리: `Storyboard`, `MVC`, `UIkit`, `Alamofire`, `FSCalendar`, `Siren`, `PanModal`
 ## 배운 점 
 - 앱 출시 경험
 - 오토레이아웃 적용(iPhone8~iPhone13ProMax)
 - 기한 내 출시를 위한 협업 방법
 - Alamofire를 통한 네트워크 통신
 - MVC 패턴의 기초
 

## [앱 심사 내역](https://declan.tistory.com/21)
### 익명 일기 서비스임을 고려해 익명 일기의 차단, 신고 기능과 받은 코멘트의 차단, 신고 기능 추가를 적용시켜달라는 내용<br/>
- 앱 심사를 받기 전에는 익명 일기나 익명 코멘트를을 신고하면 함께 차단하는 기능으로 구현하였는데 앱 심사과정에서 추가로 차단 기능을 넣어야 한다고 하였습니다. 
따라서 차단하기, 신고하기 버튼을 따로 만들어 이에 대응하였습니다. 
<img src ="https://user-images.githubusercontent.com/78063938/198706003-176753e6-01f4-424c-b847-872f821df6cd.png" width = "700"> <br/>
### 익명 코멘트는 50자를 넘겨야 전송이 가능한데, 유저가 제대로 확인이 불가능하다고 판단하여 수정해달라는 내용<br/>
- 다음 이미지와 같이 " /20자 이상 작성"과 같이 수정하여 유저가 쉽게 넘겨야할 글자 수를 확인할 수 있게 대응하였습니다. 
<img src ="https://user-images.githubusercontent.com/78063938/198706195-c7bd3a50-17af-4178-8f47-b683843ab751.png" width = "700">
<img src ="https://user-images.githubusercontent.com/78063938/198705068-1557320e-e446-497b-9df5-0df172d078df.png" width = "400">
<img src ="https://user-images.githubusercontent.com/78063938/198705411-06e0c66e-5b52-4a75-af12-2819a40cb7da.png" width = "400">
