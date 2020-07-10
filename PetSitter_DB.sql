create table member(
    MEMBER_ID varchar2(30) primary key, --ID
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    MEMBER_PW varchar2(30), --PW
    MEMBER_NAME varchar2(20), --�̸�
    MEMBER_TEL varchar2(20), --��ȭ��ȣ
    MEMBER_RANK varchar2(30) DEFAULT 'Green', --���
    MEMBER_COUNT number DEFAULT 0, --�̿�Ƚ��
    MEMBER_AMOUNT number DEFAULT 0, --�� �ݾ�
    MEMBER_DATE date default sysdate, --���Գ�¥
    MEMBER_PHOTO_FILE varchar2(100) DEFAULT 'N', --�����ʻ���
    MEMBER_REPORT number DEFAULT 0, --�Ű���Ƚ��
    MEMBER_GENDER varchar2(4), -- ����, �߰�
    MEMBER_ADDRESS varchar2(100) DEFAULT 'N'-- �ּ�, �߰�
); 
select * from member;
create table PETSITTER(
    PETSITTER_ID varchar2(30) primary key, --ID
    PETSITTER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    PETSITTER_NAME varchar2(20) default 'N', --�̸�
    PETSITTER_PW varchar2(30) default 'N', --PW
    PETSITTER_TEL varchar2(20) default 'N', --��ȭ��ȣ
    PETSITTER_EMAIL varchar2(30) default 'N', --�̸���
    PETSITTER_SCORE number(2,1) DEFAULT 0, --����
    PETSITTER_COUNT number(5) DEFAULT 0, --Ȱ��Ƚ��
    PETSITTER_RANK varchar2(20) DEFAULT 'N', --���
    PETSITTER_ADDRESS varchar2(100) default 'N', --�ּ�
    PETSITTER_INTRODUCE varchar2(2000) default 'N', --�ڱ�Ұ�
    PETSITTER_PRICE_12H varchar2(10), --12�ð�����
    PETSITTER_PRICE_24H varchar2(10), --24�ð�����
    PETSITTER_PRICE_30M varchar2(10), --30�а���
    PETSITTER_PRICE_60M varchar2(10), --60�а���
    PETSITTER_SERVICE_LIST varchar2(60) default 'N', --������ ����
    PETSITTER_PHOTO_UPFILE varchar2(100) default 'N', --���� ����
    PETSITTER_PHOTO_PROFILE_FILE varchar2(100) default 'N', --������ ����
    PETSITTER_CERT_LIST varchar2(100) default 'N', --�ڰ����̸�
    PETSITTER_PHOTO_CERT_FILE varchar2(300) default 'N', --�ڰ��� ����
    PETSITTER_PHOTO_HOME_FILE varchar2(300) default 'N', --�� ����
    PETSITTER_DATE date DEFAULT sysdate, --���� ��¥
    PETSITTER_TYPE varchar2(20) default 'N', -- �ɾ�����
    PETSITTER_REPORT number(2) default 0, --�Ű���Ƚ��, �߰�
    PETSITTER_GENDER varchar2(4) default 'N',-- ����, �߰�
    PETSITTER_REVIEWCOUNT number(5) DEFAULT 0 --���� ����
); 

select * from petsitter
where petsitter_type like '%�湮%';
select * from petsitter
where petsitter_type like '%��Ź%';

insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd111', '�浿', 'ȫ�浿', '123123', '010-1111-2222', 'asd111@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd222', '����', '�̸���', '123123', '010-2222-4444', 'asd222@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd333', '��', '����', '123123', '010-3333-6666', 'asd333@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd444', '��', '���', '123123', '010-4444-8888', 'asd444@naver.com');

<<<<<<< HEAD
=======
create table PET(
	MEMBER_ID varchar2(30),
	PET_CATEGORY varchar2(20),
	PET_KIND varchar2(20),
	PET_NAME varchar2(20), 
	PET_PHOTO varchar2(150), 
	PET_WEIGHT number(3), 
	PET_SIZE varchar2(5), 
	PET_GENDER varchar2(6),
	PET_BIRTH date,
	PET_NEUTERED varchar2(10), 
	PET_POTTYTRAN varchar2(10),
	PET_VAOONE varchar2(10),
	PET_QUESTION varchar2(30), 
	PET_ETC varchar2(200),
	PET_DATE date
);

