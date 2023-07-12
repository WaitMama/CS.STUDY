# 기다려 엄마 CS 스터디만 하고 갈게

## 스터디 방식

1. 한 주에 3개의 토픽을 각자 정리한다
2. 정리한 토픽들을 공유한다
3. 메인 레포를 fork 한다
4. fork 레포에서 main 이외의 브랜치를 생성한다
5. 생성한 브랜치에 학습 내용을 정리한다
6. 생성해 메인 레포의 main으로 pull request를 생성한다 (생성한 브랜치 삭제)
7. 스터디 전날 모든 pr을 확인 후 메인 레포 master에 모은다
8. fork한 레포에 메인 레포 sync를 한 후 4부터 반복한다

### 폴더 구조

```shell
상원
  |_network
  | |_230710-tcpip.md
  |_database
```

기본 폴더 구조는 다음과 같다

### new_topic.sh 사용 방법

#### 실행 환경

`windows`: wsl2  
`mac`: terminal, iterm

```shell
chmod +x new_topic.sh # 실행 권한 부여
```

```shell
./new_topic.sh # 파일 실행
```

```plaintext
Please enter your name (상원: s, 원철: w, 예진: y, 예은: n, 려환: r): s
Please enter the topic: test
Folder created: 상원/test
Please enter the detail topic: test
Markdown file created: 상원/test/23-07-12-test.md
```

사용자 알파벳과 주제, 세부 주제를 입력하면 자동으로 md파일을 생성해준다.
