# 데이터베이스(Database) 기초

## DB(Database)

-   데이터가 모여 있는 기지입니다.

## DBMS(Database Management System)

-   DB를 관리할 수 있는 구체적인 시스템입니다.
-   예: 오라클, MySQL, MariaDB, MS-SQL, MongoDB 등

## MySQL

-   웹 사이트와 다양한 애플리케이션에서 사용되는 DBMS입니다.
-   오라클은 관리 비용이 고가이지만, MySQL은 저가형 데이터베이스입니다.
-   문법이 간결하고 쉬우며, 메모리 사용량이 현저히 낮아서 부담없이 사용 가능합니다.

## DBMS 소통 방식

```
----------------------------------------------------
        			사용자
----------------------------------------------------
   	↕               	            ↕
고객 관리 응용프로그램    ↕   	주문 관리 응용프로그램
   	↕           		            ↕
----------------------------------------------------
        			DBMS
----------------------------------------------------
```

## RDBMS(관계형 데이터베이스 관리 시스템)

-   테이블끼리 서로 관계를 맺는다.

### Table 예시

#### Table A(TBL_USER)

| 번호(PK) | 이름   | 나이 | 아이디(UK) |
| -------- | ------ | ---- | ---------- |
| 1        | 이기영 | 20   | lky1234    |
| 2        | 장상화 | 21   | jsh5555    |
| ...      | ...    | ...  | ...        |

#### Table B(TBL_ORDER)

| 주문번호(PK) | 번호(FK) | 날짜     | 상품수량 |
| ------------ | -------- | -------- | -------- |
| 20240114001  | 2        | 20240114 | 5        |
| 20240114002  | 2        | 20240114 | 20       |
| ...          | ...      | ...      | ...      |

-   이러한 구조를 가지는 것을 Table이라고 부른다.

## MySQL 설치 및 기본 세팅

### MySQL 설치

-   MySQL을 설치하기 위한 링크는 다음과 같습니다: [MySQL 다운로드](https://drive.google.com/file/d/1OkSYmK7GIrbHa5vFceGaji4H4QWaa8Sn/view?usp=drive_link)

### MySQL 기본 세팅

1.  **로그인**

        1) 로그인
            > mysql -u root -p
            > 1234

        2) 기본 데이터베이스 선택
            > use mysql;

        3) 로컬에서만 접속 가능한 계정 생성
            > create user 'userid'@localhost identified by '비밀번호';

        4) 원격으로도 접속 가능한 계정 생성
            > create user 'userid'@'%' identified by '비밀번호';

        5) 데이터베이스 생성
            > create database [데이터베이스 이름];

        6) 데이터베이스 사용
            > use [데이터베이스 이름];

        7) 데이터베이스 삭제
            > drop database [데이터베이스 이름];

        8) 사용자 비밀번호 변경
            > set pasword for 'userid'@'%' = '신규 비밀번호';

        9) 사용자 삭제
            > drop user 'userid'@'%';

        10) 연결 권한
            > grant all privileges on *.* to 'userid'@'%' with grant option;

        11) 권한 관련 명령어 확정
            > flush privileges;

            ## 자료형

### 정수

-   `tinyint`
-   `smallint`
-   `mediumint`
-   `int`
-   `bigint`

### 실수

-   `decimal(m, d)`: m자리 정수, d자리 소수점으로 표현

### 날짜

-   `date`: 1000-01-01 ~ 9999-12-31 (3byte)
-   `time`: -838:59:59 ~ 838:59:59 (3byte)
-   `datetime`: 1000-01-01 00:00:00 ~ 9999-12-31 23:59:59 (8byte)

### 문자

-   `char(m)`: 고정 길이 문자열 (0~255)
-   `varchar(m)`: 가변 길이 문자열 (0~65535)

### Boolean

