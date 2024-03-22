# 전체 데이터베이스 조회
show databases;

# test 데이터베이스 사용
use test;

# 회원 테이블 생성
create table tbl_member(
    member_name varchar(255),
    member_age int
);


show tables;

drop table tbl_member;
show tables;
/*
    자동차 테이블 생성
    1. 자동차 번호
    2. 자동차 브랜드
    3. 출시 날짜
    4. 색상
    5. 가격
*/
create table tbl_car(
    number bigint primary key,
    brand varchar(255),
    release_date date,
    color varchar(255),
    price int
);

show tables;
drop table tbl_car;

/*
    동물 테이블 생성
    1. 번호
    2. 종류 type
    3. 먹이
*/
create table tbl_animal(
    number bigint primary key,
    type varchar(255) not null unique,
    feed varchar(255)
);

show tables;

drop table tbl_car, tbl_animal;


/*
   회원          주문              상품
   ----------------------------------------
   번호PK      번호PK          번호PK
   ----------------------------------------
   아이디U, NN   날짜NN          이름NN
   비밀번호NN   회원번호FK, NN   가격D=0
   이름NN      상품번호FK, NN   재고D=0
   주소NN
   이메일
   생일
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_product(
    id bigint primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0
);

create table tbl_order(
    id bigint primary key,
    order_date datetime default current_timestamp,
    user_id bigint not null,
    product_id bigint not null,
    constraint fk_order_user foreign key(user_id)
    references tbl_user(id),
    constraint fk_order_product foreign key(product_id)
    references tbl_product(id)
);

drop table tbl_order;
drop table tbl_user;
drop table tbl_product;

show tables;

/*
    1. 요구사항 분석
        꽃 테이블과 화분 테이블 2개가 필요하고,
        꽃을 구매할 때 화분도 같이 구매합니다.
        꽃은 이름과 색상, 가격이 있고,
        화분은 제품번호, 색상, 모양이 있습니다.
        화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/

create table tbl_flower(
    id bigint primary key,
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_id bigint not null,
    constraint fk_pot_flower foreign key(flower_id)
    references tbl_flower(id)
);

drop table tbl_pot;
drop table tbl_flower;

show tables;


/*
    복합키(조합키): 하나의 PK에 여러 컬럼을 설정한다.
*/
create table tbl_flower(
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0,
    primary key(name, color)
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_name varchar(255) not null,
    flower_color varchar(255) not null,
    constraint fk_pot_flower foreign key(flower_name, flower_color)
    references tbl_flower(name, color)
);

drop table tbl_pot;
drop table tbl_flower;

show tables;

/*
    1. 요구사항 분석
        안녕하세요, 동물병원을 곧 개원합니다.
        동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
        보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
        보호자는 이름, 나이, 전화번호, 주소가 필요하고
        동물은 병명, 이름, 나이, 몸무게가 필요합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/

create table owner(
    id bigint primary key,
    name varchar(255) not null,
    age int default 0,
    phone varchar(255) not null,
    address varchar(255) not null
);

alter table owner rename tbl_owner;

create table pet(
    id bigint primary key,
    name varchar(255) default '사랑',
    ill_name varchar(255) not null,
    age int default 0,
    weight decimal(3, 2) default 0.0,
    owner_id bigint,
    constraint fk_pet_owner foreign key(owner_id)
                references tbl_owner(id)
);

alter table pet rename tbl_pet;

drop table tbl_pet;
drop table tbl_owner;

show tables;

/*
    1. 요구사항 분석
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/
create table tbl_car(
    id bigint primary key,
    brand varchar(255) not null,
    model varchar(255) not null,
    price bigint default 0,
    release_date date default (current_date)
);

create table tbl_car_owner(
    id bigint primary key,
    name varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null
);

create table tbl_car_registration(
    id bigint primary key,
    car_id bigint not null,
    car_owner_id bigint not null,
    constraint fk_car_registration_car foreign key(car_id)
                                 references tbl_car(id),
    constraint fk_car_registration_car_owner foreign key(car_owner_id)
                                 references tbl_car_owner(id)
);

drop table tbl_car_registration;
drop table tbl_car;
drop table tbl_car_owner;

show tables;

/*
    요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(tbl_user)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_post(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    create_date datetime default current_timestamp,
    user_id bigint not null,
    constraint fk_post_user foreign key(user_id)
                     references tbl_user(id)
);

create table tbl_reply(
    id bigint primary key,
    content varchar(255) not null,
    user_id bigint not null,
    post_id bigint not null,
    constraint fk_reply_user foreign key(user_id)
                     references tbl_user(id),
    constraint fk_reply_post foreign key(post_id)
                     references tbl_post(id)
);

drop table tbl_reply;
drop table tbl_post;
drop table tbl_user;

show tables;

/*
    요구사항

    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_file(
    id bigint primary key,
    file_path varchar(255) default '/upload/',
    file_name varchar(255),
    is_main varchar(255) default 'ELSE',
    user_id bigint,
    constraint fk_file_user foreign key(user_id)
                     references tbl_user(id)
);

drop table tbl_file;
drop table tbl_user;

show tables;



/*
   회원          주문              상품
   ----------------------------------------
   번호PK      번호PK          번호PK
   ----------------------------------------
   아이디U, NN   날짜NN          이름NN
   비밀번호NN   회원번호FK, NN   가격D=0
   이름NN      상품번호FK, NN   재고D=0
   주소NN
   이메일
   생일
*/
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_product(
    id bigint primary key,
    name varchar(255) not null,
    price int default 0,
    stock int default 0
);

