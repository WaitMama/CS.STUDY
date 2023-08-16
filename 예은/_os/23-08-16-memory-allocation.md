# Memory Allocation

프로그램이 메모리에 적재되어서 CPU에 할당을 받으면 그제서야 프로세스가 된다. 이때 프로세스를 메모리에 적재하는 방법은 다양한데 우선 크게 물리적 메모리를 연속적 할당할지 비연속적으로 할당지에 따라 나뉘게 된.

-   Contiguous memory allocation : 프로세스를 통채로 메모리에 적제한다
-   Non-Contiguous memory allocation
    -   **Segmentation**(세그멘테이션) : 프로세스를 논리적 단위(세그먼트)로 잘라서 메모리에 적재하는 방법
    -   ⭐**Paging**(페이징) : 프로세스를 정확하게 일정한 간격(페이지)으로 잘라 메모리에 적재하는 방법

### Segmentation

Segmentation 기법은 process가 할당받은 메모리 공간을 논리적 의미단위인 segment로 나누어 연속되지 않은 물리 메모리 공간을 할당할 수 있는 메모리 기법이다.

Segmentaion는 연속 메모리 할당방법과 페이징 방법의 중간에 있다. 따라서 프로세스를 통채로 올리는 것이아니라 기능단위로 프로제스를 나눠서 메모리에 적재한다.

일반적으로 메모리 영역에서 기능단위로 ( 예를 들어 Code, Data, Heap, Stack)으로 segment를 정의하는 경우가 많다.

segmetation 기법에서 segment는 논리적 주소이기 때문에 물리적 메모리주소와 주소바인딩(address binding) 이 일어 나야한다. 이를 위해 모든 프로세스가 각각의 주소를 변환하기 위한 segment table을 가진다.

### Paging

paging 기법은 process의 메모리 공간을 동일한 크기의 page 단위로 나누어 물리적 메모리의 서로 다른 위치에 page들을 저장하는 메모리 관리 기법이다. paging 기법에서는 물리적 메모리를 **page와 같은 크기의 frame**으로 미리 나누어둔다.

paging 기법에서는 주소 바인딩(address binding)을 위해 모든 프로세스가 각각의 주소 변환을 위한 page table을 가진다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/71561dbd-7abe-42bb-8b19-d20ede1d9621/Untitled.png)

-   break pyhsical memory into fixed-sixed blocks (**frames**)
-   break logical memory into blocks of same size (**pages**)

페이지 넘버(p)를 통해 페이지 테이블에서 해당하는 프레임(f)을 알수 있다 페이지 넘버를 실제 물리 주소인 프레임 넘버(f)로 바꿔준다.

### **Memory fragmentation Problem**

메모리 단편화 문제

물리적 메모리 공간이 작은 조각으로 나눠져서 메모리가 충분히 존재함에도 할당이 불가능한 상태를 보고 메모리 단편화가 발생했다고 한다.

-   External fragmentation ( 외부단편화 ) - 메모리가 할당되고 해제되는 작업이 반복될 때 작은 메모리가 중간중간 존재하게 된다. 이 때 **중간중간에 생긴 사용하지 않는 메모리가 많이 존재해서 총 메모리 공간은 충분하지만 실제로 할당할 수 없는 상황**
-   Internal fragmentaion ( 내부단편화 ) - 메모리를 할당할 때 **프로세스가 필요한 양보다 더 큰 메모리가 할당되어서** 프로세스에서 사용하는 메모리 공간이 낭비 되는 상황

### Paging vs Segmentation

paging은 일정한 크기의 단위로 나누어 할당을 하는데, 이에 반해 segmentation은 code, data, heap, stack등의 기능(의미)단위로 물리 메모리에 할당을 하는 기법이다.

paging의 경우 내단편화의 문제가 발생할 수 있는데, 이에 반해 segmentation은 외단편화의 문제가 발생할 수 있다..
