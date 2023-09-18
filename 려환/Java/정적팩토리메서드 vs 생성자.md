# 개념
    정적 팩토리 메서드란 객체 생성의 역할을 하는 클래스 메서드라는 의미
GoF 디자인 패턴 중 팩토리 패턴에서 유래한 이 단어는 객체를 생성하는 역할을 분리하겠다는 취지가 담겨있다.

java.time 패키지에 포함된 LocalTime 클래스의 정적 팩토리 메서드이다.
```
// LocalTime.class
...
public static LocalTime of(int hour, int minute) {
  ChronoField.HOUR_OF_DAY.checkValidValue((long)hour);
  if (minute == 0) {
    return HOURS[hour];
  } else {
    ChronoField.MINUTE_OF_HOUR.checkValidValue((long)minute);
    return new LocalTime(hour, minute, 0, 0);
  }
}
...

// hour, minutes을 인자로 받아서 9시 30분을 의미하는 LocalTime 객체를 반환한다.
LocalTime openTime = LocalTime.of(9, 30);
```

위 예시 코드에서 본 LocalTime 클래스의 of 메서드처럼 직접적으로 생성자를 통해 객체를 생성하는 것이 아닌 메서드를 통해서 객체를 생성하는 것을 정적 팩토리 메서드라고 한다.

또 다른 예시로 enum의 요소를 조회할 때 사용하는 valueOf 도 정적 팩토리 메서드의 일종이라고 할 수 있다.

미리 생성된 객체를 “조회”를 하는 메서드이기 때문에 팩토리의 역할을 한다고 볼 수는 없지만, 외부에서 원하는 객체를 반환해주고 있으므로 결과적으로는 정적 팩토리 메서드라고 간주해도 좋다.

```
public enum Color {
  RED,
  BLUE;
}
...
Color redColor = Color.valueOf("RED");
Color blueColor = Color.valueOf("BLUE");
```

<br>

# 그럼 생성자는 뭘까
    생성자는 인스턴스가 생성될 때 호출되는 '인스턴스 초기화 메서드'이다. 

따라서 인스턴스 변수의 초기화 작업에 주로 사용되며, 인스턴스 생성 시에 실행되어야 할 작업을 위해서도 사용된다.

생성자 역시 메서드처럼 클래스 내에 선언되며, 구조도 메서드와 유사하지만 리턴값이 없다는 점이 다르다. 
그렇다고 해서 생성자 앞에 리턴값이 없음을 뜻하는 void를 사용하지는 않고, 단지 아무 타입도 표시하지 않는다. 


## 생성자의 조건
- 생성자의 이름은 클래스의 이름과 같아야 한다.
- 생성자는 리턴값이 없다.

<br>

생성자는 다음과 같이 정의한다. 생성자도 다른 메서드들과 같이 오버로딩이 가능하므로 하나의 클래스는 여러개의 생성자를 가질 수 있다.

```
class Constructor {
  // 매개변수가 없는 생성자
  Constructor() {
  	// ...
  }

  // 매개변수가 있는 생성자
  Constructor(int a, int b) {
  	// ...
  }
}
```

연산자 new를 통해서 인스턴스를 생성하고 생성자는 인스턴스 생성시 초기화에 사용된다.

```
Constructor c = new Constructor();

/**
- 연산자 new에 의해서 메모리 (heap) 에 해당 클래스의 인스턴스가 생성된다.
- 생성자가 호출되어 초기화 등의 작업을 수행한다.
- 연산자 new의 결과로 생성된 인스턴스의 주소를 참조변수에 저장한다.
**/

```

## 기본 생성자 (default constructor)
명시적으로 생성자를 정의하지 않고도 인스턴스를 생성할 수 있는데, 이는 컴파일러가 '기본 생성자'를 제공하기때문이다.

컴파일러가 자바 소스파일을 컴파일 시에, 클래스에 생성자가 없다면 자동적으로 기본 생성자를  추가하여 컴파일한다.

```
// 기본 생성자는 아무 매개변수도 없고 내용도 없는 간단한 생성자이다.
class Example {
	// 클래스에 명시적으로 구현된 생성자가 없다면 이와 같은 기본 생성자가 추가되어 컴파일된다.
	Example() {}
}
```

    클래스의 접근 제어자 (access modifier) 가 public인 경우에는 기본생성자로 public 제어자가 붙여진 생성자가추가된다.

 