create table tbl_order(
    id bigint primary key,
    order_date datetime default current_timestamp,
    user_id bigint not null,
    product_id bigint not null,
    constraint fk_order_user foreign key(user_id)
    references tbl_user(id),
    constraint fk_order_product foreign key(product_id)
    references tbl_product(id)
);

/*
    1. 요구사항 분석
        꽃 테이블과 화분 테이블 2개가 필요하고,
        꽃을 구매할 때 화분도 같이 구매합니다.
        꽃은 이름과 색상, 가격이 있고,
        화분은 제품번호, 색상, 모양이 있습니다.
        화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

    2. 개념 모델링
    --------------------------------------------------------
    꽃                    화분
    --------------------------------------------------------
    이름                  제품번호
    색상                  색상
    가격                  모양
                          꽃

    3. 논리 모델링
    --------------------------------------------------------
    꽃tbl                 화분tbl
    --------------------------------------------------------
    이름(pk, u ,nn)       제품번호 (pk, u,nn)
    색상(nn d= black)     색상(nn, d = red)
    가격(nn, d=0)         모양(nn)
    화분번호(fk, nn)       꽃이름(fk, nn)????

    4. 물리 모델링
    tbl_flower                                          tbl_pot
    name: varchar(255) unique not null                  number: bigint unique not null
    color: varchar(255) not null default "black"        color: varchar(255) not null default "red"
    price: bigint not null default 0                    shape: varchar(255) not null
    pot_number: bigint not null                         flower_name: varchar(255)

    5. 구현

*/
# create table tbl_flower(
#       name varchar(255) primary key not null,
#       color varchar(255) not null default 'black',
#       price bigint not null default 0,
#       pot_number bigint not null
# );
#
# create table tbl_pot(
#       number bigint primary key not null,
#       color varchar(255) not null default 'red',
#       shape varchar(255) not null,
#       flower_name varchar(255) not null
# );
#
# alter table tbl_flower add constraint fk_flower_pot foreign key(pot_number) references tbl_pot(number);
# alter table tbl_pot add constraint fk_pot_flower foreign key(flower_name) references tbl_flower(name);
#
# drop table tbl_flower, tbl_pot;
# show tables;

/*
=============================== teacher
*/
/*
create table tbl_flower(
    id bigint primary key,
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_id bigint not null,
    constraint fk_pot_flower foreign key(flower_id) references tbl_flower(id)
);
drop table tbl_pot,tbl_flower;
*/

/*
    복합키(조합키): 하나의 PK에 여러 컬럼을 설정한다.
*/

