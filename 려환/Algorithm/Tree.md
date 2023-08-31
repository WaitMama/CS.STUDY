# 개념

트리 자료구조는 일반적으로 대상 정보의 각 항목들을 계층적으로 구조화할 때 사용하는 비선형 자료구조이다. 트리 의 구조는 '데이터 저장'의 의미보다는 '저장된 데이터를 더 효과적으로 탐색'하기 위해서 사용된다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/23423cf2-23ff-492e-a809-f5467b65d7c9)

# 트리의 종류

## 이진트리

![image](https://github.com/Ryeohwan/TRL/assets/73810834/ea8c8d84-b986-470f-b27a-def9d0707a5e)

    노드를 딱 두 개가지고 있는 트리이다. 맨 위 트리 이미지처럼 편항될 수 있다. 예를 들어 1 부터 8까지 순차적을 저장된다면 왼쪽편향이 되어 만약 8을 검색한다면 O(n)의 시간이 소요되는 단점이 존재한다.

## RB트리 (Red-Black tree)

<img width="539" alt="image" src="https://github.com/Ryeohwan/TRL/assets/73810834/7a276af2-d56e-47be-bdef-9f5537e2ead4">

    레드-블랙 트리는 자가 균형 이진 탐색 트리이다.

먼저 이해해야 할 것은 NIL Node 이다. 자식 노드가 존재하지 않는 경우의 NIL node 라는 특수한 노드가 있다치면 모든 leaf node 는 NIL Node가 된다. 또한 root의 부모도 NIL Node 라고 가정한다.

### rb트리의 조건

1. 모든 노드는 빨간색 혹은 검은색이다.
2. 루트 노드는 검은색이다.
3. 모든 리프 노드(NIL)들은 검은색이다. (NIL : null leaf, 자료를 갖지 않고 트리의 끝을 나타내는 노드)
4. 빨간색 노드의 자식은 검은색이다.
   => No Double Red(빨간색 노드가 연속으로 나올 수 없다)
5. 모든 리프 노드에서 Black Depth는 같다.
   => 리프노드에서 루트 노드까지 가는 경로에서 만나는 검은색 노드의 개수가 같다.

### rb트리의 삽입

![image](https://github.com/Ryeohwan/TRL/assets/73810834/5a3f1045-e25e-4b10-be96-286c001c609d)

레드-블랙 트리에 새로운 노드를 삽입할 때 새로운 노드는 항상 빨간색으로 삽입한다.

이렇게 되면 4번 조건이 위배되는 상황이 발생한다. 즉, 빨간색 노드가 연속으로 2번 나타날 수 있다(Double Red)

레드 블랙 트리는 이러한 Double Red 문제를 해결하기 위해 2가지 전략을 사용한다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/e16e1b42-6c14-4521-8be0-a7ef76ceadab)

앞으로 새로 삽입할 노드를 N(New), 부모 노드를 P(Parent), 조상 노드를 G(Grand Parent), 삼촌 노드를 U(Uncle)라고 하자. 즉, 삼촌 노드는 말 그대로 부모의 형제라고 생각하면 된다.

Double Red가 발생했을 때

- 삼촌 노드가 검은색이라면 -> Restructuring을 수행하면 된다.
- 삼촌 노드가 빨간색이라면 -> Recoloring을 수행하면 된다.

### Restructuring

1. 새로운 노드(N), 부모 노드(P), 조상 노드(G)를 오름차순으로 정렬한다.
2. 셋 중 중간값을 부모로 만들고 나머지 둘을 자식으로 만든다.
3. 새로 부모가 된 노드를 검은색으로 만들고 나머지 자식들을 빨간색으로 만든다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/a792cc93-4095-42f2-8e4f-951a7c7b4202)

위와 같은 상황을 가정하자. Double Red가 발생했는데 삼촌 노드가 검은색이다. 따라서 Restructuring을 수행한다.

먼저 새로운 노드 N과 부모 P, 조상 G를 오름차순으로 정렬한다. 그러면 3이 중간값이 된다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/f007f0c6-e953-4e50-9242-94ff09f24c24)

따라서 중간값인 3을 부모 노드로 바꾸고 나머지 2와 5를 자식 노드로 바꾼다.

당연히 원래 5의 자식 노드였던 7은 딸려가게 된다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/71fb73a7-1043-4e24-87d8-534c1eda2b5b)

마지막으로 새롭게 부모가 된 3을 검은색으로 바꿔주고 나머지 두 자식인 2, 5의 색을 빨간색으로 바꿔주면 Double Red 문제가 해결된다!!

여기서 많이들 헷갈리는 게 완성된 트리가 규칙 3(모든 리프 노드는 검은색)을 만족하지 않는 것처럼 보일 수 있다. 값이 2인 노드는 자식 노드 NIL 2개를 가지고 있고 그 NIL들이 검은색이라고 생각하면 된다.

## Recoloring

1. 새로운 노드(N)의 부모(P)와 삼촌(U)을 검은색으로 바꾸고 조상(G)을 빨간색으로 바꾼다.

   1. 조상(G)이 루트 노드라면 검은색으로 바꾼다.

   2. 조상(G)을 빨간색으로 바꿨을 때 또다시 Double Red가 발생한다면 또다시

Restructuring 혹은 Recoloring을 진행해서 Double Red 문제가 발생하지 않을 때까지 반복한다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/1ad2c05f-e04d-4355-8e37-ac2405f2aaae)

위와 같은 상황을 가정하자. Double Red가 발생했는데 삼촌 노드가 빨간색이다. 따라서 Recoloring을 수행한다.

먼저 부모(P)와 삼촌(U)을 검은색으로 바꾸고, 조상(G)을 빨간색으로 바꾼다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/60ce0d0b-c2b3-4c3b-bee6-d5dae2b6b88d)

하지만 루트 노드는 검은색이라는 조건을 지켜야 하므로, 루트 노드를 검은색으로 바꾼다.

이렇게 하면 모든 조건이 지켜지면서 Double Red 문제가 해결된다.

검은색 노드는 2번 나와도 되냐고 묻는다면 Yes이다. 빨간색 노드가 2번 나오면 안 되는 것이다.

Recoloring은 간단해 보이지만 문제는 조상 노드(G)가 루트 노드가 아니면서, 조상 노드(G)가 또다시 Double Red 문제가 발생하는 경우이다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/442ce74f-9e7d-4a0e-885a-d078122620f3)

위와 같은 상황을 가정하자. 왼쪽 트리에서 Recoloring을 진행하면 오른쪽 트리가 된다.

이때 조상 노드(G)가 또다시 Double Red가 발생하게 된다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/e23d0c62-f5f1-4690-8c39-72e950bb67a2)

Double Red 문제가 발생한 "값이 5인 노드"를 기준으로 다시 한번 살펴보자.

해당 노드의 삼촌(U)이 빨간색이므로 다시 Recoloring을 진행해주면 Double Red 문제를 해결할 수 있다!

만약 해당 노드의 삼촌(U)가 검은색이었다면 Restructuring을 진행해주면 된다.

# 레드-블랙 트리 예제

    Q. 레드-블랙 트리에 순서대로 8, 7, 9, 3, 6, 4, 5, 12를 삽입한 후의 상태를 그리시오.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/86518b08-2ed4-49a1-9ad6-a1919d93820e)

## 레드-블랙 트리 예시 사이트

https://www.cs.usfca.edu/~galles/visualization/RedBlack.html
