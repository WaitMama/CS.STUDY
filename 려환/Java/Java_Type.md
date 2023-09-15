# 1장 들어가기

자바가 지원하는 타입(type; 자료형)은 인터페이스(interface), 클래스(class), 배열(array), 기본 타입(primitive)까지 총 네 가지다. 

어노테이션(annotation)은 인터페이스의 일종이며 

열거 타입(enum)은 클래스의 일종이다. 

네 가지 타입 중 처음 세 가지 는 참조 타입(reference type)이라 한다. 즉, 클래스의 인스턴스와 배열은 객체 (object)인 반면, 기본 타입 값은 그렇지 않다. 

클래스의 멤버로는 필드(field), 메서드(method), 멤버 클래스, 멤버 인터페이스가 있다. 

메서드 시그니처는 메서드 이름과 입력 매개변수(parameter)의 타입들로 이뤄진다.

(반환값의 타입은 시그니처에 포함되지 않는다).

## 여기서 기본 타입(primitive) 에 대해서 알아보자

- 총 8가지의 기본형 타입(Primitive type)을 미리 정의하여 제공한다.
- 기본값이 있기 때문에 Null이 존재하지 않는다. 만약 기본형 타입에 Null을 넣고 싶다면 래퍼 클래스를 활용한다.
- **실제 값**을 저장하는 공간으로 스택(Stack)메모리에 저장된다.
- 만약 컴파일 시점에 담을 수 있는 크기를 벗어나면 에러를 발생시키는 컴파일 에러가 발생한다. 주로 문법상의 에러가 많다. 예를 들어 ;을 안붙였다는 이유로 빨간 줄이 쳐지는 경우

|  | 타입 | 할당되는 메모리 크기 | 기본값 | 데이터의 표현 범위 |
| --- | --- | --- | --- | --- |
| 논리형 | boolean | 1 byte | false | true, false |
| 정수형 | byte | 1 byte | 0 | -128 ~ 127 |
|  | short | 2 byte | 0 | -32,768 ~ 32,767 |
|  | int(기본) | 4 byte | 0 | -2,147,483,648 ~ 2,147,483,647 |
|  | long | 8 byte | 0L | -9,223,372,036,854,775,808 ~ 9,223,372,036,854,775,807 |
| 실수형 | float | 4 byte | 0.0F | (3.4 X 10-38) ~ (3.4 X 1038) 의 근사값 |
|  | double(기본) | 8 byte | 0.0 | (1.7 X 10-308) ~ (1.7 X 10308) 의 근사값 |
| 문자형 | char | 2 byte (유니코드) | '\u0000' | 0 ~ 65,535 |

## **참조형 타입(Reference type)**

- 기본형 타입을 제외한 타입들이 모두 참조형 타입(Reference type)이다.
- 빈 객체를 의미하는 Null이 존재한다.
- 값이 저장되어 있는 곳의 **주소값**을 저장하는 공간으로 **힙(Heap)** 메모리에 저장된다.
- 문법상으로는 에러가 없지만 실행시켰을 때 에러가 나는 런타임 에러가 발생한다. 예를 들어 객체나 배열을 Null 값으로 받으면 NullPointException이 발생하므로 변수값을 넣어야 한다.

| 타입 | 예시 | 기본값 | 할당되는 메모리 크기 |
| --- | --- | --- | --- |
| 배열(Array) | int[] arr = new int[5]; | Null | 4 byte (객체의 주소값) |
| 열거(Enumeration) |  | Null | 4 byte (객체의 주소값) |
| 클래스(Class) | String str = "test";
 Student ryeoryeo = new Student(); | Null | 4 byte (객체의 주소값) |
| 인터페이스(Interface) |  | Null | 4 byte (객체의 주소값) |

## 헉 그럼 String 은 뭐지

String 은 생성 방식에 따라서 달라지게 된다.

```java
String str = "Hello";
```

리터럴로 선언하게 되면 

“Hello” 라는 값은 Heap 메모리 내에 String pool이라는 곳에 저장되고 그 주소가 str 변수에 저장된다.

String pool 에 저장이 될 때는 intern() 메소드가 실행이 되게 되는데

같은 값이 있을 경우 기존값의 메모리 주소를, 다른 값일 경우 새롭게 객체를 생성해 값을 저장하고 그 메모리 주소를 리턴한다. 그래서 아래와 같이 리터럴로 생성한 String을 동등연산자로 비교하게 되면 true가 리턴된다.

```java
String a = "Hello";
String b = "Hello";
boolean c = a == b;
System.out.println(c);   //true, a와 b의 주소 값이 같음.
```

String 클래스의 생성자를 보면, char형의 배열 형태로 저장되는 것을 알 수 있다.