/*
create table tbl_flower(
    name varchar(255) not null,
    color varchar(255) not null,
    price int default 0,
    primary key(name, color)
);

create table tbl_pot(
    id bigint primary key,
    color varchar(255) not null,
    shape varchar(255) not null,
    flower_name varchar(255) not null,
    flower_color varchar(255) not null,
    constraint fk_pot_flower foreign key(flower_name, flower_color) references tbl_flower(name, color)
);

show tables;
*/


/*
    1. 요구사항 분석
        안녕하세요, 동물병원을 곧 개원합니다.
        동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
        보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
        보호자는 이름, 나이, 전화번호, 주소가 필요하고
        동물은 병명, 이름, 나이, 몸무게가 필요합니다.

    2. 개념 모델링
    동물                       보호자                             동물병원
    name 이름                  name 보호자 이름
    disease 병명               age 보호자 나이
    age 나이                   phone 보호자 번호
    weight 몸무게              address 보호자 주소
    guardian 보호자            a_name 동물이름

    3. 논리 모델링
    동물                                          보호자                                     동물병원
    name 이름 (pk, not null)                      name 보호자 이름(pk, not null)
    disease 병명 (not null)                       age 보호자 나이(not null)
    age 나이 (d =None, not null)                  phone 보호자 번호(pk,unique, not null)
    weight 몸무게(not null)                        address 보호자 주소(not null)
    guardian 보호자(fk, not null, d =보호소)        a_name 동물이름
    guardian_phone 보호자(fk, not null, d =보호소)

    4. 물리 모델링
    tbl_animal                                      tbl_guardian
    name: varchar, primary key, not null            name: varchar, primary key, not null
    disease: varchar, not null                      age: int, not null
    age: int ,not null, default 0                   phone: bigint primary key, not null,unique
    weight: ing, not null                           address: varchar, not null
    guardian: pk, fk, varchar, not null             a_name: varchar, not null
    guardian_phone:pk, fk, varchar, not null

    5. 구현
*/


# create table tbl_owner(
#     id bigint primary key,
#     name varchar(255) not null,
#     age int,
#     phone varchar(255) not null,
#     address varchar(255) not null
# );
#
# create table tbl_pet(
#     id bigint primary key,
#     name varchar(255) default '사랑',
#     ill_name varchar(255) not null,
#     age int default 0,
#     weight decimal(3, 2) default 0.0,
#     owner_id bigint,
#     constraint fk_pet_owner foreign key (owner_id) references tbl_owner(id)
# );


/*
1. 요구사항 분석
    안녕하세요. 중고차 딜러입니다.
    이번에 자동차와 차주를 관리하고자 방문했습니다.
    자동차는 여러 명의 차주로 히스토리에 남아야 하고,
    차주는 여러 대의 자동차를 소유할 수 있습니다.
    그래서 우리는 항상 등록증 (Registration)을 작성합니다.
    자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
    차주는 이름, 전화번호, 주소가 필요합니다.

2. 개념 모델링
    자동차                     차주                         등록증
    자동차번호                  차주아이디                    등록증번호
    브랜드                     이름                         차주아이디
    모델명                     전화번호                      자동차 번호
    가격                       주소                         등록날짜
    출시날짜

3. 논리 모델링
    자동차(table)                        차주(table)                  등록증(table)
    자동차번호(pk, int)                   차주아이디(pk, varchar)       등록증번호(pk, bigint)
    브랜드(varchar, not null)            이름 (varchar,not null)      차주아이디 (fk, varchar, not null)
    모델명 (varchar, not null)           전화번호(varchar,not null)    자동차 번호(fk, int, not null)
    가격(bigint,not null)               주소(varchar,not null)       등록날짜(datetime, not null)
    출시날짜(date, not null)

4. 물리 모델링
    tbl_car                                 tbl_owner                                   tbl_license
    number: int primary key                 owner_id: varchar(255) primary key          li_number: bigint primary key
    brand: varchar not null                 name: varchar not null                      owner_id: fk, varchar, not null
    model: varchar not null                 phone: varchar, not null                    car_number: fk, int, not null
    price: bigint not null                  address: varchar, not null                  regi_date: datetime, not null
    open_date: date, not null
5. 구현
*/

