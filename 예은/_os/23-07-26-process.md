# Process

실행파일(program)이 memory(ram)에 적재되어서 CPU를 할당받아 실행되는 것을 process라고 한다. 즉 “ 실행중인 프로그램(program in execution)”을 뜻한다.

여기서 말하는 memory는 CPU가 직접 접근할 수 있는 컴퓨터 내부의 기억장치이다. CPU는 이 memory에 있는 명령만을 수행하기 때문에 memory에 적재(allocation)을 받아야 CPU가 연산처리를 할 수 있다. memory공간은 code, data, stack, heap으로 구성되어 있고 각 process 마다 독립적으로 할당 받는다.

CPU 는 메모리에 적제된 program 중 어느 코드의 연산해서 프로그램을 실행시킬지 는 PC(Program Counter) register에 저장되어 있다 PC register에는 다음에 실행 될 코드의 주소 값이 저장되어있다.

-   stack 영역: 함수 호출시 생성되는 지역변수와 매개 변수가 저장되는 영역
-   heap 영역: 프로그래머가 직접 공간을 할당하는 메모리영역
-   data 영역 : 프로그램의 전역변수와 static 변수가 저장되는 메모리 영역
-   code 영역 : 실행할 프로그램의 코드가 저장되는 메모리영역

### Multi Process

2개 이상의 process가 동시에 실행되는 것을 의미한다. 여기서 “동시에” 란 동시성(concurrency)와 병렬성(parallelism) 두가지를 의미한다

-   동시성 : CPU의 core가 하나일때 여러 process가 짧은 시간동안 CPU를 점유하게되는 시분할 시스템(time sharing system)으로 실행되면서 process가 동시에 실행되는 것처럼 보이는 것을 의미한다. ( CPU는 한번에 하나의 process 연산을 실행할 수 있다.)
-   병렬성: CPU의 core가 여러개 일때 각각 core가 각각의 process를 실행하면서 동시에 실행하는 것을 의미한다.

### Time sharing system : 시분할 시스템

-   **Context, PCB:** 시분할 시스템에서는 process가 매우 짧은 시간 ms 시간동안 CPU를 점유해서 명렬을 수행하고 다른 process로 이를 넘기게 되는데 이때 이전에 어디까지 명령을 수행했고, register가 어떤 값이 저장되어있는 지같은 process의 현재 상태를 context라고 하고 이는 PCB(Process Conctrol Block)에 저장을 한다. 그리고 이 PCB는 보통 운영체제만이 관리하며 따라서 커널 스택에 위치한다.

-   **Context switch:** 한 process 에서 다른 process로 CPU의 제어권을 넘겨주는 것을 뜻하며 이전 process 상태를 PCB에 저장하고 새로운 process 의 PCB를 읽어서 상태를 복구하는 작업을 한다.

### IPC (Inter Process Communication)

process 안에서 memory를 공유하는 thread와 달리 process는 각각 독립적인 메모리 영역을 가지고 있기 때문에 다른 process 주소 공간을 참조 할 수 없다. 하지만 경우에 따라 운영체제는 process간의 자원 접근을 위한 매커니즘인 IPC를 제공한다

IPC방법 에는 기본적으로 **공유메모리(shared memory)**와 **메시지 전달(message passing)**의 두 가지 모델이 있다.

-   공유메모리 : process 들이 주소공간의 일부를 공유하며 읽기/쓰기를 통해 process가 서로 통신한다. process가 공유 메모리 할당을 요청하면 kernel은 메모리에 할당해주고 이후 kernel의 관섭없이 process간 메모리를 공유할 수 있다. 그로 인해서 속도가 빠르지만 동기화 문제를 개발자가 책임 져야한다.
-   메시지 전달: system call을 사용하여 구현되고 kernerl을 통해 send(message)와 receive(message) 연산을 제공받는다. kernel의 관리로 인해서 속도는 느리지만 충돌을 회피 할수 있다. ( 예시 - pipe, socket, message queue )
