# 프로세스 동기화 Synchronization

## Context Switching

멀티 프로세스에서 cpu가 어떤 하나의 프로세스를 실행하고 있는 상태에서 interrupt 요청에 의해 다음 우선 순위의 프로세스가 실행 되어야 할 때 기존 프로세스의 상태나 레지스터 값을 저장하고 다음 프로세스를 실행하도록 상태나 값을 교체하는 작업

여기서 context는 레지스터 값을 의미한다.

![pic](https://github.com/WaitMama/CS.STUDY/assets/55802893/445dc4d4-b08a-4d56-9d7d-000b22554966)

위의 코드에서 어느 부분에서 context switching이 발생하는지에 따라 count의 값이 바뀌게 된다. register1이 동작을 마치기 전 context switching이 발생하여 register2로 넘어가 연산이 이뤄지면 count 값은 원하는 값을 얻지 못하게 된다.

count가 5라고 가정하고 register1 부분의 두 번째 라인에서 context switching이 발생해 register2의 연산으로 넘어가게되면

```
register1 = count(5)
register1 = register1 + 1 [register1 = 6]

###### context switching #####

register2 = 5
register2 = register2 - 1 [register2 = 4]
count = 4

##### context switching #####

count = register1 [register1 = 6, count = 6]
```

위 예시와 같이 count는 4에서 갑자기 6으로 값이 변경되어 정상적으로 동작하지 않게 된다.

## critical section problem

임계 구역 문제를 해결하기 위해서는 하나의 프로세스가 실행 중인 경우 다른 프로세스가 실행되는 것을 허용하지 않도록 하는 방법을 사용한다.

### Mutual Exclusion (

**상호 배제**: 프로세스가 critical section에서 실행 중일 때 다른 프로세스가 critical section에서 실행되지 못하도록 하는 방법이다

### Progress (deadlock을 피하기)

**진행**: 만약 프로세스가 critical section에서 실행 중이고 몇몇의 프로세스가 critical section에 접근하려고 하면 다음으로 실행될 프로세스에 대한 순서가 결정되고 무기한 연기될 수 없다

무기한 critical section에 접근하지 못하는 경우가 발행하면 안된다

### Bounded Waiting (starvation 피하기)

**한정 대기:** 한 프로세스가 자신의 critical section에 진입을 요청한 후 허용될 때까지 다른 프로세스가 critical section에 진입할 수 있는 횟수가 제한되어야 한다

## Preemtive & non-preemtive

- **Preemtive kernal**

프로세스가 비자발적으로 실행/중지되는 것을 의미한다

선점형 스케줄링은 하나의 프로세스가 cpu를 차지하고 있을 때 우선순위가 높은 다른 프로세스가 현재 프로세스를 중단 시키고 cpu를 점유하는 스케줄링 방식이다.

- **non Preemtive kernal**

운영체제가 주체되는 것이 아니라, 응용프로그램의 프로세스들이 CPU를 알아서 사용하고, 다 사용하고나면 운영체제에 돌려주는 것

한 프로세스가 CPU를 할당받으면 작업 종료 후 CPU 반환 시까지 다른 프로세스는 PCU 점유가 불가능한 스케줄링 방식