다만 아래와 같은 경우에는 에러가 발생하기 떄문에 주의해야 한다.

```
class Example {
  int val;

  Example(int x) {
  	val = x;
  }
}

public class ExampleTest {
  public static void main(String[] args) {
  	Example ex = new Example(); // compile error 발생
  }
}
```

Example 클래스를 확인해보면 이미 Example(int x) 생성자를 가지고 있다. 그렇기 때문에 컴파일러는 이미 생성자가 존재하기에 기본 생성자를 추가해주지 않는다. 기본 생성자가 없는데 main 함수에서는 기본 생성자를 사용해 인스턴스를 생성하려 하기 때문에 에러가 발생한다.

## 매개 변수가 있는 생성자
생성자도 다른 메서들과 같이 매개변수를 선언하여 사용할 수 있다.

```
class Example {
  int value1;
  int value2;

  Example() {}

  Example(int a, int b) {
    value1 = a;
    value2 = b;
  }
}
```

위의 예제에서 int a와 int b를 매개변수로 가지는 생성자는 인자들을 입력받아 멤버 변수인 value1, value2를 초기화하는데 사용한다.

## 생성자에서 다른 생성자 호출하기 - this(), this
생성자 안에서 다른 생성자를 호출하는 것도 가능하지만 다음 조건을 만족시켜야 한다.

- 생성자의 이름으로 클래스 이름 대신 this 키워드를 사용한다.
- 한 생성자에서 다른 생성자를 호출할 때는 반드시 첫 줄에서만 호출이 가능하다.

다른 생성자 호출 시에 첫 줄에서만 가능한 이유는 생성자 내에서 초기화 작업 도중에 다른 생성자를 호출하게되면 호출 된 다른 생성자 내에서도 멤버 변수들의 값을 초기화 할 것이므로 다른 생성자를 호출하기 이전의 초기화 작업이 무의미해질 수 있기 때문이다.

this는 참조변수로 인스턴스 자신을 가리킨다. 참조변수를 통해 인스턴스의 멤버에 접근할 수 있는 것처럼 this로인스턴스 변수에 접근할 수 있다.

```
class Exampled {
  int value1;
  int value2;

  Exampled(int value1, int value2) {
    this.value1 = value1;
    this.value2 = value2;
  }
}
```
위의 예제와 같이 해당 인스턴스의 멤버 변수에 접근하기 위해 this를 사용할 수 있다. 생성자 안의 value1과value2가 여러 의미로 사용되는데, this를 붙인 변수는 클래스에 선언된 인스턴스 변수들이고 다른 value1, value2는 매개변수로 입력받은 지역변수이다.

이와 같이 this 키워드를 이용하여 인스턴스의 변수 초기화에 사용할 수 있다.
 
- this: 인스턴스 자신을 가리키는 참조변수. 인스턴스의 주소가 저장되어 있다. 모든 인스턴스 메서드에 지역변수로 숨겨진 채로 존재한다. 
- this(), this(parameters ... ): 생성자. 같은 클래스의 다른 생성자를 호출할 때 사용.

## 생성자를 이용한 인스턴스의 복사

현재 사용하고 있는 인스턴스의 값을 복사하여 이와 같은 값을 가지는 인스턴스를 만들 때 생성자를 사용할 수있다.

```
class Example {
  int value1;
  int value2;

  Example(int value1, int value2) {
    this.value1 = value1;
    this.value2 = value2;
  }

  Example(Example ex) {
	this(ex.value1, ex.value2);
  }
}
```

위의 예제 코드에서 Example 객체를 인스턴스 생성시에 생성자의 매개변수로 주는 경우 같은 클래스 안에 있는다른 생성자를 호출하여 해당 인스턴스의 값을 초기화 해준다. 이와 같은 방식으로 인스턴스의 값을 동일하게가지고 있는 다른 인스턴스를 생성할 수 있다.

여기서 이런 의문이 들어야한다고 한다.

## 객체를 생성하는 역할은 자바에서 제공하는 “생성자”가 하는데, 왜 정적 팩토리 메서드를 따로 만들어서 객체를 생성하는 것일까?

이는 다음편에 계속.....