# 개념
    크루스칼 알고리즘은 가장 적은 비용으로 모든 노드를 연결하기 위해 사용하는 알고리즘이다. 
- 그니까 최소 비용 신장 트리를 만들기 위한 대표적인 알고리즘이라고 할 수 있다. 
- 흔히 여러 개의 도시가 있을 때 각 도시를 도로를 이용해 연결하고자 할 때 비용을 최소화하기 위해 실제로 적용되는 알고리즘이라고 한다.

<img width="470" alt="image" src="https://github.com/Ryeohwan/TRL/assets/73810834/143af1bd-ffde-4f7f-8137-364413a2f1cf">

노드의 갯수는 7개, 간선의 갯수는 11개인 그래프를 보자.

## 먼저 간선을 거리가 짧은 순서대로 그래프에 포함시켜보자.

- 일단 모든 노드를 최대한 적은 비용으로 연결만 시키면 되기 때문에 모든 간선 정보를 오름차순으로 정렬한 뒤에 비용이 적은 간선부터 차근차근 그래프에 포함시키면 되는 것이다. 

<img width="608" alt="image" src="https://github.com/Ryeohwan/TRL/assets/73810834/c040bdc8-cf59-41c7-8048-bb101e3633e7">

일단 각 노드에 연결된 노드와 그 비용을 정리해 둔 것이다.

노드 6과 7에 정보가 없는 것은 다른 노드들의 간선 정보에 모두 포함이 되어있기 때문이다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/e4597347-2b92-4eab-a092-23b506ae726b)

- 먼저 비용을 기준으로 오름차순 정렬을 수행한다. 그리고 다음의 규칙을 따라 연결한다.

1. 정렬된 순서에 맞게 그래프에 포함시킨다.
2. 포함시키기 전에는 사이클 테이블을 확인합니다.
3. 사이클을 형성하는 경우 간선을 포함하지 않는다.  ( 여기서 사이클은 그래프가 서로 연결되어 사이클을 형성하는 경우이다. )

- 3번에 대한 설명
![image](https://github.com/Ryeohwan/TRL/assets/73810834/0ddfaeae-7f97-4b26-b10a-7b062287e266)

- 전의 유니온 파인드에서 부모노드를 일반적으로 작은 노드로 맞춰주는 과정을 통해서 사이클을 없앨 수 있다.

# 크루스칼 동작 순서

### 1.
- 초기 상태 유니온파인드처럼 부모노드를 자신으로 설정해두고 위의 간선은 오름차순 정렬되어 있다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/7a45d9f2-e84b-43c6-8045-3a500864aa04)

### 2.
![image](https://github.com/Ryeohwan/TRL/assets/73810834/dd9f64ee-45b1-47cc-8470-5aa13a790666)

- 첫번째 간선을 선택하면서 7의 부모를 1로 설정해준다.

### 3. 
![image](https://github.com/Ryeohwan/TRL/assets/73810834/85207209-8042-485b-9991-9cf3272672c9)

같은 로직이기에 과정을 계속 나열하겠다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/0c5494d8-2e29-439e-b8c0-aecb149e16e9)

![image](https://github.com/Ryeohwan/TRL/assets/73810834/9597efc6-6fe2-4cf9-89e2-b022d40a84b5)

![image](https://github.com/Ryeohwan/TRL/assets/73810834/a959166a-b8f5-46c0-b535-34bc40e6bc18)

- 이제 이미 간선이 연결되어 있는 여섯번 째 간선의 과정이다. 이미 연결되어 있기 때문에 무시한다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/2adabca7-8fb7-46ec-b67f-1d17bbffeecf)

![image](https://github.com/Ryeohwan/TRL/assets/73810834/d897cae8-dfd8-4450-acda-615221692be7)

- 이후 사이클 테이블의 모든 값이 1로 동일해지면서 이후의 값은 무시되며 완성된다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/9ca5279e-e8ca-4aa5-bef6-7d1c6a6d8a30)


# 코드
```
class Kruskal{
    public int getParent(int set[], int x){
        if(set[x] == x) return x;
        return set[x] = getParent(set,set[x]);
    }  // 부모 노드를 가져온다.

    public void unionParent(int set[], int a, int b){
        a = getParent(set, a);
        b = getParent(set, b);
        // 일반적인 규칙인 더 숫자가 작은 부모로 병합
        if(a < b) set[b] = a;
        else set[a] = b;
    }  // 부모노드 병합하기

    public int find(int set[], int a, int b){
        a = getParent(set, a);
        b = getParent(set, b);
        if (a == b) return 1;
        else return 0;
    }

    class Edge implements Comparable<Edge>{
        int node[] = new int[2];
        int distance;
        public Edge(int a, int b, int distance){
            this.node[0] = a;
            this.node[1] = b;
            this.distance = distance;
        }
        @Override
        public int compareTo(Edge c) {
            return distance - c.distance;
        }
    }

    public void startKruskal(String[] args) {
        int n = 7;
        int m = 11;

        List<Edge> list = new ArrayList<>();
        list.add(new Edge(1,7,12));
        list.add(new Edge(1,4,28));
        list.add(new Edge(1,2,67));
        list.add(new Edge(1,5,17));
        list.add(new Edge(2,4,24));
        list.add(new Edge(2,5,62));
        list.add(new Edge(3,5,20));
        list.add(new Edge(3,6,37));
        list.add(new Edge(4,7,13));
        list.add(new Edge(5,6,45));
        list.add(new Edge(5,7,73));

        Collections.sort(list);

        int set[] = new int[n];
        for (int i = 0; i < n; i++) {
            set[i] = i;  // 자기 자신을 지정해둔 상태에서
        }

        int sum = 0;
        for (int i = 0; i < list.size(); i++) {
            if(find(set,list.get(i).node[0] -1 , list.get(i).node[1] -1) == 0){
                sum += list.get(i).distance;
                unionParent(set,list.get(i).node[0] -1 , list.get(i).node[1] -1);
            }
        }

        System.out.println(sum);
    }
}
```
![image](https://github.com/Ryeohwan/TRL/assets/73810834/d18eec3e-b6f0-4ecc-9d49-b686e6cfaff1)