-   MySQL에서는 `tinyint`를 사용하는 것이 가장 좋습니다.
-   `bit(1)`로 설정해도 어차피 byte 단위로 데이터를 저장하고, `bool`, `boolean`으로 설정해도 자동으로 `tinyint`로 변경됩니다.
-   만약 값에 의미부여를 하고 싶다면, `varchar`로 설정한 뒤 `check` 제약조건으로 이상 데이터 삽입을 막아줍니다.
-   `enum`을 사용하면 정규화를 위반하게 되며 설정해놓은 데이터 수정이 어렵고 다른 DBMS로 이관할 경우, MySQL에만 존재하는 `enum`을 모두 다른 타입으로 변경해야 합니다.
-   만약 `enum`을 사용하고자 한다면, 정규화 위반이 가능하도록 약속했고, 유일하고 변하지 않는 값이며, 2~10개의 값일 경우에만 사용합니다.

## DDL(Data Definition Language): 데이터 정의어

-   테이블을 조작하거나 제어할 수 있는 쿼리문

### 1. `create`: 테이블 생성

create table [테이블명] ([컬럼명] [자료형(용량)] [제약조건], ...);

### 2. drop: 테이블 삭제

drop table [테이블명];

### 3. alter: 테이블 수정

-   테이블명 수정  
     alter table [테이블명] rename [새로운 테이블명]

-   컬럼 맨 뒤에 추가  
     alter table [테이블명] add [컬럼명] [자료형] [제약조건];

-   컬럼 맨 앞에 추가  
     alter table [테이블명] add [컬럼명] [자료형] [제약조건] first;

-   컬럼 지정 위치에 추가  
     alter table [테이블명] add [컬럼명] [자료형] [제약조건] after [기존 컬럼명];

-   컬럼 삭제  
     alter table [테이블명] drop [컬럼명];

-   컬럼명 변경  
     alter table [테이블명] change [기존컬럼명] [변경할 컬럼명] [컬럼타입];

-   컬럼 타입 변경  
     alter table [테이블명] modify [컬럼명] [변경할 컬럼타입];

-   제약 조건 확인  
     desc [데이터베이스명].[테이블명];

-   제약 조건 추가  
     alter table [테이블명] add constraint [제약조건 이름];

-   제약 조건 삭제  
     alter table [테이블명] drop constraint [제약조건 이름];

### 4. truncate: 테이블 내용 전체 삭제

-   truncate table [테이블명];

## 무결성

무결성은 데이터베이스에서 데이터의 정확성, 일관성, 유효성이 유지되는 것을 의미합니다.

-   **정확성**: 데이터는 명확하고 애매하지 않아야 합니다.
-   **일관성**: 모든 사용자가 일관된 데이터를 볼 수 있어야 합니다.
-   **유효성**: 데이터는 실제 존재하는, 유효한 데이터여야 합니다.

### 종류

1. **개체 무결성(Entity Integrity)**

    - 모든 테이블은 기본 키(PK)로 선택된 컬럼을 가져야 합니다.
    - 이는 테이블 내의 각 행이 고유하게 식별될 수 있도록 보장합니다.

2. **참조 무결성(Referential Integrity)**

    - 두 테이블의 데이터가 항상 일관된 값을 가지도록 유지해야 합니다.
    - 외래 키(FK) 값은 참조된 테이블의 기본 키 값 중 하나이거나 NULL이어야 합니다.

3. **도메인 무결성(Domain Integrity)**
    - 컬럼의 타입, NULL 값의 허용 등에 대한 사항을 정의하고, 입력된 데이터가 이러한 정의를 준수하는지 확인합니다.
    - 도메인 무결성을 통해 데이터 타입, 포맷, 범위 등이 올바르게 유지됩니다.

# 모델링(기획)

모델링은 추상적인 주제를 데이터베이스에 맞게 설계하는 과정입니다. 모델링 과정은 크게 5단계로 나눌 수 있습니다.

## 1. 요구사항 분석

분석 대상: 회원, 주문, 상품. 이 세 가지 주제에 대해 데이터를 관리하고자 합니다.

## 2. 개념적 설계(개념 모델링)

개념적 모델링에서는 데이터와 그 관계를 개념적으로 표현합니다.

-   회원
-   주문
-   상품

| 회원     | 주문     | 상품 |
| -------- | -------- | ---- |
| 번호     | 번호     | 번호 |
| 아이디   | 날짜     | 이름 |
| 비밀번호 | 회원번호 | 가격 |
| 이름     | 상품번호 | 재고 |
| 주소     |          |      |
| 이메일   |          |      |
| 생일     |          |      |

