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