/*
create table tbl_car(
    number int primary key,
    brand varchar(255) not null,
    model varchar(255) not null,
    price bigint not null,
    release_date date default (current_date)
);

create table tbl_owner(
    owner_id varchar(255) primary key,
    name varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null
);

create table tbl_car_registration(
    li_number bigint primary key,
    owner_id varchar(255) not null,
    car_number int not null,
    regi_date datetime not null,
    constraint fk_owner_id foreign key(owner_id) references tbl_owner(owner_id),
    constraint fk_car_number foreign key(car_number) references tbl_car(number)
);
*/

/*
1. 요구사항 분석

    요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(TBL_USER)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.

2. 개념 모델링
    게시판                    회원                      게시글
    아이디                    아이디                      아이디
    게시글 제목                이름                       게시글 제목
    게시글 내용                                          게시글 내용
    작성한 시간                                          댓글
    작성자                                              댓글 작성자

3. 논리 모델링
회원                               게시글                                게시판
아이디(pk, varchar)                게시글 아이디(pk, bigint)              게시판 아이디(pk, bigint)
이름(varchar, nn)                  게시글 제목(varchar, nn)              게시글 제목(varchar, nn, fk)
                                  게시글 내용(varchar, d="")            게시글 내용(varchar, d ='', fk)
                                  댓글(varchar)                        작성한 시간(date, default = current_date)
                                  댓글 작성자(varchar, fk)               작성자(varchar, fk)

4. 물리 모델링
tbl_user
user_id: varchar primary key
name: varchar not null

tbl_text
id: bigint primary key
name: varchar not null
content: varchar default ""
comment: varchar default ""
comment_user: varchar fk tbl user_id

tbl_board
id: bigint primary key
content: varchar default ""
comment: varchar default ""
regi_date: date default (current_date)
writer: varchar fk tbl user_id



요구 사항
커뮤니티 게시판을 만들고 싶어요.
게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
작성자는 회원(TBL_USER)정보를 그대로 사용해요.
댓글에도 작성자가 필요해요.

5. 구현
*/
create table tbl_user(
    user_id varchar(255) primary key,
    user_name varchar(255) not null,
    password varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);
/*
create table tbl_reply(
    content varchar(255) primary key,
    user_id varchar(255),
    test_unique varchar(255) unique,
    constraint fk_reply_user foreign key (user_id) references tbl_user(user_id)
);

create table tbl_post(
    name varchar(255) primary key,
    content varchar(255),
    date date default (current_time),
    user_id varchar(255) not null,
    reply_content varchar(255) not null,
    test varchar(255),
    constraint fk_post_user foreign key (user_id) references tbl_user(user_id),
    constraint fk_post_reply foreign key (reply_content) references tbl_reply(content),
    constraint fk_post_reply2 foreign key (test) references tbl_reply(test_unique)
);
*/


# drop table tbl_reply;
# drop table tbl_user;
# drop table tbl_post;



/*
create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);
*/

/*
1. 요구사항 분석

    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

2. 개념 모델링

3. 논리 모델링

4. 물리 모델링

5. 구현
*/
/*
create table tbl_user(
    user_id varchar(255) primary key,
    user_name varchar(255) not null,
    password varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_profile(
    image_name varchar(255) not null primary key,
    job varchar(255) not null
);

create table tbl_my_page(
    id varchar(255) primary key,
    name varchar(255) not null,
    image varchar(255) not null,
    constraint fk_my_page_user foreign key (name) references tbl_user(user_id),
    constraint fk_my_page_profile foreign key (image) references tbl_profile(image_name)
);
*/


# drop table tbl_users;
# drop table tbl_profile;
# drop table tbl_my_page;