>>>>>>> 823152b4918d7b962f99c5d7383409f27f7824f4
create table NOTICE_BOARD(
    NOTICE_NUM number(10) primary key, -- �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    NOTICE_SUBJECT varchar2(100), -- ����
    NOTICE_CONTENT varchar2(4000), -- ����
    NOTICE_PHOTO varchar2(50), -- ����
    NOTICE_READCOUNT number(6), -- ��ȸ��
    NOTICE_DATE date default sysdate -- �ۼ���
); -- ���� ����

create table REVIEW_BOARD(
    LIST_NUM number(10), -- ���� ��ȣ
    USINGLIST_NUM number(10), -- �̿볻�� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    REVIEW_CONTENT varchar2(500), -- ���� ����
    REVIEW_SCORE number(2,1), -- ���� ����
    REVIEW_ORG_PHOTO varchar2(50), -- ���� ����
    REVIEW_UP_PHOTO varchar2(200), -- ���ε�� ���� ����
    REVIEW_DATE date default sysdate, -- ���� �ۼ���
    LIKE_COUNT number(6), -- ���ƿ� ��
    BOARD_TYPE VARCHAR2(20) default 'REVIEW_BOARD' -- �Խ��� Ÿ��
);

CREATE TABLE LIKE_COUNT(
    LIKE_NUM NUMBER, --���ƿ� ��ȣ
    LIKE_ID varchar2(2000), -- ���ƿ� ���̵�
    LIKE_TYPE varchar2(20) default 'REVIEW_BOARD' -- ���ƿ� Ÿ��
);
/
--Ʈ����(REVIEW_BOARD, LIKE_COUNT Ʈ����)
CREATE OR REPLACE TRIGGER REVIEW_LIKE_INSERT_TRG1
BEFORE INSERT ON REVIEW_BOARD
BEGIN
INSERT into LIKE_COUNT
VALUES ((SELECT NVL(MAX(LIST_NUM),0)+1 FROM REVIEW_BOARD),'N','REVIEW_BOARD');
END;
/

create table PRO_BOARD(
    PRO_NUM number(6) primary key, -- �� ��ȣ
    MEMBER_ID varchar2(30), -- ���̵�
    PRO_SUBJECT varchar2(100), -- ����
    PRO_CONTENT varchar2(4000), -- ����
    PRO_ORG_FILE varchar2(100), -- �����̸�
    PRO_UP_FILE varchar2(100), -- ���ε�� �����̸�
    PRO_READCOUNT number, -- ��ȸ��
    PRO_DATE date default sysdate, -- �ۼ���
    PRO_LIKECOUNT number -- ���ƿ� ��
); -- ���� ����

create table PETSITTER_BOARD(
    PETSITTER_NUM number(10), -- ����� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    PETSITTER_SUBJECT varchar2(100), -- ����
    PETSITTER_CONTENT varchar2(4000), -- ����
    PETSITTER_DATE date default sysdate -- �ۼ���
); -- ���� ����

create table MEMBER_BOARD(
    MEMBER_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    MEMBER_SUBJECT varchar2(100), -- ����
    MEMBER_CONTENT varchar2(4000), -- ����
    MEMBER_ORG_FILE varchar2(100), -- ���� �̸�
    MEMBER_UP_FILE varchar2(100), -- ���ε� ���� �̸�
    MEMBER_READCOUNT number, -- ��ȸ��
    MEMBER_DATE date default sysdate, -- �ۼ���
    MEMBER_LIKECOUNT number -- ���ƿ� ��
); -- ���� ����

