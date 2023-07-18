# 비선형(Non-Linear) 자료구조

데이터 요소가 순차적으로 또는 선형으로 배열되지 않은 자료구조를 비선형 자료구조라고 한다 비선형 자료구조는 선형과 달리 멀티 레벨로 구성된다.

선형에 비해 구현과 탐색이 복잡하지만 메모리를 효율적으로 활요할 수 있다. 대표적으로는 그래프가 있고 그래프 범주에 들어가는 트리까지 비선형 자료구조라고 할 수 있다.

## 힙(Heap)

-   배열(Array)로 구현
-   시간복잡도는 push $O(logn)$ , pop $O(logn)$
-   우선순위큐를 구현한다
-   각 node에 저장된 값은 child node들에 저장된 값보다 작거나 같다(min heap)
-   종류) min heap, max heap
-   완전이진트리 구조
    -   $n$번 째 node의 left child node = $2n$
    -   $n$번 째 node의 right child node = $2n+1$
    -   $n$번 째 node의 parent node = $n/2$

## 이진탐색트리(Binary Search Tree)

-   리스트(Linked List)로 구현
-   저장과 동시에 정렬을 하는 자료구조
-   해당 node의 left subtree에는 그 node의 값보다 작은 값들을 가지고 right subtree에는 큰 값을 가진다.
