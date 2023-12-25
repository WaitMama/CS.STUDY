# AWS Lambda
![img](https://github.com/Ryeohwan/TRL/assets/73810834/16fb301b-ecae-4e26-9b5e-605ea0a4092f)

AWS Lambda은 서버를 프로비저닝하거나 관리하지 않고도 코드를 실행할 수 있게 해주는 컴퓨팅 서비스이다.

Lambda는 고가용성 컴퓨팅 인프라에서 코드를 실행하고 서버와 운영 체제 유지 관리, 용량 프로비저닝 및 자동 조정, 코드 및 보안 패치 배포, 로깅 등 모든 컴퓨팅 리소스 관리를 수행한다. Lambda를 사용하면 Lambda가 지원하는 언어 런타임 중 하나로 코드를 제공하기만 하면 된다.

- 간단하게 말해서 서버리스로 다양한 함수를 실행해주는 장치이다.

## Lambda의 방식

아래의 코드는 웹훅이 걸려있는 google chat bot 에게 http 통신으로 event 객체를 보내주는 람다 코드이다. 

```python
import json
from json import dumps
import os
import sys
from httplib2 import Http
def lambda_handler(event, context):
    url = os.environ['google_chat_hook']
    bot_message = {'text' :str(event)}
    message_headers = {'Content-Type': 'application/json;
charset=UTF-8'}
    http_obj = Http()
    response = http_obj.request(
            uri=url,
            method='POST',
            headers=message_headers,
            body=dumps(bot_message),
        )
    return response
``` 

이렇듯 람다는 event 와 context 객체를 가지고 있는데 이 두 객체에 대해서 알아보자.

### event 객체

- Lambda가 호출될 때, 다른 서비스에서 이벤트를 전달 받음
    -  API Gateway, EventBridge에서 스케쥴을 지정해 람다를 주기적으로 호출하는 경우도 있으며, S3 등이 있다.
- 같은 함수라도, 어떤 서비스로부터 호출되었는지에 따라 event구조가 달라짐

![event object](https://github.com/Ryeohwan/TRL/assets/73810834/fe15a7cd-d944-46ef-b123-12425829652a)

    http 요청에서 흔히 볼 수 있는 것들이 event 객체 안에 들어있는 것을 확인할 수 있다.

### context 객체

- Lambda에 대한 정보가 들어있음.
    - 호출 정보, 함수 정보, 실행 환경 정보
- 같은 함수라면, 어떤 서비스로부터 호출 되었는지와는 상관 없이 context는 동일함.

![context options and methods](https://github.com/Ryeohwan/TRL/assets/73810834/dbdc1fc8-1a71-4ace-af9d-629b4101ed4a)

서버의 설정 및 유지 및 관리 등 보다 비즈니스 로직에 더 집중할 수 있다는 것이 서버리스의 장점이다.

## Lambda의 한계

하지만 람다 함수의 구조를 보았을 때 일반적인 웹 어플리케이션 과의 차이가 있다. 

## 한계 극복 시도
Adapter를 사용해서 기존 사용하고 있던 웹 어플리케이션 코드로 람다를 실행할 수 있게 한 경우도 있다. 


ex) Mangum(FastAPI), aws-serverless-express(Express) 등

하지만 이는 새로운 종속성을 코드에 추가해야 하고 라이브러리 자체의 장기적인 유지 보수의 우려가 있다. -> aws 에서 정식으로 제공하는 라이브러리가 아니어서 언제든 지원이 종료될 수 있기 때문이다.


## 이런 시도의 한계를 극복하기 위한 시도
이런 문제들을 해결하기 위해서 aws 에서 오픈소스 프로젝트를 공개하였는데 
이게 바로 AWS Lambda Web Adapter 이다.

# AWS Lambda Web Adapter
![aws lambda adapter](https://github.com/Ryeohwan/TRL/assets/73810834/5fef418e-a98e-4670-a98d-10e90a300845)


스프링 부트, Express, FastAPI 등 다양한 웹 프레임워크와 언어를 지원하고 있고, 기존의 코드를 변경하지 않고도 람다로 옮길 수 있게 해준다.

다양한 aws 서비스와 통합이 간단하다.

event객체를 자동으로 애플리케이션에 대한 http 요청으로 변환해준다. 

새로운 종속성을 추가할 필요 없고 로컬에서의 개발과 디버깅을 편하게 바꿔준다.

## Lambda Web Adapter의 구조
![adapter 의 실행환경](https://github.com/Ryeohwan/TRL/assets/73810834/ce98216a-d48c-42a2-9c2d-cbd62df4d73d)

람다 익스텐션 api를 사용해서 람다의 런타임으로 통합된 익스텐션으로 생각해도 된다.

람다 함수가 호출될 때 독립적인 프로세스 공간 내에서 작동하고 사용자 지정 런타임 역할도 하고 있다. 

함수가 실행되면 웹 어댑터가 패키지된 웹 어플리케이션과 함께 실행된다. 

커스텀 런타임 api를 사용해서 응답 스트림을 만들 수 있다. 이를 통해서 모든 코드에서 응답 스트림 코드를 구현할 수 있다. 
-> 기존에는 node.js 외에는 응답 stream을 사용하기 복잡했기 때문이다. 

웹 어댑터는 API 엔드포인트 와 웹 어플리케이션 사이에 있는 것이 보이는데 성능이 매우 중요했다고 한다.

![lambda web adapter 언어](https://github.com/Ryeohwan/TRL/assets/73810834/0bbf3a0c-34f4-4576-af88-076eb3e7c2f7)

그래서 Rust라는 언어를 사용해서 만들었다고 한다. -> 응답시간 1ms 로 단축



https://docs.google.com/document/d/1S17D2clGncZ5AMr7Ktw_IN-tXQZTynPT/edit?usp=sharing&ouid=102820596029356036413&rtpof=true&sd=true