CREATE TABLE BOARD_COMMENT (
    COMMENT_NUM NUMBER,
    COMMENT_BOARD_TYPE VARCHAR2(20),
    COMMENT_BOARD_NUM NUMBER,
    COMMENT_CONTENT VARCHAR2(500),
    COMMENT_WRITER VARCHAR2(20),
    COMMENT_DATE DATE,
    COMMENT_LIKECOUNT NUMBER
); -- ���� ����


-- ����Ϳ��� ���� �Խ���
create table COMMUNICATION_BOARD(
	BOARD_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    USINGLIST_NUM number(10), -- �̿� ���� ��ȣ
    BOARD_WRITER varchar2(30), -- �ۼ���(�Ϲ� ȸ�� �г��� or ����� �г���)
	MEMBER_ID varchar2(30), -- �Ϲ� ȸ�� ���̵�
	PETSITTER_ID varchar2(30), -- ����� ȸ�� ���̵�
	BOARD_SUBJECT varchar2(100), -- ����
	BOARD_CONTENT varchar2(4000), -- ����
	BOARD_READCOUNT number, -- ��ȸ��
	BOARD_DATE date default sysdate, -- �ۼ���
	BOARD_CONDITION varchar2(10) default '�亯 ����', -- �亯����/�亯�Ϸ�
	BOARD_TYPE varchar2(10) -- �� ����(������/��Ÿ)
);

create table USINGLIST(
    USINGLIST_NUM number(10) primary key,
    PETSITTER_ID varchar2(30),
    PETSITTER_ADDR varchar2(100),
    MEMBER_ID varchar2(30),
    LIST_PRICE number(8),
    LIST_START_DATE date,
    LIST_END_DATE date,
    LIST_TYPE varchar2(10)
);

-- usinglist ���� ������
insert into usinglist
values('1', 'asd222', 'N', 'asdasd@naver.com', '90000', '2020/02/21', '2020/02/22', '��Ź');
insert into usinglist
values('2', 'asd111', 'N', 'asdasd@naver.com', '70000', '2020/05/21', '2020/05/22', '��Ź');
insert into usinglist
values('3', 'asd444', 'N', 'asdasd@naver.com', '80000', '2020/06/25', '2020/06/26', '��Ź');
insert into usinglist
values('4', 'asd333', 'N', 'asdasd@naver.com', '40000', '2020/06/27', '2020/06/28', '��Ź');
insert into usinglist
values('5', 'asd111', 'N', 'asdasd@naver.com', '30000', '2020/06/29', '2020/06/30', '��Ź');
insert into usinglist
values('6', 'asd111', 'N', 'asdasd@naver.com', '20000', '2020/06/29', '2020/06/29', '�湮');
insert into usinglist
values('7', 'asd222', 'N', 'asdasd@naver.com', '60000', '2020/06/30', '2020/07/01', '��Ź');
insert into usinglist
values('8', 'asd333', 'N', 'asdasd@naver.com', '80000', '2020/07/01', '2020/07/02', '��Ź');
insert into usinglist
values('9', 'asd111', 'N', 'asdasd@naver.com', '70000', '2020/07/02', '2020/07/03', '��Ź');
insert into usinglist
values('10', 'asd333', 'N', 'asdasd@naver.com', '120000', '2020/07/02', '2020/07/05', '��Ź');
insert into usinglist
values('11', 'asd888', '��� �����', 'asdasd@naver.com', '150000', '2020/07/07', '2020/07/17', '��Ź');

select * from usinglist where member_id='asdasd@naver.com' order by list_num desc;
select * from petsitter where petsitter_id='asd444';
commit;

select list_num, member_id, petsitter_id, list_price, list_type, petsitter_nickname, petsitter_name, petsitter_tel 
from usinglist natural join petsitter
where member_id='asdasd@naver.com'
order by list_num desc;

select list_num, member_id, list_price, list_start_date, list_end_date, list_type, petsitter_nickname, petsitter_name, petsitter_tel 
from usinglist natural join petsitter  
where member_id='asdasd@naver.com' and list_start_date >= trunc(add_months(sysdate,-1))
order by list_num desc;

