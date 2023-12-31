# closure

자바스크립트는 정적 스코프 (== 렉시컬 스코프) 언어 → 함수가 정의되는 시점에 결정.



클로저란 함수와 렉시컬 환경의 조합으로, 상위 함수의 변수를 참조할 때, 상위 함수의 생애주기가 끝나더라도 계속 접근이 가능한 하위 함수를 뜻합니다.

다시 말해 하위 중첩 함수가 상위 스코프의 식별자를 참조하고 있고 본인의 외부 함수보다 더 오래 살아있는 중첩 함수를 클로저라고 합니다.

일반적으로 클로저를 사용하면 참조되어지는 외부 함수의 변수에는 함부러 접근할 수 없기 때문에 정보를 은닉할 때에 사용되거나 콜백 함수 내부에서 외부 데이터를 사용하고자 할 때 사용됩니다.


# 사용예시 :

```jsx
for(var i = 0; i <= 5; i++){
  setTimeout(function(){
    console.log(i);
  }, i * 1000);
}
// 6,6,6,6,6
```

출력값이 모두 6인 이유는 **클로저가 현재의 스코프를 기억하기 때문**입니다.
for 루프문에서 사용된 변수값 i를 직접 참조할 경우 for문이 먼저 다 돌고 난 뒤에 최신(현재의) i 를 모든 setTime함수에서 동일하게 참조 하기 때문에 클로저가 발생합니다.

setTimeout 함수가 가진 timer가 i 값을 출력하던 아니던, 반복문은 i 값을 증가시키며 계속해서 실행됩니다. setTimeout 함수가 미처 끝나기도 전에 반복문에 사용된 i 값은 이미 다섯번의 반복을 마치고 6이 되어 더 이상의 반복을 진행시키지 않습니다.

### 해결 방법

```jsx
for(var i = 0; i <= 5; i++){
    function closure(args) {
      setTimeout(function() {
        console.log(args);
      }, i * 1000);
    }
  closure(i);
}
// 1,2,3,4,5
```

**익명함수로 감싸주어 하위 스코프를 하나 생성해주고 이 스코프의 변수로 i를 넣으면**, 이를 setTime 함수의 인수로 받아 사용하기 때문에 1,2,3,4,5라는 결과 값을 받을 수 있다.