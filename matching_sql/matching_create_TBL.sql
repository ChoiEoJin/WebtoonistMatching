-- drop table tb_location;
-- drop table tb_map_po_gen;
-- drop table tb_map_user_po;
-- drop table tb_portfolio;
-- drop table tb_genre;
-- drop table tb_user;

-- 유저테이블생성

CREATE TABLE `tb_user` (
	`user_number` VARCHAR(16) NOT NULL COMMENT 'pk',
	`user_id` VARCHAR(15) NOT NULL COMMENT '아이디',
	`user_pw` VARCHAR(64) NOT NULL COMMENT '비밀번호',
	`user_name` VARCHAR(25) NOT NULL COMMENT '이름',
	`user_nickname` VARCHAR(25) NOT NULL COMMENT '닉네임',
	`user_email` VARCHAR(30) NOT NULL COMMENT '이메일',
	`user_phone` VARCHAR(15) NOT NULL COMMENT '연락처',
	`user_sns` VARCHAR(200) NOT NULL COMMENT 'SNS주소',
	`user_age` INT NOT NULL COMMENT '연령대',
	`location_number` INT NOT NULL COMMENT '지역',
	`user_gender` CHAR(50) NOT NULL COMMENT '성별(남:M,여:F)',
	`user_desc` TEXT NULL DEFAULT NULL COMMENT '경력사항',
	`user_type` CHAR(50) NOT NULL COMMENT '타입(스토리:S,그림:D)',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`user_number`)
)
COMMENT='유저테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

-- 장르테이블생성
CREATE TABLE `tb_genre` (
	`gen_number` INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
	`gen_name` VARCHAR(20) NOT NULL COMMENT '장르명',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`gen_number`),
	INDEX `idx_genre` (`gen_number`)
)
COMMENT='장르 테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- 로케이션테이블생성
CREATE TABLE `tb_location` (
	`location_number` INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
	`location_name` VARCHAR(20) NOT NULL COMMENT '광역시,서울,도단위',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`location_number`),
	INDEX `idx_location` (`location_number`)

)
COMMENT='위치테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- 포폴테이블생성 

CREATE TABLE `tb_portfolio` (
	`po_number` VARCHAR(16) NOT NULL  COMMENT 'PK',
	`user_number` VARCHAR(16) NOT NULL COMMENT 'FK',
	`gen_number` INT NOT NULL COMMENT 'FK',
	`po_type` CHAR NULL DEFAULT NULL COMMENT '스토리:S,그림:D',
	`po_file_name` VARCHAR(50) NOT NULL COMMENT '서버에 저장되는 파일명',
	`po_file_username` VARCHAR(50) NOT NULL COMMENT '유저가 올렸을때의 파일명(유저에게 파일명 보여주는건 이칼럼)',
	`po_file_path` VARCHAR(300) NOT NULL COMMENT '파일경로',
	`po_title` VARCHAR(50) NOT NULL COMMENT '포폴제목',
	`po_view_count` INT NOT NULL COMMENT '조회수',
	`po_apply_count` INT NOT NULL COMMENT '신청횟수',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`po_number`),
	INDEX `FK_po_usernum` (`user_number`),
	INDEX `FK_po_gennum` (`gen_number`),
	CONSTRAINT `FK_po_gennum` FOREIGN KEY (`gen_number`) REFERENCES `tb_genre` (`gen_number`),
	CONSTRAINT `FK_po_usernum` FOREIGN KEY (`user_number`) REFERENCES `tb_user` (`user_number`)
)
COMMENT='포프폴리오테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;


