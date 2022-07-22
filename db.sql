create database exam; 
use exam;

 create table member(									
	 id varchar(20) PRIMARY KEY,								
	 password varchar(30) NOT NULL,						
	 name varchar(5) ,							
     birth date ,
     gender varchar(1)    	
 );
 -- member 테이블에 주소 컬럼 추가(추가:add)
 alter table member add column address varchar(30);		

-- member 테이블에 비밀번호 컬럼의 글자수를 20자로 변경( 변경: modify )
 alter table member modify column password varchar(20) not null;

-- member 테이블 제거
 drop table member; 

 create table member2(
    id varchar(10) primary key,
    password varchar(20) not NULL,
    address varchar(30) not NULL,
	phon varchar(11),
    email varchar(30),
    name varchar(5),
    age int(3)
    );
    
    --          테이블 명 (                   컬럼명               )
    insert into member2 (id, password, address, phon, email, name, age)
    values('ac123','1234','울산','010','okjpo@naver.com','정자바',10);
    
	insert into member2 (id, password, address)
	 values('c123','1234','울산');
 -- select 컬럼명 from 테이블명 (*는 모든 컬럼명을 의미)
     select*from member2;
    
	-- member 테이블 중에서 아이디가 'c123'인 데이터의 모든 컬럼을 조회 
   select * from member2 where id='c123';
    
    -- 데이터 수정(update) -> 조건이 없으면 전체가 바뀜 (하나만 바꿀려면 조건을 추가해야함)
    -- 개명(정자바->정코딩)
   
      select * from member2;
     update member2  set name = '정자바' where id = 'c123';

	-- 비밀번호 변경  
	 select * from member2; 
    update member2 set  password='56789' where id = 'c123';
   
   -- 아이디가 'abc123'인 데이터는 member 테이블에서 삭제
   -- delete from 테이블명
   -- where 조건식
   delete from member2 where id='abc123';
   select*from member2;
   
   -- insert 하나로 여러개의 값을 넣을때  
   insert into member2 (id,password,address)
   value('aaa','1234','서울') , 
  ('bbb','5678','부산');


-- 또 다른 예시(게시판)
create table board(
		bno 		int				auto_increment		primary key,
		title 		varchar(30),
        content 	varchar(150),
        writer	 	varchar(5),
        regdate 	datetime 		default now(),
        cnt 		int				default 0,	
        id 			varchar(10)
);
-- alter문으로 foreign key 설정
-- alter table 테이블명(참조대면테이블)  add constraint 제약조건명(아무거나 줘도됨)
-- id에 제약조건(foreign key)을 추가하는것
-- foreign key (자식 테이블 컬럼명) references 부모테이블 명(부모테이블 컬럼명)

select * from member2;
desc board;

alter table board add constraint boardid_fk 
foreign key(id)	references	member2(id)
on delete cascade		-- 부모테이블 데이터 삭제시 자식테이블 데이터도 자동 삭제 
on update cascade		-- 부모테이블 데이터 변경시 자식테이블 데이터도 자동 변경
;

alter table board drop constraint boardid_fk; 

select*from board;
-- delete from board;
insert into	board(title, content, writer,id)
values
('안녕','운영진입니다','운영진', 'admin'),
('제목','내용추가','정자바', 'aaaa1234');

delete from member2 where id='aaa123';




       


   