/*
    요구사항
    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적이 모두 기록됩니다.

2. 개념
    1) 학생
        - 학번
        - 이름
        - 전공
        - 학년
    2) 교수
        - 교수 번호
        - 이름
        - 전공
        - 직위
    3) 과목
        - 과목번호
        - 과목명
        - 학점
    4) 학생관리 시스템
        - 학번
        - 교수번호
        - 과목번호
        - 성적

3. 논리
    1) 학생
        - 학번 pk, int
        - 이름 varchar, not null
        - 전공 varchar not null
        - 학년 int varchar
    2) 교수
        - 교수 번호 pk int
        - 이름 varchar not null
        - 전공 varchar not null
        - 직위 varchar not null
    3) 과목
        - 과목번호 pk int
        - 과목명 varchar not null
        - 학점 int not null
    4) 학생관리 시스템
        - 등록번호 pk, int
        - 학번 fk
        - 교수번호 fk
        - 과목번호 fk
        - 성적 int not null d = 0

4. 물리
    1) tbl_student
        - s_number int primary key
        - s_name varchar(255) not null
        - major varchar(255) not null
        - grade int varchar(255)
    2) tbl_professor
        - p_number int primary key
        - name varchar(255) not null
        - major varchar(255) not null
        - spot varchar(255) not null
    3) 과목
        - sub_number int primary key
        - sub_name varchar(255) not null
        - sub_score int not null
    4) tbl_system
        - id int primary key
        - s_number int not null, fk
        - p_number int not null, fk
        - sub_number int not null, fk
        - score int not null default 0

5. 구현
*/

create table tbl_student(
    s_number int primary key,
    s_name varchar(255) not null,
    major varchar(255) not null,
    grade int not null
);

create table tbl_professor(
    p_number int primary key,
    name varchar(255) not null,
    major varchar(255) not null,
    spot varchar(255) not null
);

create table tbl_subject(
    sub_number int primary key,
    sub_name varchar(255) not null,
    sub_score int not null
);

create table tbl_system(
    id bigint primary key,
    s_number int not null,
    p_number int not null,
    sub_number int not null,
    score int not null default 0,
    constraint fk_system_student foreign key (s_number) references tbl_student(s_number),
    constraint fk_system_professor foreign key (p_number) references tbl_professor(p_number),
    constraint fk_system_subject foreign key (sub_number) references tbl_subject(sub_number)
);


/*
    요구사항
    대카테고리, 소카테고리가 필요해요

2. 개념
    1) 대카테고리
        - 카테고리명
        - 생성날짜
    2) 소카테고리
        - 카테고리명
        - 생성날짜
        - 대카테고리 참조
3. 논리
    1) 대카테고리
        - 카테고리명 varchar, pk
        - 생성날짜 datetime d=current_timestamp
    2) 소카테고리
        - 카테고리명 varchar pk
        - 생성날짜 datetime d=current_timestamp
        - 대카테고리 참조 varchar fk
4. 물리
    1) tbl_big_category
        - category varchar primary key
        - create_date datetime default (current_timestamp)
    2) 소카테고리
        - s_category varchar primary key
        - create_date datetime default (current_timestamp)
        - big_category varchar fk
5. 구현
*/

create table tbl_big_category(
    category varchar(255) primary key,
    create_date datetime default(current_timestamp)
);

create table tbl_small_category(
    s_category varchar(255) primary key,
    create_date datetime default(current_timestamp),
    big_category varchar(255),
    constraint fk_small_big foreign key (big_category) references tbl_big_category(category)
);


/*
    요구사항
    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

2. 개념
    1) 회원
        - 아이디
        - 등급
        - 이름
    2) 회의실 리스트
        - 회의실 이름

    3) 예약 가능 시간
        - 예약 가능 시간

    3) 회의실 예약 서비스
        - 아이디(순번)
        - 예약 시간
        - 회의실 이름
        - 맴버 아이디

3. 논리
    1) 회원
        - 아이디 pk varchar
        - 등급 varchar not null
        - 이름 varchar not null
    2) 회의실 리스트
        - 회의실 이름 pk varchar not null

    3) 예약 가능 시간
        - 예약 가능 시간 pk time default (current_time)

    3) 회의실 예약 서비스
        - 아이디(순번) int pk
        - 예약 시간 time default (current_time) fk
        - 회의실 이름 varchar fk
        - 맴버 아이디 varchar fk
4. 물리
    1) tbl_member
        - member_id varchar primary key
        - grade varchar not null
        - member_name varchar not null
    2) tbl_conference_room
        - room_name varchar not null primary key

    3) tbl_part_time
        - reserv_time time default (current_time) primary key

    3) tbl_conference_system
        - id int primary key
        - reserv_time time default (current_time) fk
        - room_name varchar fk
        - member_id varchar fk
5. 구현
*/