select * from usinglist 
where MEMBER_ID='asdasd@naver.com' and list_start_date >= trunc(add_months(sysdate, -1)) 
order by LIST_NUM desc;

select * from usinglist 
where MEMBER_ID='asdasd@naver.com'
order by LIST_NUM desc;

select * from usinglist
where MEMBER_ID='asdasd@naver.com' and 
      (list_start_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-05', 'YYYY-MM-DD') or
      list_end_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-05', 'YYYY-MM-DD'));
      
select list_num, member_id, list_price, list_start_date, list_end_date, list_type, petsitter_nickname, petsitter_name, petsitter_tel 
from usinglist , petsitter 
where MEMBER_ID='asdasd@naver.com' and usinglist.PETSITTER_ID=petsitter.PETSITTER_ID and 
      (list_start_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-04', 'YYYY-MM-DD') or
      list_end_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-04', 'YYYY-MM-DD'))
order by LIST_NUM desc;

-- review_board ���� ������
insert into REVIEW_BOARD
values(2, 2, 'asdasd@naver.com', 'asd111', '2������ ���ٶ��� �Ҿ� ������ ���� û���� ���� �Ǵ� û���� �ǰ� �߰ſ����� �ΰ��� ���꿡�� ����� Ǯ�� ���� �̻��� ���� �ǰ� ����� ���� �߰� ������ ���� ��ٻ���� Ǯ�� ������ �ΰ��� �縷�̴� �����̽��� ���� �縷�̴�', 
4.5, 'dog01.jpg', '','2020/05/23', 0, 'REVIEW_BOARD');
insert into REVIEW_BOARD
values(1, 1, 'asdasd@naver.com', 'asd222', '2������ ���ٶ��� �Ҿ� ������ ���� û���� ���� �Ǵ� û���� �ǰ� �߰ſ����� �ΰ��� ���꿡�� ����� Ǯ�� ���� �̻��� ���� �ǰ� ����� ���� �߰� ������ ���� ��ٻ���� Ǯ�� ������ �ΰ��� �縷�̴� �����̽��� ���� �縷�̴�', 
3, 'dog02.jpg', '','2020/03/01', 0, 'REVIEW_BOARD');
insert into REVIEW_BOARD
values(4, 4, 'asdasd@naver.com', 'asd333', '2������ ���ٶ��� �Ҿ� ������ ���� û���� ���� �Ǵ� û���� �ǰ� �߰ſ����� �ΰ��� ���꿡�� ����� Ǯ�� ���� �̻��� ���� �ǰ� ����� ���� �߰� ������ ���� ��ٻ���� Ǯ�� ������ �ΰ��� �縷�̴� �����̽��� ���� �縷�̴�', 
5, 'dog03.jpg', '','2020/06/29', 0, 'REVIEW_BOARD');
insert into REVIEW_BOARD
values(3, 3, 'asdasd@naver.com', 'asd444', '2������ ���ٶ��� �Ҿ� ������ ���� û���� ���� �Ǵ� û���� �ǰ� �߰ſ����� �ΰ��� ���꿡�� ����� Ǯ�� ���� �̻��� ���� �ǰ� ����� ���� �߰� ������ ���� ��ٻ���� Ǯ�� ������ �ΰ��� �縷�̴� �����̽��� ���� �縷�̴�', 
4, 'dog04.jpg', '','2020/06/28', 0, 'REVIEW_BOARD');
insert into REVIEW_BOARD
values(5, 9, 'asdasd@naver.com', 'asd111', '2������ ���ٶ��� �Ҿ� ������ ���� û���� ���� �Ǵ� û���� �ǰ� �߰ſ����� �ΰ��� ���꿡�� ����� Ǯ�� ���� �̻��� ���� �ǰ� ����� ���� �߰� ������ ���� ��ٻ���� Ǯ�� ������ �ΰ��� �縷�̴� �����̽��� ���� �縷�̴�', 
3.5, 'dog05.jpg', '','2020/07/04', 0, 'REVIEW_BOARD');
    
commit;
