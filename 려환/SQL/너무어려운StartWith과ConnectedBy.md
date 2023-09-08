# 제 34회 SQLD 
## 문제 19. 아래의 테이블에 대한 SQL중 결과가 다른 하나는 무엇인가?
<img width="742" alt="image" src="https://github.com/Ryeohwan/TRL/assets/73810834/9826c082-ff79-43d2-97fa-6916154e5f6e">


1. SELECT C1, C2, N1,N2 FROM SQLD_34_19 WHERE N1=4 START WITH N2 IS NULL CONNECT BY PRIOR N1 = N2 ;

2. SELECT C1, C2, N1,N2 FROM SQLD_34_19 START WITH C2 ='B' CONNECT BY PRIOR N1 = N2 AND C2 <>'D'

3. SELECT C1, C2, N1,N2 FROM SQLD_34_19 START WITH C1 ='B' CONNECT BY PRIOR N1 = N2 AND PRIOR C2 ='B'

4. SELECT C1, C2, N1,N2 FROM SQLD_34_19 WHERE C1 <>'B' START WITH N1 =2 CONNECT BY PRIOR N1 = N2 AND PRIOR N1 =2;

### 1. SELECT C1, C2, N1,N2 FROM SQLD_34_19 WHERE N1=4 START WITH N2 IS NULL CONNECT BY PRIOR N1 = N2 ;

먼저 START WITH 은 최상위노드, 루트노드, 부모노드를 지정하는 것이다. N2가 NULL 인 애를 최상위 노드로 보고 PRIOR가 붙은 것은 이전 노드를 말하는 것이다. 

    START WITH 으로 지정한 노드가 부모 노드가 되는데 PRIOR 가 붙은 위치가 부모한테 붙으면 역방향 자식한테 붙으면 순방향이 된다.

- 먼저 START WITH 을 본다. 그럼 N1 = 4 인 애를 찾게 되는데 4 2 D B 가 나온다. 그리고 그 다음엔 이 4 2 D B가 부모가 되는 것이니 다음 애를 찾기 위해 CONNECTED BY 를 본다.

- 여기서 PRIOR 는 이전 행을 말한다. 여기선 4 2 D B 가 되는 것이다. 여기의 N1 과 같은 N2 를 가진 애를 찾아보면 5 4 E D 가 있는데 이는 WHERE 절을 보았을 때 조건이 맞지 않아 버리게 된다. 

- 그럼 최종 남는 애는 4 2 D B 가 된다.

### 2. SELECT C1, C2, N1,N2 FROM SQLD_34_19 START WITH C2 ='B' CONNECT BY PRIOR N1 = N2 AND C2 <>'D'

- START WITH 을 보게 되면 C2 = 'B' 인 애는 4 2 D B 가 된다. 이와 연결된 애는 4 2 D B의 N1 와 같은 N2 값을 가지고 있으면서 C2 값이 D 면 안된다. 그런 행은 존재하지 않으므로 답은 4 2 D B가 된다.

### 3. SELECT C1, C2, N1,N2 FROM SQLD_34_19 START WITH C1 ='B' CONNECT BY PRIOR N1 = N2 AND PRIOR C2 ='B'

- START WITH C1 = 'B' 인 애로 시작한다. -> 2 1 B A
- 이전의 N1과 같은 N2 값을 가지면서 이전의 C2 가 'B' 인 행은 없다.
- 고로 답은 2 1 B A 가 된다.

### 4. SELECT C1, C2, N1,N2 FROM SQLD_34_19 WHERE C1 <>'B' START WITH N1 =2 CONNECT BY PRIOR N1 = N2 AND PRIOR N1 =2;

- START WITH 을 보면 N1 = 2 인 애로 시작한다. 최상위 : 2 1 B A
그리고 이것의 N1 인 2를 N2 로 가지면서 이전의 N1 이 2인 행은 4 2 D B 이렇게 둘이 연결되는데 WHERE 절을 보면 C1 이 'B' 가 아니어야 하니 답은 4 2 D B 이다.