create table tbl_member(
    member_id varchar(255) primary key,
    grade varchar(255) not null,
    member_name varchar(255) not null
);

create table tbl_conference_room(
    room_name varchar(255) primary key
);
create table tbl_part_time(
    part_time time default (current_time) primary key
);

create table tbl_conference_system(
    id bigint primary key,
    using_time time default (current_time),
    room_name varchar(255) not null,
    member_id varchar(255) not null,
    constraint fk_system_member foreign key (member_id) references tbl_member(member_id),
    constraint fk_system_room foreign key (room_name) references tbl_conference_room(room_name),
    constraint fk_system_part_time foreign key (using_time) references tbl_part_time(part_time)
);



/*
    요구사항

    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.

2. 개념
    1) 아이들
        - 아이들 아이디
        - 이이들 이름
        - 아이들 나이
        - 아이들 성별
    2) 부모님
        - 부모님 아이디
        - 부모님 이름
        - 부모님 나이
        - 부보님 주소
        - 부모님 전화번호
        - 부모님 성별
        - 부모님 자녀

    3) 체험학습 리스트
        - 체험학습 이름
        - 체험학습 내용

    4) 이미지 리스트
        - 이미지 번호
        - 이미지 명칭
        - 체험학습 이름

    4) 체험학습 예약 시스템
        - 체험 학습 예약 번호
        - 체험 학습 이름
        - 아이들 아이디
        - 부모님 아이디
3. 논리
    1) 아이들
        - 아이들 아이디 bigint pk
        - 이이들 이름 varchar not null
        - 아이들 나이 int not null
        - 아이들 성별 varchar not null
    2) 부모님
        - 부모님 아이디 bigint pk
        - 부모님 이름 varchar not null
        - 부모님 나이 int not null
        - 부보님 주소 varchar not null
        - 부모님 전화번호 varchar not null
        - 부모님 성별 varchar not null
        - 부모님 자녀 아이디 bigint fk

   3) 체험학습 리스트
        - 체험학습 이름 varchar pk
        - 체험학습 내용 varchar pk

    4) 이미지 리스트
        - 이미지 번호 bigint pk
        - 이미지 명칭 varchar
        - 체험학습 이름 varchar not null

    4) 체험학습 예약 시스템
        - 체험 학습 예약 번호 bigint pk
        - 체험 학습 이름 varchar fk
        - 아이들 아이디 bigint fk
        - 부모님 아이디 bigint fk
4. 물리
    1) tbl_children
        - c_id bigint primary key
        - name varchar(255) not null
        - age int not null
        - gender varchar(255) not null
    2) 부모님
        - p_id bigint primary key
        - name varchar(255) not null
        - age int not null
        - address varchar(255) not null
        - phone_number varchar(255) not null
        - gender varchar(255) not null
        - c_id bigint fk

    3) tbl_out_study
        - study_name varchar(255) primary key
        - content varchar(255) not null

    4) tbl_images
        - image_id bigint pk
        - image_name varchar(255) not null
        - study_name varchar(255) not null fk

    4) tbl_out_system
        - o_id bigint pk
        - study_name varchar(255) fk
        - c_id bigint fk
        - p_id bigint fk
5. 구현
*/
create table tbl_children(
    c_id bigint primary key,
    name varchar(255) not null,
    age int not null,
    gender varchar(255) not null
);
create table tbl_parent(
    p_id bigint primary key,
    name varchar(255) not null,
    age int not null,
    address varchar(255) not null,
    phone_number varchar(255) not null,
    gender varchar(255) not null,
    c_id bigint,
    constraint fk_parents_children foreign key (c_id) references tbl_children(c_id)
);
create table tbl_out_study(
    study_name varchar(255) not null primary key ,
    content varchar(255) not null
);
create table tbl_images(
    image_id bigint primary key,
    image_name varchar(255) not null,
    study_name varchar(255) not null,
    constraint fk_images_study foreign key (study_name) references tbl_out_study(study_name)
);

