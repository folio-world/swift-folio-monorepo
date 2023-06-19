## swift-folio-monorepo
👋 반가워요. 저는 이런 생각이 들었어요.

왜 iOS에는 모노레포를 적용하지 않을까요 ? 

같이 해보실래요 .. ? 💍 (청혼 중..)

## 목표 설정
> 첫번째로는 기존의 잘 유지되고 있는 서비스를 모노레포로 이동시킬 수 있는지 검증해야합니다. 그리고 새로운 서비스를 모노레포에서 처음부터 만들 수 있는지 검증해야합니다.

1. [plotfolio](https://github.com/SeoBukMyeonOk/swift-plotfolio), [taskfolio](https://github.com/SW-Maestro-OSS/swift-taskfolio) 두개의 흩어져 있는 배포된 서비스 레포를 모노레포로 마이그레이션 합니다.
1. 새로운 folio 앱을 모노레포에서 만들어 배포합니다.

## 최종 목표
> 누구나 해당 레포에 folio 앱을 제작하여 기여할 수 있는 오가니제이션으로 확장할 예정입니다. 앱이 수백개가 되어도 잘 동작되는 레포를 운영하는 것이 최종 목표입니다.

1. CI/CD 구축을 통해서 누구나 앱을 제작하고, 배포할 수 있는 레포지토리가 됩니다.
2. apple의 새로운 기술(kit)을 적용한 앱을 출시한 swift계의 cookbook 레포지토리가 됩니다.
3. 모든 코드를 외부에 공개하여 iOS 생태계에 기여하는 레포지토리가 됩니다.

## 모노레포 개념
![image](https://github.com/folio-world/swift-folio-monorepo/assets/77970826/6708a088-0ed2-4d7d-b11c-fbb8b82da928)

### 참고자료
[마이리얼트립-Monorepo로 대규모 React 프로젝트 관리하기](https://medium.com/myrealtrip-product/monorepo%EB%A1%9C-%EB%8C%80%EA%B7%9C%EB%AA%A8-react-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EA%B4%80%EB%A6%AC%ED%95%98%EA%B8%B0-d12b65340306)

[콴다-팀워크 향상을 위한 모노레포(Monorepo) 시스템 구축](https://blog.mathpresso.com/%ED%8C%80%EC%9B%8C%ED%81%AC-%ED%96%A5%EC%83%81%EC%9D%84-%EC%9C%84%ED%95%9C-%EB%AA%A8%EB%85%B8%EB%A0%88%ED%8F%AC-monorepo-%EC%8B%9C%EC%8A%A4%ED%85%9C-%EA%B5%AC%EC%B6%95-3ae1b0112f1b)

[토스-일백개 패키지 모노레포 우아하게 운영하기](https://www.youtube.com/watch?v=Ix9gxqKOatY&ab_channel=FEConfKorea)

[그린랩스-모노레포_마이크로 아키텍처를 지향하며](https://www.youtube.com/watch?v=CsbBuE_MF2U&ab_channel=%EA%B7%B8%EB%A6%B0%EB%9E%A9%EC%8A%A4)