```java
public final class String implements java.io.Serializable, Comparable, CharSequence {
    private final char value[];

    public String(String original) {
        this.value = original.value;
        this.hash = original.hash;
    }
    .
    .
    .
}
```

컴퓨터가 인식하는 0과 1(bit단위)로 변환하기 위해 유니코드(2byte 문자체계)를 사용하는 char 형으로 변환해서 저장하게 된다.

### String 의 연산

문자열을 결합할때는 + 연산자를 사용한다.

```java
String a = "Hello";
String b = " World";
String c = a+b;
System.out.println(c);   // Hello World
```

문자열을 합치는 concat() 메소드를 사용해도 동일한 결과를 가져올 수 있는데

```java
String a = "Hello";
String b = " World";
String c = a.concat(b);
System.out.println(c);   // Hello World
```

이전의 1.5 버전의 자바에서는 + 와 concat이 동일한 방법으로 작동되었다.

```java
public String concat(String str) {
    int otherLen = str.length();
    if (otherLen == 0) {
        return this;
    }
    int len = value.length;
    char buf[] = Arrays.copyOf(value, len + otherLen);
    str.getChars(buf, len);
    return new String(buf, true);
}
```

리턴하는 값을 보면 new 를 통해서 새로운 메모리 주소를 리턴했다.

결과적으로 더할 때 3개의 주소가 사용된 것이다.

주소 값

1000 Hello

2000 World

3000 Hello World -> 3000을 리턴

1.5 버전에서는 이전에서는 String pool 개념 조차도 없었고, 유동적이지 못한 Permgen 영역에 저장되어

String 연산이 많이 발생한 경우 Out of memory를 날렸다고 한다.

이러한 문제 때문에 1.5버전 부터는 새로운 개념이 나온다.

### **StrinBuilder, StringBuffer**

```java
StringBuilder sb = new StringBuilder();
sb.append("Hello");
sb.sppend(" World");
System.out.println(sb);   // Hello World
```

주소 값

1000 Hello

1000 World

1000 Hello World  ->1000을 리턴

이 놈들의 등장으로 String 객체의 + 연산방식도 바뀌게 된다.

```java
String a = "Hello";
String b = " World";
String c = a+b;  // new StringBuilder(String.valueOf(a)).append(b).toString();
System.out.println(c); // Hello World
```

내부적으로는 StringBuilder를 생성해 append 메소드로 문자열을 결합하도록 바뀌었다.

여러개의 문자열을 결합할 수록 메모리의 효율이 증가된 것이다.

참고로 StringBuffer와 StringBuilder는 동등연산자나 equals 메소드로 값을 비교할 수 없다.

그래서 toString 메소드로 String 인스턴스를 얻은 후 equals로 메소드로 비교하여야 한다.

```java
StringBuffer sb = new StringBuffer("gg");
StringBuffer sb2 = new StringBuffer("gg");
System.out.println(sb==sb2);  //false
System.out.println(sb.equals(sb2));  //false
System.out.println(sb.toString().equals(sb2.toString()));  //true
```

**StringBuilder, StringBuffer의 차이**

이 둘의 차이는 동기화이다.

StringBuffer는 동기화를 제공하는 대신 속도가 느리고

StringBuilder는 동기화를 제공하지 않아 속도가 보다 빠르다.

멀티쓰레드 환경에서 동시에 객체에 접근하는 경우 StringBuffer를, 아닌 경우에는 StringBuilder를 사용한다.

단순성능 : StringBuilder > StringBuffer >>> String

**String 의 값 비교**

String 변수의 값이 같은지 다른지 비교는 동등연산자(==)가 아닌 equals() 메소드를 사용한다.

String 변수는 인스턴스 주소를 담고 있기 때문에 동등연산자로는 값을 비교할 수 없다.

```java
String a = "Hello";
String b = "Hello";
if(a.equals(b)) System.out.println("같읍니다...");
```

equals Method

```java
public boolean equals(Object anObject) {
    if (this == anObject) {
        return true;
    }
    if (anObject instanceof String) {
        String anotherString = (String)anObject;
        int n = value.length;
        if (n == anotherString.value.length) {
            char v1[] = value;
            char v2[] = anotherString.value;
            int i = 0;
            while (n-- != 0) {
                if (v1[i] != v2[i])
                    return false;
                    i++;
            }
            return true;
        }
    }
    return false;
}
```

## 더 파고들어보자. String 은 주소값을 담고있다고 했는데 어떻게 println 을 쓰면 주소값이 아닌 값이 나올까?

System.out.println(); 이 동작하는 과정은 이렇다.

System.class -> PrintStream.class -> BufferedWriter.class -> Writer.class -> StringWriter.class

StringWriter.class 를 보면 StringBuffer에 값을 append해서 write를 하게 되는데,

StringWriter.class에는 toString 메소드가 오버라이드 되어 있어 문자열로 출력을 하게 됩니다.