create table tbl_out_system(
    o_id bigint primary key ,
    study_name varchar(255) not null,
    c_id bigint not null,
    p_id bigint not null,
    constraint fk_system_study foreign key (study_name) references tbl_out_study(study_name),
    constraint fk_system_children foreign key (c_id) references tbl_children(c_id),
    constraint fk_system_parents foreign key (p_id) references tbl_parent(p_id)
);
drop table tbl_children, tbl_out_study, tbl_out_system, tbl_parent;
/*
    요구사항

    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

2. 개념
    1) 회사
        - 대표변호
        - 회사이름
        - 주소
        - 기업 종류

    2) 광고 리스트
        - 제목
        - 내용
        - 카테고리

    3) 광고
        - 광고 번호
        - 회사번호
        - 광고 이름

3. 논리
    1) 회사
        - 대표변호 pk varchar
        - 회사이름 varchar not null
        - 주소   varchar not null
        - 기업 종류 varchar not null

    2) 광고 리스트
        - 제목 pk varchar
        - 내용 content
        - 카테고리 varchar not null

    3) 광고
        - 광고 번호 pk bigint
        - 회사대표번호 varchar
        - 광고 이름 varchar

4. 물리
    1) tbl_company
        - c_number varchar(255) primary key
        - c_name varchar(255) not null
        - address varchar(255) not null
        - kind varchar(255) not null

    2) 광고 리스트
        - a_name varchar primary key
        - content content
        - category varchar(255) not null

    3) 광고
        - id bigint primary key
        - c_name varchar(255)
        - a_name varchar(255)

5. 구현
*/

create table tbl_company(
    c_number varchar(255) primary key,
    c_name varchar(255) not null,
    address varchar(255) not null,
    kind varchar(255) not null
);

create table tbl_advertise_list(
    a_name varchar(255) primary key,
    content varchar(255),
    category varchar(255) not null
);
create table tbl_advertise(
    id bigint primary key ,
    c_name varchar(255) not null,
    a_name varchar(255) not null,
    constraint fk_advertise_company foreign key (c_name) references tbl_company(c_number),
    constraint fk_advertise_list foreign key (a_name) references  tbl_advertise_list(a_name)
);



/*
    요구사항

    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

2. 개념
    1) 음료수
        - 음료
        - 당첨번호
    2) 상품
        - 상품
        - 당첨번호
    3) 고객
        - 핸드폰 번호
        - 고객 이름
        - 주소
    4) 배송
        - 배송번호
        - 이름
        - 핸드폰번호
        - 상품
        - 배송유/무
3. 논리
    1) 음료수
        - 음료 varchar pk
        - 당첨번호 int unique
    2) 상품
        - 상품 varchar pk
        - 당첨번호 fk int
    3) 고객
        - 핸드폰 번호 pk varchar
        - 고객 이름 varchar
        - 주소 varchar
    4) 배송
        - 배송번호 bigint pk
        - 이름 varchar not null
        - 핸드폰번호 varchar not null fk
        - 상품 varchar not null fk
        - 배송유/무 varchar d = 'going'
4. 물리
    1) tbl_beverage
        - beverage_name varchar(255) primary key
        - luckey_number int unique
    2) tbl_prize
        - prize varchar(255) primary key
        - luckey_number int fk
    3) tbl_customer
        - phone_number varchar(255) primary key
        - name varchar(255)
        - address varchar(255)
    4) tbl_post
        - post_id bigint primary key
        - name varchar(255) not null
        - phone_number varchar(255) not null fk
        - prize varchar(255) not null fk
        - post varchar(255) default 'going'
5. 구현
*/
create table tbl_beverage(
    beverage_name varchar(255) primary key,
    luckey_number int unique
);

create table tbl_prize(
    prize varchar(255) primary key ,
    luckey_number int,
    constraint fk_prize_beverage foreign key(luckey_number) references tbl_beverage(luckey_number)
);