## 3. 논리적 설계(논리 모델링)

논리적 모델링에서는 개념 모델을 바탕으로 테이블의 구조를 정의합니다.

-   회원
-   주문
-   상품

| 회원(PK)      | 주문(PK)         | 상품(PK)  |
| ------------- | ---------------- | --------- |
| 번호          | 번호             | 번호      |
| 아이디(U, NN) | 날짜(NN)         | 이름(NN)  |
| 비밀번호(NN)  | 회원번호(FK, NN) | 가격(D=0) |
| 이름(NN)      | 상품번호(FK, NN) | 재고(D=0) |
| 주소(NN)      |                  |           |
| 이메일        |                  |           |
| 생일          |                  |           |

## 4. 물리적 설계(물리 모델링)

물리적 모델링에서는 실제 데이터베이스 시스템에서 사용할 테이블의 구조를 정의합니다.

-   **tbl_user**  
    id: bigint primary key  
    user_id: varchar(255) unique not null  
    password: varchar(255) not null  
    name: varchar(255) not null  
    address: varchar(255) not null  
    email: varchar(255)  
    birth: date

<hr>

# 정규화

정규화는 삽입/수정/삭제의 이상현상을 제거하고 데이터의 중복을 최소화하기 위한 데이터베이스 설계 기법입니다. 일반적으로 3차 정규화까지 진행합니다.

## 1차 정규화

1차 정규화는 하나의 컬럼에 여러 값이 연속적으로 나타나는 것을 제거합니다.

**예시:**

-   상품명: 와이셔츠1, 와이셔츠2, 와이셔츠3

**1차 정규화 진행 후:**

-   상품명
    -   와이셔츠1
    -   와이셔츠2
    -   와이셔츠3

## 2차 정규화

2차 정규화는 조합키(복합키)로 구성된 경우, 조합키의 일부분에만 종속되는 속성을 제거합니다.

**예시:**

-   꽃
    -   이름, 색상, 꽃말, 과

**2차 정규화 진행 후:**

-   꽃
    -   이름, 색상, 꽃말
-   과
    -   이름, 과

## 3차 정규화

3차 정규화는 PK가 아닌 컬럼이 다른 컬럼을 결정하는 경우, 이러한 종속성을 제거합니다.

**예시:**

-   회원번호, 이름, 시, 구, 동, 우편번호

**3차 정규화 진행 후:**

-   회원번호, 이름, 우편번호
-   우편번호, 시, 구, 동

## 데이터베이스에서 정규화가 필요한 이유

잘못된 데이터베이스 설계로 인한 데이터 중복을 방지하고, 데이터의 정확성과 일관성을 유지하기 위해서입니다.

## 이상 현상의 종류

-   **삽입 이상**: 새 데이터를 삽입하기 위해 불필요한 데이터도 삽입해야 하는 문제입니다.
-   **갱신 이상**: 중복 행 중에서 일부만 변경하여 데이터가 불일치하게 되는 문제입니다.
-   **삭제 이상**: 행을 삭제하면 꼭 필요한 데이터까지 함께 삭제되는 문제입니다.

<hr>

# 상속관계 3가지

데이터베이스 설계에서 상속관계를 다루는 세 가지 접근 방식입니다.

## 1. 쓰레기(per table)

각 서비스마다 별도의 테이블을 생성하는 방식입니다. 서비스가 10개인 경우, 각각의 서비스에 대해 파일 정보를 저장하는 테이블을 10개 만듭니다.

-   **예시**:
    -   파일 반복
        -   `file_path varchar(255) not null`
        -   `file_name varchar(255) not null`

## 2. 더 쓰레기(single table)

서비스와 관련된 모든 파일 정보를 하나의 테이블에 저장하는 방식입니다. 서비스가 10개라도, 단 하나의 테이블(`tbl_file`)을 사용하여 모든 파일 정보를 관리합니다.

-   **예시**:
    -   `tbl_file`
        -   `category`
        -   외래키(Foreign Key) 10개

## 3. Inheritance(상속)

