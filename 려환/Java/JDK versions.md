# 시작하기 전에..JRE, JDK란?

## JRE

JRE(Java Runtime Environment)는 말 그대로 자바 실행 환경이다. JRE는 JVM 뿐만 아니라 Java binaries, Java 클래스 라이브러리 등을 포함하고 있어 자바 프로그램의 실행을 지원한다. 하지만 JRE는 컴파일러나 디버거(Debugger) 등의 도구는 포함하지 않는다. 따라서 자바 프로그램을 개발하는 것이 아니라 실행하기만 원한다면 JRE를 설치하면 된다.

## JDK

JDK(Java Development Kit)는 말 그대로 자바 개발 키트이다. JDK는 자바 애플리케이션을 개발하기 위한 환경을 지원한다. JDK는 JRE를 포함할 뿐만 아니라 컴파일러(javac), javadoc, jar 등 개발에 유용한 도구들을 포함하고 있다. 따라서 자바 프로그램을 개발하기 위해서는 JDK를 다운로드하여야 한다.

    결론은 JRE는 자바 실행환경이고, JDK는 자바 개발 도구라는 것이다. 따라서 개발자들은 JDK를 다운로드 받으면된다.

# Java 8 과 Java 11의 차이

| Java 8                                      | Java 11                                                                                                        |
| ------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| 애플릿 뷰어 도구 사용 가능                  | 애플릿 뷰어 도구 사용 불가                                                                                     |
| AWTUtilities 클래스 사용하지 않는것이 좋음  | AWTUtilities 클래스 사용 불가                                                                                  |
| String 문자열 관련 메소드가 적다            | isBlank(), line(), repeat(n), stripLeading(), stripTrailing(), strip() 같은 새로운 String 문자열 방법이 도입됨 |
| 람다 파라미터에는 특수 변수가 사용되지 않음 | 람다식에 사용할 var 변수를 사용 할 수 있음                                                                     |
| Java Deployment Technologies 사용 가능      | Java Deployment Technologies 사용 불가                                                                         |
| JMC 및 JavaFX는 Oracle JDK에서 사용 가능    | JMC와 JavaFX는 자바 11의 Oracle JDK에서 제거                                                                   |
| 파일에 적합한 방법이 없음.                  | writeString(), readString(), isSameFile()과 같은 다양한 메소드가 있어 파일에 대해 여러 작업을 수행 할 수 있음. |
| 패턴을 인식 할 수 없음                      | 패턴 인식은 asMatchPredicate(() 메서드의 도움으로 가능                                                         |

## 애플릿(Applet)이란?

패널(Panel)을 상속하는 클래스로 웹브라우저에 담겨서 실행되는 작은 응용프로그램을 말함.

## AppletViewer

자바 애플릿을 실행하기 위함이지만, 2015년-2016년 사이에 지원을 종료하였고, 이제와서 굳이 사용할일이 없기때문에 자바11부터는 지원하지 않음.

## AWTUtilities

GUI를 지원하기 위한 라이브러리. 오류가 많아서 자바8부터 사용 안하는것을 권장.

## String 관련 메소드

- isBlank() : 문자열이 비거나 공백일 경우 true 반환

- lines() : 문자열을 줄 단위로 쪼개어 스트림 반환

- repeat(n) : 문자열에 대해 n번 반복하여 붙여 반환

  ex)

  String str = "ABC";

  String repeated = str.repeat(3); // "ABCABCABC"

- stripLeading() : 문자열 앞 공백 제거

- stripTrailing() : 문자열 뒤 공백 제거

- strip() : 양쪽 공백 제거

## 람다에서 var 변수 사용 가능

람다는 타입을 스킵 할 수 있는데 이걸 사용하는 이유는 @Nullable 등의 어노테이션을 사용하기 위해 타입을 명시해야 할때. var를 사용하려면 괄호를 써야하며, 모든 파라미터에 사용해야 하고, 다른 타입과 혼용하거나 일부 스킵은 불가능함.

ex) (var n1, var n2) -> n1 + n2

(var s1, s2) -> s1 + s2 // 불가. s2에도 var 필요

(var s1, String x) -> s1 + x // 불가. String과 혼용 불가

var s1 -> s1 // 불가. 괄호 필요.

Function<String, String> toLowerCase = (var input) -> input.toLowerCase();

## file 처리

- writeString() : 파일에 문자열을 쓰고 경로로 반환

- readString() : 파일 내용을 String으로 반환

- isSameFile() : 서로 같은 파일을 바라보는지 확인. 같은 파일일 경우 true. 아니면 false

## 패턴 인식

Java 8에서는 asPredicate()를 통해 주어진 문자열에서 패턴을 찾을 수 있는지 테스트 하기 위해 '조건자'를 반환. Java 11에서는 asMatchPredicate()를 통해 패턴이 주어진 문자열과 일치하는지 테스트하기 위해 '술어' 반환함.

# 그렇다면 11보다 8을 사용하는 기업이 많고 이점이 뭘까?

Java 8 : 2030년 12월 <br>
Java 11 : 2026년 9월 <br>
Java 17 : 2029년 9월 <br>

옛날에 나온 Java 8이 그 이후 나온 11과 17보다 길다.

1. 외부 개발 툴과의 연동성에서 가장 안정적이다. java11부터 요금정책이 바뀌어서 Oracle JDK 말고 Open JDK를 사용해야한다.

2. Java11과 크게 차이가 나지 않는다. 따라서 java8 릴리즈 지원 안하면 그때 버전 업그레이드를 해도 된다.

# 간단요약 ( 17 버전 포함)

## Java 8

- 오라클이 자바 인수 후 출시한 첫 번째 LTS 버전
- 32bit를 지원하는 마지막 공식 Java 버전
- Oracle JDK(Oracle사에서 지원하는 버전으로 유료) , Open JDK(오픈소스 기반의 무료)로 나뉨
- 새로운 날짜와 시간 API(LocalDateTime 등)
- 람다식(Lambda), Stream API
- PermGen 영역 삭제
- Static Link JNI Library

## Java 11

- Oracle JDK와 Open JDK 통합
- Oracle JDK가 구독형 유료 모델로 전환
- 람다 지역 변수 사용법 변경
- Third Party JDK로의 이전 필요
- HTTP 클라이언트 표준화 기능

## Java 17

- 가장 최신 LTS 버전
- 봉인 클래스(Sealed Class) 정식 추가
- 패턴 매칭 프리뷰 단계
- Incubator (Foreign Function & Memory API)
- 애플 M1 및 이후 프로세서 탑재 제품군에 대한 정식 지원 (Mac 유저들 환호)
- 난수 생성 API 추가