create table tbl_customer(
    phone_number varchar(255) primary key,
    name varchar(255) not null,
    address varchar(255) not null
);
create table tbl_post(
    post_id bigint primary key,
    name varchar(255) not null,
    phone_number varchar(255) not null,
    prize varchar(255) not null,
    post varchar(255) default 'GOING',
    constraint fk_post_customer foreign key (phone_number) references tbl_customer(phone_number),
    constraint fk_post_prize foreign key (prize) references tbl_prize(prize)
);
/*
    요구사항

    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
    상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

2. 개념
    1) 기업
        - 대표 번호
        - 기업 이름
        - 주소
    2) 카드
        - 카드 번호
        - 카드 이름
        - 카드 회사
    3) 사용자
        - 사용자 아이디
        - 사용자 이름
        - 사용자 주소
        - 핸드폰 번호
        - 카드 번호
    4) 상품
        - 상품 아이디
        - 상품 이름
        - 상품 가격
        - 상품 재고
    5) 결제 정보
        - 결제 번호
        - 회사번호
        - 사용자 아이디
        - 상품 번호
        - 카드 번호

3. 논리
    1) 기업
        - 대표 번호 varchar pk
        - 기업 이름 varchar
        - 주소 varchar
    2) 카드
        - 카드 번호 varchar pk
        - 카드 이름 varchar not null
        - 카드 회사 varchar not null
    3) 사용자
        - 사용자 아이디 bigint pk
        - 사용자 이름 varchar not null
        - 사용자 주소 varchar d = 'where'
        - 핸드폰 번호 varchar not null unique
        - 카드 번호 fk varchar
    4) 상품
        - 상품 아이디 bigint pk
        - 상품 이름 varchar not null
        - 상품 가격 varchar not null
        - 상품 재고 varchar not null
    5) 결제 정보
        - 결제 번호 pk bigint
        - 회사번호 varchar fk
        - 사용자 아이디 varchar fk
        - 상품 번호 varchar fk
        - 카드 번호 varchar fk
4. 물리
    1) tbl_company
        - c_number varchar primary key
        - c_name varchar(255)
        - c_address varchar(255)
    2) tbl_card
        - card_number varchar(255) primary key
        - card_name varchar(255) not null
        - card_company varchar(255) not null
    3) tbl_user
        - user_id bigint primary key
        - name varchar(255) not null
        - address varchar(255) default '어딘가'
        - phone_number varchar(255) not null unique
        - card_number varchar(255)  fk
    4) tbl_product
        - p_id bigint primary key
        - p_name varchar(255) not null
        - p_price varchar(255) not null
        - p_stock varchar(255) not null
    5) tbl_pay
        - pay_id  bigint primary key
        - c_company_number varchar(255) not nullfk
        - user_id bigint fk
        - p_id bigint fk
        - card_number varchar(255) fk
5. 구현
*/
create table tbl_company2(
    c_number varchar(255) primary key,
    c_name varchar(255) not null,
    c_address varchar(255) unique
);
create table tbl_card(
    card_number varchar(255) primary key,
    card_name varchar(255) not null,
    card_company varchar(255) not null
);
create table tbl_user(
    user_id bigint primary key,
    name varchar(255) not null,
    address varchar(255) default '어딘가',
    phone_number varchar(255) not null unique,
    card_number varchar(255) not null,
    constraint fk_user_card foreign key (card_number) references tbl_card(card_number)

);
create table tbl_product(
    p_id bigint primary key,
    p_name varchar(255) not null,
    p_price int default 0,
    p_stock bigint not null
);
create table tbl_pay(
    pay_id bigint primary key,
    c_company_number varchar(255),
    user_id bigint,
    p_id bigint,
    card_number varchar(255),
    constraint fk_pay_company foreign key (c_company_number) references tbl_company2(c_number),
    constraint fk_pay_user foreign key (user_id) references tbl_user(user_id),
    constraint fk_pay_product foreign key (p_id) references tbl_product(p_id),
    constraint fk_pay_card foreign key (card_number) references tbl_card(card_number)
);