슈퍼테이블과 서브테이블을 사용하는 상속 구조입니다.  
 공통된 속성은 부모 테이블(슈퍼테이블)에 저장하고, 각 서비스의 특정 속성은 자식 테이블(서브테이블)에 저장합니다.

-   **예시**:
    -   서비스 10개
        -   부모 테이블 1개: 공통 속성 저장: 교집합
        -   자식 테이블 10개: 각 서비스의 특정 속성 저장 (각 자식 테이블의 기본키가 부모 테이블의 외래키가 됩니다.) (pk, fk) => pk 가 fk다

이러한 접근 방식은 각각의 장단점을 가지며, 프로젝트의 요구사항과 데이터의 특성에 따라 적절한 방식을 선택해야 합니다.

## DML(Data Manipulation Language): 데이터 조작어

1. **select**: 조회(검색)

    ```sql
    select [컬럼명1, ... ]
    from [테이블명]
    where [조건식];
    ```

2. **insert**

    - 컬럼을 생략할 수 있다.
        ```sql
        insert into [테이블명]
        ([컬럼명1], [컬럼명2], ...)
        values ([값1], [값2], ...);
        ```
    - 모든 값을 전부 작성한다.
        ```sql
        insert into [테이블명]
        values ([값1], [값2], ...);
        ```

3. **update**

    ```sql
    update [테이블명]
    set [기존 컬럼명1] = [새로운 값1],  [기존 컬럼명2] = [새로운 값2], ...
    where [조건식];
    ```

4. **delete**
    ```sql
    delete from [테이블명]
    where [조건식];
    ```

### 조건식

-   `>, <`: 초과, 미만
-   `>=, <=`: 이상, 이하
-   `=`: 같다
-   `<>`, `!=`, `^=`: 같지 않다
-   `AND`: 둘 다 참이면 참
-   `OR`: 둘 중 하나라도 참이면 참

## JOIN

여러 테이블에 흩어져 있는 정보 중 사용자가 필요한 정보만 가져와서 가상의 테이블처럼 만들고 결과를 보여주는 것.

-   **내부 조인(inner join)**

    ```sql
    from [테이블명]
    inner join [테이블명]
    on 조건식
    ```

-   **외부 조인(outer join)**
    -   **left outer join**: 선행 테이블의 모든 정보를 가져오고 싶을 때 사용한다.
    -   **right outer join**: 후행 테이블의 모든 정보를 가져오고 싶을 때 사용한다.

### 옵티마이저(Optimizer)

SQL을 가장 빠르고 효율적으로 수행할 최적의 처리경로(최저비용)을 생성해주는 DBMS 내부의 핵심 엔진.

-   **옵티마이저의 SQL 최적화 과정**
    1. 사용자가 작성한 쿼리를 수행하기 위해, 실행 계획을 찾는다.
    2. 데이터 딕셔너리에 미리 수집해 놓은 오브젝트 통계 및 시스템 통계 정보를 이용해서 각 실행계획의 예상 비용을 산정한다.
    3. 각 실행계획을 비교해서 최저 비용을 갖는 하나를 선택하여 실행한다.

### 옵티마이저의 종류

1. 규칙기반 옵티마이저(RBO)
2. 비용기반 옵티마이저(CBO)

## TCL(Transaction Control Language): 트랜잭션 제어어

-   **트랜잭션**: 하나의 작업(서비스)에 필요한 쿼리를 묶은 단위.
-   **commit**: 모든 작업을 확정하는 명령어.
-   **rollback**: 이전 커밋 시점으로 이동.

## DCL

-   **grant(권한부여)**
-   **revoke(권한제거)**

## VIEW

기존의 테이블은 그대로 놔둔 채 필요한 컬럼들 및 새로운 컬럼을 만든 가상 테이블. 실제 데이터가 저장되는 것은 아니지만 VIEW를 통해서 데이터를 관리할 수 있다.

-   **독립성**: 다른 곳에서 접근하지 못하도록 하는 성질.
-   **편리성**: 긴 쿼리문을 짧게 만드는 성질.
-   **보안성**: 기존의 쿼리문이 보이지 않는다.

### VIEW 문법

```sql
create view [뷰 이름] as (select 쿼리문);
```
