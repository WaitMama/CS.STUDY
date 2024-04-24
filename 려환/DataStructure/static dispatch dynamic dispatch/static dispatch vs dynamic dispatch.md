# Static dispatch vs Dynamic dispatch
내가 호출할 함수를 `컴파일 타임`에 결정하냐, `런타임`에 결정하느냐에 따른 방식이라고 한다.

정적 디스패치는 컴파일 시점에 함수를 결정해서 성능상 이점이 있다.
동적 디스패치는 런타임에 결정하여 성능상의 손해를 보게 된다.

## static dispatch
    정적 디스패치(static dispatch) : 컴파일 시점에 알려진 변수 타입에 따라 정해진 메소드를 호출하는 방식

```java
public class Dispatch {
	static class Service {
		void run(int number) {//(1)
			System.out.println("run(" + number + ")");
		}
	}
	
	public static void main(String[] args) {
		new Service().run(1);
	}
}
```

메인의 run 메소드는 컴파일 시점에서 (1) 이 실행될지를 알고있다.

```java
public class Dispatch {
    static class Service {
        void run(int number) {//(1)
            System.out.println("run(" + number + ")");
        }

        void run(String msg) {//(2)
            System.out.println("run(" + msg + ")");
        }
    }

    public static void main(String[] args) {
        new Service().run(1);
        new Service().run("Dispatch");
    }
}
```

이도  컴파일 시점에 어떠한 메서드가 실행될지 알고 있기 때문에 Static Method Dispatch에 속한다.

## Dynamic Dispatch
    동적 디스패치(dynamic dispatch) : 런타임 시점에 객체 타입에 따라 동적으로 호출될 대상 메소드를 결정하는 방식

```java
public class Dispatch {

    static abstract class Service {
        abstract void run();
    }

    static class MyService extends Service {
        @Override
        void run() {//(1)
            System.out.println("MyService.run()");
        }
    }


    static class YourService extends Service {
        @Override
        void run() {//(2)
            System.out.println("YourService.run()");
        }
    }


    public static void main(String[] args) {
        Service service = new MyService();


        // = new MyService() 부분을 무시하고 아래 코드만 본다고 하자
        service.run();
    }
}
```

위 코드에서 new MyService() 부분을 보지 않는다고 하였을 때,
컴파일 시점에 service.run()은 (1)과 (2)중 어느 메서드를 실행할 것인지가 결정되지 않는다.

이는 service의 타입이 Service, 즉 추상 클래스이기 때문에 컴파일 시점에 어느 클래스가 실행될 것인지 결정할 수 없는 것이다.

결과는 (1) 이 실행된다.

실제 프로그램 실행 시에는 run() 메서드 호출 과정에서 (보이지는 않지만) receiver parameter가 전달된다.
receiver parameter는 클래스의 this에 해당하는 Object이다.
위 코드에서는 MyService의 receiver parameter가 전달되기 때문에 (1)이 실행되는 것이다.


## 출처
[말랑님 티스토리](https://ttl-blog.tistory.com/776)