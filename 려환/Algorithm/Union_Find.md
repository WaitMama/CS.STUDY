# 개념
    Union-Find는 대표적인 그래프 알고리즘으로 합집합 찾기 라는 의미를 가진 알고리즘이다. 서로소 집합 알고리즘이라고도 부른다. 구체적으로 여러 개의 노드가 존재할 때 , 두 개의 노드를 선택해서 현재 이 두 노드가 서로 같은 그래프에 속하는지 판별하는 알고리즘이다. 


![image](https://github.com/Ryeohwan/TRL/assets/73810834/0db6f695-10c3-4998-93e5-2fd6966d782f)

- 이런 형태의 노드가 있다고 가정하자. 현재는 전부 연결되어 있지 않기 때문에 표로 표시한다면 이렇게 표현할 수 있다.
- 모든 값이 자기 자신을 가리키도록 만드는 것이다. 첫 번째 행은 노드 번호를, 두 번째 행은 부모 노드 번호를 의미한다.


|1|2|3|4|5|6|7|8|
|---|---|---|---|---|---|---|---|
|1|2|3|4|5|6|7|8|

## 1 과 2가 연결되었다면

![image](https://github.com/Ryeohwan/TRL/assets/73810834/89aa59d2-c910-4656-9f95-131a3953b24e)

|1|2|3|4|5|6|7|8|
|---|---|---|---|---|---|---|---|
|1|1|3|4|5|6|7|8|

- 이렇게 부모를 합칠 때는 일반적으로 더 작은 값 쪽으로 합치게 된다. 이것을 Union 이라고 한다.

## 2와 3이 연결되었다면
![image](https://github.com/Ryeohwan/TRL/assets/73810834/f1387bd7-4a38-4789-8978-dd1979844c58)

|1|2|3|4|5|6|7|8|
|---|---|---|---|---|---|---|---|
|1|1|2|4|5|6|7|8|

먼저 이렇게 표시가 될 것이다. 
- 근데 의문은 그렇다면 1과 3이 연결된 것은 어떻게 알 수 있는가 이다. 부모노드만을 보고는 알 수 없기 때문이다. 그렇기 때문에 재귀함수를 활용한다고 한다.
- 3의 부모를 찾기 위해서는 3이 가리키는 2를 찾아가고 이후에 2의 부모가 1을 가리키고 있으므로 결과적으로 3의 부모는 1이 되는구나를 알 수 있다.
- 이런 연산을 마치고 나면 다음과 같은 표가 작성된다. 

|1|2|3|4|5|6|7|8|
|---|---|---|---|---|---|---|---|
|1|1|1|4|5|6|7|8|

# Java Code 로 알아보자.
```
class UnionFind{

    public int[] MakeSet(int size) {
		// 각 인덱스에 번호가 대응하도록 사이즈를 1더하여 배열 선언.
		int[] arr = new int[size + 1];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = i;
		}
		return arr;
    }

    public int find(int[] parent, int x) {
        // 만일, 찾는 대상과 인덱스 번호가 같다면 그 인덱스(=노드)가 해당 집합의 부모이다.
        if(parent[x] == x) return x;

        // 그렇지 않다면, 해당 인덱스가 가리키는 값(부모 노드)을 따라 최종 부모노드까지 탐색한다.
        else return find(parent, parent[x]);
    }

    public void union(int[] parent, int a, int b) {
        // 각 집합을 대표하는 부모가 다른 부모로 편입 되어야 한다. 원소가 편입되어서는 안된다.
        a = find(parent, a);
        b = find(parent, b);
        if (a > b) parent[a] = b;  // 작은 값으로 해주는 이유는 앞의 설명 참조
        else parent[b] = a;
    }
}

```

# 시간 복잡도
- 우선 기본적으로 Union 연산과 Find 연산을 살펴보면 Union 연산내에서 가장 큰 영향을 미치는 연산이 Find 연산임을 알 수 있다. 즉, Union 연산과 Find 연산의 시간 복잡도는 동일하다. 

    트리의 원소가 편중되어 있는 형태라면, 매 연산마다 노드의 끝까지 탐색해야 되기 때문에 O(n)의 시간복잡도를 가지게 될 것이다.

## 서로소 집합 최적화
Union 연산 혹은 Find 연산에서 각각 연산의 성능을 향상시키는 방법이 존재한다. <br>
두 방법 중 하나를 선택하면 되지만, 보통 경로 압축(Path Compression)기법을 기반으로한 Find 연산에서의 최적화 방법을 자주 사용한다.

### find 연산에서의 최적화
    경로압축(Path Compression)기법이라고 한다.
![image](https://github.com/Ryeohwan/TRL/assets/73810834/c5232ffb-e086-442d-af6c-585ada4736fb)

- 이를 보면 find 함수를 활용하면 저 우측 부분의 노드들의 부모가 결국은 다 1임을 알 수 있다.
- 재귀를 반환하는 과정에서 각 부모를 최종 부모로 바꿔주면서 반환하여 각 원소의 최종 부모를 통일시켜줄 수 있다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/02903743-fc7b-4ad0-9e12-9f7578452602)

- 기존 코드에서의 find 는 else return find(parent, parent[x]); 로 값을 찾아서 반환해주고 마는데 
- 최적화 후에는 else return parent[x] = find(parent, parent[x]); 로 반환한 값을 바로바로 부모 노드로 지정해주면서 넘어가는 것이다. 

# 최적화 후의 코드
```
class UnionFind{

    public int[] MakeSet(int size) {
		// 각 인덱스에 번호가 대응하도록 사이즈를 1더하여 배열 선언.
		int[] arr = new int[size + 1];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = i;
		}
		return arr;
    }

    public int find(int[] parent, int x) {
        // 만일, 찾는 대상과 인덱스 번호가 같다면 그 인덱스(=노드)가 해당 집합의 부모이다.
        if(parent[x] == x) return x;

        // 이 부분의 최적화가 들어간다.
        else return parent[x] = find(parent, parent[x]);
    }

    public void union(int[] parent, int a, int b) {
        // 각 집합을 대표하는 부모가 다른 부모로 편입 되어야 한다. 원소가 편입되어서는 안된다.
        a = find(parent, a);
        b = find(parent, b);
        if (a > b) parent[a] = b;  // 작은 값으로 해주는 이유는 앞의 설명 참조
        else parent[b] = a;
    }
}

```

    이 경우 시간 복잡도를 O(α(n))까지 줄일 수 있다. 이는 사실상 O(1)의 시간복잡도와 유사하다고 생각하면 된다.