-- 유저포폴테이블생성
CREATE TABLE `tb_map_user_po` (
	`user_number` VARCHAR(16) NOT NULL COMMENT 'FK',
	`po_number` VARCHAR(16) NOT NULL COMMENT 'FK',
	`mapping_pk` INT NOT NULL AUTO_INCREMENT COMMENT 'pk',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`mapping_pk`),
	INDEX `idx_mup` (`mapping_pk`),
	INDEX `FK__mup_ponum` (`po_number`),
	INDEX `FK__mup_usernum` (`user_number`),
	CONSTRAINT `FK__mup_ponum` FOREIGN KEY (`po_number`) REFERENCES `tb_portfolio` (`po_number`),
	CONSTRAINT `FK__mup_usernum` FOREIGN KEY (`user_number`) REFERENCES `tb_user` (`user_number`)
)
COMMENT='유저-포폴 매핑테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- 포폴장르테이블생성
CREATE TABLE `tb_map_po_gen` (
	`po_number` VARCHAR(16) NOT NULL COMMENT 'FK',
	`gen_number` INT NOT NULL COMMENT 'FK',
	`mapping_pk` INT NOT NULL AUTO_INCREMENT COMMENT 'PK',
	`created` DATETIME NOT NULL DEFAULT NOW() COMMENT '등록일',
	`created_by` VARCHAR(16) NOT NULL COMMENT '등록자',
	`updated` DATETIME NOT NULL DEFAULT NOW() COMMENT '수정일',
	`updated_by` VARCHAR(16) NOT NULL COMMENT '수정자',
	PRIMARY KEY (`mapping_pk`),
	INDEX `idx_mpg` (`mapping_pk`),
	INDEX `FK_mpg_ponum` (`po_number`),
	INDEX `FK_mpg_gennum` (`gen_number`),
	CONSTRAINT `FK_mpg_gennum` FOREIGN KEY (`gen_number`) REFERENCES `tb_genre` (`gen_number`),
	CONSTRAINT `FK_mpg_ponum` FOREIGN KEY (`po_number`) REFERENCES `tb_portfolio` (`po_number`)
)
COMMENT='포폴,장르 매핑 테이블'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

-- insert dummy user data 
insert into tb_user values('aaaaaaaa00000001','nuree','1234','이누리','dev_nuree','nuree@email.com','010-1234-5678','sns_choi',29,1,'M','처음만드는 데이터','S',default,'dev_nuree',default,'dev_nuree');
insert into tb_user values('aaaaaaaa00000002','choi','1234','최어진','dev_choi','yms3684@naver.com','010-9916-3684','sns_choi',27,1,'M','두번째만드는데이터','D',default,'dev_choi',default,'dev_choi');
insert into tb_user values('aaaaaaaa00000003','tester3','1234','tester3','dev_tester3','tester3@naver.com','010-1235-6789','sns_tester3',24,1,'M','desctiption3','S',default,'dev_tester3',default,'dev_tester3');
insert into tb_user values('aaaaaaaa00000004','tester4','1234','tester4','dev_tester4','tester4@naver.com','010-2222-3684','sns_tester4',25,1,'M','desctiption4','S',default,'dev_tester4',default,'dev_tester4');

update tb_user set user_gender='F',updated=now() where user_id='tester3';
update tb_user set user_desc='처음가입한 테스트 여성글작가 ',updated=now() where user_id='tester3';
select * from tb_user;

-- insert dummy genre data
insert into tb_genre values(null,'에피소드',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'옴니버스',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'스토리',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'일상',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'개그',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'판타지',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'액션',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'드라마',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'순정',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'감성',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'스릴러',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'시대극',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'스포츠',default,'dev_choi',default,'dev_choi');
insert into tb_genre values(null,'느와르',default,'dev_choi',default,'dev_choi'); -- auto_increment 설정하면 null, 또는 0 으로 넣어주면됨
insert into tb_genre values(0,'학원물',default,'dev_choi',default,'dev_choi'); -- auto_increment 설정하면 null, 또는 0 으로 넣어주면됨

select * from tb_genre;

-- insert dummy location datatb_location

insert into tb_location values(null,'서울',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'경기',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'인천',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'강원',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'충남',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'대전',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'충북',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'세종',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'부산',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'울산',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'대구',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'경북',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'경남',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'전남',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'광주',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'전북',default,'dev_choi',default,'dev_choi');
insert into tb_location values(null,'제주',default,'dev_choi',default,'dev_choi');

select * from tb_location;

