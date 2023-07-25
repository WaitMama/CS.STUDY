# 개념
- 알고리즘의 성능을 수학적으로 표현한 표기법이다. 
- 이걸로 시간 과 공간 복잡도를 표현할 수 있다.
- 알고리즘의 실제 러닝 타임을 표현하기 보다는 데이터나 사용자의 증가율에 따른 알고리즘의 성능을 예측하는 것이다.

<br>

# O(1) constant complexity
```
class Big_O {
    public int O_1_algo(int[] arr){
        return arr[0];
    }
    int [] arr = {1,2,3,4,5,6,7,8,9,0};  // 배열의 크기가 아무리 크더라도
    int a = O_1_algo(arr);  // 항상 결과는 인덱스 0의 자리만 가져오게 된다.
}
```

    이 함수와 같이 입력 데이터의 크기와 상관없이 언제나 일정한 시간이 걸리는 알고리즘을 표현할 때 사용한다.


- 그래프로 표현하면 다음과 같다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/35f3da5d-7a9d-406b-b970-e132c498c19b)

<br>

# O(N) linear complexity
```
class Big_O {

    public int O_n_algo(int[] arr,int n){
        int count = 0;
        for (int i = 0; i < n; i++) {
            count += arr[i];
        }
        return count;
    }

    public int O_n_algo2(int[] arr,int n){
        int count = 0;
        for (int i = 0; i < 2*n; i++) {  // n 값이 커질 수록 n앞의 의미가 퇴색된다.
            count += arr[i];
        }
        return count;
    }

    int [] arr = {1,2,3,4,5,6,7,8,9,0};  // 배열의 크기가 커짐에 따라
    int a = O_n_algo(arr,arr.length);  // 배열의 크기에 비례해서 연산의 수가 증가한다.
    int b = O_n_algo2(arr,arr.length);  
}
```

    이 함수와 같이 입력 데이터의 크기에 비교해서 처리 시간이 증가하는 알고리즘을 표현할 때 사용한다. 

- 그래프로 표현하면 다음과 같다. 
- 입력한 데이터가 증가함에 비례하여 시간도 증가하는 것을 확인할 수 있다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/d7b56318-7e6c-47dc-929b-3519e3c742fa)

<br>

# O(n^2) quadratic complexity
```
class Big_O {
    public int O_n2_algo(int[] arr,int n){
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                count += arr[j]+i;
            }
        }
        return count;
    }
    int [] arr = {1,2,3,4,5,6,7,8,9,0};  // 배열의 크기가 커짐에 따라
    int a = O_n2_algo(arr,arr.length);  // n의 제곱수의 비율로 연산의 수가 증가한다.
}

```

 ![image](https://github.com/Ryeohwan/TRL/assets/73810834/1e2366bc-d029-4549-984f-2bc27eeda8e6)

 - 입력값이 증가함에 따라 시간이 n의 제곱수의 비율로 증가하는 것을 의미한다.

<br>

# O(log n) logarithmic complexity
```
class Big_O {
    public int O_logn_algo(int [] arr,int key,int low,int high){
        int mid;
        while(low <= high){
            mid = (low + high) / 2;
            if(key == arr[mid]) return mid;
            else if (key < arr[mid]) high = mid -1;
            else low = mid + 1;
        }
        return -1;  // 탐색 실패
    }
    int [] arr = {1,2,3,4,5,6,7,8,9,0};
    int a = O_logn_algo(arr,6,0,arr.length-1);
}
```

- 여기의 코드는 이분 탐색으로 
- 정렬된 배열 또는 리스트에 적합한 고속 탐색 방법이다.

- 배열의 중앙에 있는 값을 조사하여 찾고자 하는 항목이 왼쪽 또는 오른쪽 부분 배열에 있는지를 알아내어 탐색의 범위를 반으로 줄인다.
- 찾고자 하는 값이 속해있지 않은 부분은 전혀 고려할 필요가 없기 때문에, 매 단계에서 검색해야 할 리스트의 크기를 반으로 줄일 수 있다.
- 이러한 방법을 반복적으로 사용해 탐색하는 방법이 이진 탐색이다.
- 데이터의 삽입이나 삭제가 빈번할 시에는 적합하지 않고, 주로 고정된 데이터에 대한 탐색에 적합하다.


![image](https://github.com/Ryeohwan/TRL/assets/73810834/bf13a63e-45c1-4a62-be0f-c2189c4751ae)

<br>

# O(2^n) exponential complexity
```
class Big_O {
    int result = 0;
    public int fibonacci(int n){
        if(n <= 2) result = 1;
        else if (n >= 3) result = fibonacci(n-2) + fibonacci(n-1);
        return result;
    }
    int a = fibonacci(10);
}
```

- Big-O 표기법 중 가장 느린 시간 복잡도를 가진다.
- 우리가 알고있는 재귀로 구현하는 함수들이 예가 될 수 있다.

![image](https://github.com/Ryeohwan/TRL/assets/73810834/004155b8-b1db-4d86-a506-e9514fd622b4)