-- insert dummy portfolio data tb_portfolio

insert into tb_portfolio values ('prtaaaaa00000001','aaaaaaaa00000002',10,'D','FiveMoreHours','테스트1','가상저장소','FiveMoreHours','0','0',default,'choi',default,'choi');
insert into tb_portfolio values ('prtaaaaa00000002','aaaaaaaa00000002',7,'D','OnePiece1화','테스트2','가상저장소','OnePiece1화','0','0',default,'choi',default,'choi');
insert into tb_portfolio values ('prtaaaaa00000003','aaaaaaaa00000002',7,'D','OnePiece2화','테스트3','가상저장소','OnePiece2화','0','0',default,'choi',default,'choi');
insert into tb_portfolio values ('prtaaaaa00000004','aaaaaaaa00000002',7,'D','OnePiece3화','테스트4','가상저장소','OnePiece3화','0','0',default,'choi',default,'choi');
insert into tb_portfolio values ('prtaaaaa00000005','aaaaaaaa00000002',7,'D','OnePiece4화','테스트5','가상저장소','OnePiece4화','0','0',default,'choi',default,'choi');
insert into tb_portfolio values ('prtaaaaa00000006','aaaaaaaa00000002',7,'D','OnePiece5화','테스트6','가상저장소','OnePiece5화','0','0',default,'choi',default,'choi');

insert into tb_portfolio values ('prtaaaaa00000007','aaaaaaaa00000003',8,'D','신세계','테스트7','가상저장소','신세계','0','0',default,'tester3',default,'tester3');
insert into tb_portfolio values ('prtaaaaa00000008','aaaaaaaa00000001',3,'D','나루토1화','테스트8','가상저장소','나루토1화','0','0',default,'nuree',default,'nuree');
insert into tb_portfolio values ('prtaaaaa00000009','aaaaaaaa00000003',10,'D','리틀포레스트','테스트9','가상저장소','리플포레스트','0','0',default,'tester3',default,'tester3');
insert into tb_portfolio values ('prtaaaaa00000010','aaaaaaaa00000003',8,'D','센과치이로의행방불명','테스트10','가상저장소','센과치이로의행방불명','0','0',default,'tester3',default,'tester3');
insert into tb_portfolio values ('prtaaaaa00000011','aaaaaaaa00000001',3,'D','짱구는못말려1화','테스트11','가상저장소','짱구는못말려1화','0','0',default,'nuree',default,'nuree');
insert into tb_portfolio values ('prtaaaaa00000012','aaaaaaaa00000001',3,'D','짱구는못말려2화','테스트12','가상저장소','짱구는못말려2화','0','0',default,'nuree',default,'nuree');



alter table tb_portfolio add po_desc varchar(300) null; 

select po_number,po_title,po_desc from tb_portfolio;
update tb_portfolio set po_desc='원피스1화' where po_number = 'prtaaaaa00000002';
update tb_portfolio set po_desc='원피스2화' where po_number = 'prtaaaaa00000003';
update tb_portfolio set po_desc='원피스3화' where po_number = 'prtaaaaa00000004';
update tb_portfolio set po_desc='원피스4화' where po_number = 'prtaaaaa00000005';
update tb_portfolio set po_desc='원피스5화' where po_number = 'prtaaaaa00000006';
update tb_portfolio set po_desc='영화 신세계를 웹툰으로 각색하였습니다' where po_number = 'prtaaaaa00000007';
update tb_portfolio set po_desc='나루토1화' where po_number = 'prtaaaaa00000008';
update tb_portfolio set po_desc='영화 리플포레스트를 웹툰으로 각색하였습니다' where po_number = 'prtaaaaa00000009';
update tb_portfolio set po_desc='센과치이로의 행방불명을 웹툰으로 제작 ' where po_number = 'prtaaaaa00000010';
update tb_portfolio set po_desc='짱구는못말려1화 입니다' where po_number = 'prtaaaaa00000011';
update tb_portfolio set po_desc='짱구는못말려2화 입니다' where po_number = 'prtaaaaa00000012';


