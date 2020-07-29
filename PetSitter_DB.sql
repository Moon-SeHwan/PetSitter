create table member(
    MEMBER_ID varchar2(30) primary key, --ID
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    MEMBER_PW varchar2(30), --PW
    MEMBER_NAME varchar2(20), --�̸�
    MEMBER_TEL varchar2(20), --��ȭ��ȣ
    MEMBER_RANK varchar2(30) DEFAULT 'Green', --���('Green', 'Gold', 'VIP')
    MEMBER_COUNT number DEFAULT 0, --�̿�Ƚ��
    MEMBER_AMOUNT number DEFAULT 0, --�� �ݾ�
    MEMBER_DATE date default sysdate, --���Գ�¥
    MEMBER_PHOTO_FILE varchar2(100) DEFAULT 'N', --�����ʻ���
    MEMBER_REPORT number DEFAULT 0, --�Ű���Ƚ��
    MEMBER_GENDER varchar2(4) DEFAULT 'N', -- ����, �߰�
    MEMBER_ADDRESS varchar2(100) DEFAULT 'N'-- �ּ�, �߰�
); 

create table PETSITTER(
    PETSITTER_ID varchar2(30) primary key, --ID
    PETSITTER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    PETSITTER_NAME varchar2(20) default 'N', --�̸�
    PETSITTER_PW varchar2(30) default 'N', --PW
    PETSITTER_TEL varchar2(20) default 'N', --��ȭ��ȣ
    PETSITTER_EMAIL varchar2(30) default 'N', --�̸���
    PETSITTER_SCORE number(2,1) DEFAULT 0, --����
    PETSITTER_COUNT number(5) DEFAULT 0, --Ȱ��Ƚ��
    PETSITTER_RANK varchar2(20) DEFAULT 'N', --���('N','Pro', 'GoldPro')
    PETSITTER_ADDRESS varchar2(100) default 'N', --�ּ�
    PETSITTER_INTRODUCE varchar2(2000) default 'N', --�ڱ�Ұ�
    PETSITTER_PRICE_30M varchar2(10), --30�а���(�湮 ����)
    PETSITTER_PRICE_60M varchar2(10), --60�а���(��Ź ����)
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
    PETSITTER_REVIEWCOUNT number(5) DEFAULT 0, --���� ����
    PETSITTER_PHOTO_APPEAL varchar2(300) default 'N', --���� ����
    PETSITTER_AMOUNT number default 0, --�� ���� �ݾ�
    PETSITTER_ADDRX number default 0, -- �ּ��� X��ǥ
    PETSITTER_ADDRY number default 0, -- �ּ��� Y��ǥ
    PETSITTER_SAFEADDR varchar2(100) default 'N' -- �Ƚ��ּ� (���θ��ּ�, ���ּ�)
); 

create table petsitter_schedule(
    PETSITTER_ID varchar2(30),
    START_DATE date,
    END_DATE date
);

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

create table REVIEW_BOARD(
    LIST_NUM number(10), -- ���� ��ȣ
    USINGLIST_NUM number(10), -- �̿볻�� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    REVIEW_CONTENT varchar2(250) default 'N', -- ���� ����
    REVIEW_SCORE number(2,1) default 0, -- ���� ����
    REVIEW_UP_PHOTO varchar2(200) default 'N', -- ���ε�� ���� ����
    REVIEW_DATE date default sysdate, -- ���� �ۼ���
    LIKE_COUNT number(6) default 0, -- ���ƿ� ��
    BOARD_TYPE VARCHAR2(20) default 'REVIEW_BOARD', -- �Խ��� Ÿ��
    REVIEW_REFLY VARCHAR2(250) DEFAULT 'N'--�ı�Խ��� �亯
);

CREATE TABLE LIKE_COUNT(
    LIKE_NUM NUMBER primary key, --���ƿ� ��ȣ
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

-- ������ �Խ��� ���̺�
create table PRO_BOARD(
    PRO_NUM number(6) primary key, -- �� ��ȣ  
    MEMBER_ID varchar2(30), -- ���̵�
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���  
    PRO_SUBJECT varchar2(100), -- ����
    PRO_CONTENT varchar2(3000), -- ����
    PRO_ORG_FILE varchar2(100), -- �����̸�
    PRO_UP_FILE varchar2(100), -- ���ε�� �����̸�
    PRO_READCOUNT number, -- ��ȸ��
    PRO_DATE date default sysdate, -- �ۼ���
    PRO_LIKECOUNT number, -- ���ƿ� ��
    BOARD_TYPE VARCHAR2(20) default 'PRO_BOARD', -- �Խ��� Ÿ�� 
    SECRET_CHECK VARCHAR2(4) default 'N' -- ��аԽ��� Ȯ�� 
);

-- ���κ��� ���ƿ� ���̺�
CREATE TABLE PRO_LIKE_COUNT(
    LIKE_NUM NUMBER primary key, --���ƿ� ��ȣ
    LIKE_ID varchar2(4000) DEFAULT 'N' -- ���ƿ� ���̵�
);

-- ���κ��� ���ƿ� Ʈ����
CREATE OR REPLACE TRIGGER PRO_LIKE_INSERT_TRG1
BEFORE INSERT ON PRO_BOARD
BEGIN
INSERT into PRO_LIKE_COUNT
VALUES ((SELECT NVL(MAX(PRO_NUM),0)+1 FROM PRO_BOARD),'N');
END;
/

CREATE TABLE PROREPLY (
    BNO NUMBER, 
    RNO NUMBER, 
    CONTENT VARCHAR2(2000 BYTE), 
    WRITER_ID VARCHAR2(30 BYTE), 
    REGDATE DATE DEFAULT sysdate, 
    WRITER_NICKNAME VARCHAR2(30 BYTE),
    B_TYPE VARCHAR2(20) default 'PRO_BOARD' 
);

-- �� �Ű� ���̺�
create table report_article (
    member_num number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10) default 'N'
);
    
-- ��� �Ű� ���̺�    
create table report_reply (
    bno number,
    rno number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10) default 'N'
);

-- ȸ�� �Խ��� ���̺�
create table MEMBER_BOARD(
    MEMBER_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    MEMBER_SUBJECT varchar2(100), -- ����
    MEMBER_CONTENT varchar2(4000), -- ����
    MEMBER_ORG_FILE varchar2(100), -- ���� �̸�
    MEMBER_UP_FILE varchar2(100), -- ���ε� ���� �̸�
    MEMBER_READCOUNT number, -- ��ȸ��
    MEMBER_DATE date default sysdate, -- �ۼ���
    MEMBER_LIKECOUNT number, -- ���ƿ� ��
    MEMBER_NICKNAME varchar2(20), -- ȸ�� �г���
    MEMBER_SECRET varchar2(2) default 'N' -- ��� ��
);

-- ����� �Խ��� ���̺�
CREATE TABLE petsitter_qna_board (
    petsitter_id           VARCHAR2(30),
    petsitter_nickname      VARCHAR2(30),
    member_id              VARCHAR2(30),
    member_nickname        VARCHAR2(30),
    petsitter_qna_subject  VARCHAR2(100),
    petsitter_qna_content  VARCHAR2(4000),
    petsitter_qna_date     DATE,
    petsitter_qna_bno      NUMBER
);

-- �ֽ�ȭ �ȵ�
create table report_article (
    member_num number,
    report_reason varchar2(4000),
    member_id varchar2(30),
    btype varchar2(100),
    processing varchar2(10)
);

create table mreply(
    BNO number,
    RNO number,
    CONTENT varchar2(2000),
    WRITER_ID varchar2(30),
    REGDATE date default sysdate,
    WRITER_NAME varchar2(30)
);

-- ����Ϳ��� ���� �Խ���
create table COMMUNICATION_BOARD(
	BOARD_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    USINGLIST_NUM number(10), -- �̿� ���� ��ȣ
    BOARD_WRITER varchar2(30), -- �ۼ���(�Ϲ� ȸ�� �г��� or ����� �г���)
	MEMBER_ID varchar2(30), -- �Ϲ� ȸ�� ���̵�
	PETSITTER_ID varchar2(30), -- ����� ȸ�� ���̵�
	BOARD_SUBJECT varchar2(100), -- ����
	BOARD_CONTENT varchar2(4000), -- ����
	BOARD_DATE date default sysdate, -- �ۼ���
	BOARD_CONDITION varchar2(10) default '�亯 ����', -- �亯����/�亯�Ϸ�
	BOARD_TYPE varchar2(10) -- �� ����(������/��Ÿ)
);

-- ����Ϳ��� ���� ���� �Խ���(�Ϸ翡 3�� ���ε� ����)
create table COMMUNICATION_PHOTO_LIST(
    USINGLIST_NUM number(10),
    COMMUNICATION_PHOTO_FILE varchar2(100) default 'N', -- ���ε�� ���� ����
    UPLOAD_DATE date default sysdate, -- ���ε� ����
    PETSITTER_ID varchar2(30) -- ����� ȸ�� ���̵�
);

-- �������� ���̺�
CREATE TABLE NOTICE_BOARD (
    NOTICE_NUM        NUMBER, -- ȸ�� �Խ��� �� ��ȣ
    NOTICE_ID         VARCHAR2(30), -- ȸ�� ���̵�
    NOTICE_SUBJECT    VARCHAR2(100), -- �� ����
    NOTICE_CONTENT    VARCHAR2(4000), -- �� ����
    NOTICE_ORG_FILE   VARCHAR2(100), -- ���� ����
    NOTICE_UP_FILE    VARCHAR2(100), -- ���ε� ���� 
    NOTICE_READCOUNT  NUMBER, -- ��ȸ ��
    NOTICE_DATE       DATE, -- �ۼ�����
    NOTICE_NICKNAME   VARCHAR2(30),
    NOTI			  VARCHAR2(10) -- ��� ���� ����
);

-- ���� ���̺�
create table pay(
    PAY_ID varchar2(30), -- ȸ�� ���̵�
    PAY_AMOUNT number, -- ���� �ݾ�
    PETSITTER_ID varchar2(30), -- �̿� ����� ���̵�
    MERCHANT_UID varchar2(20), -- ���� ��ȣ
    PAY_DATE date default sysdate, -- ������
    PAY_TYPE varchar2(10), -- ��Ź or �湮
    START_DATE date, -- �̿� ���� ��¥
    END_DATE date, -- �̿� ���� ��¥
    PAY_STATUS varchar2(10) default '���� �Ϸ�' -- ���� �Ϸ� or ���� ���
);

-- �̿� ���� ���̺�
create table USINGLIST(
    LIST_NUM number(10) primary key,
    PETSITTER_ID varchar2(30),
    PETSITTER_ADDR varchar2(100),
    MEMBER_ID varchar2(30),
    LIST_PRICE number(8),
    LIST_START_DATE date,
    LIST_END_DATE date,
    LIST_TYPE varchar2(10),
    MERCHANT_UID varchar2(10) -- �ŷ� ���� ���̵�
);

-- usinglist ���� ������
insert into usinglist
values(1, 'asd111', '��� ������', 'asdasd@naver.com', 75000, to_date('2020-07-21 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-23 15:00', 'YYYY-MM-DD HH24:mi'), '��Ź', 'iaPgv1');

insert into usinglist
values(2, 'asd111', '��� ������', 'asdasd@naver.com', 120000, to_date('2020-07-25 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-29 15:00', 'YYYY-MM-DD HH24:mi'), '��Ź', 'Eng82o');

insert into usinglist
values(3, 'asd111', '��� ������', 'asdasd@naver.com', 37500, to_date('2020-07-29 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-30 15:00', 'YYYY-MM-DD HH24:mi'), '��Ź', '7Tpbg9');


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

insert into pay(PAY_ID, PAY_AMOUNT, PETSITTER_ID, MERCHANT_UID, PAY_DATE, PAY_TYPE, START_DATE, END_DATE)
values('asdasd@naver.com', 50000, 'asdasd', 'yaIB5s', sysdate, '��Ź', to_date('2020-07-29 14:00', 'YYYY-MM-DD HH:mi'), to_date('2020-07-30 14:00', 'YYYY-MM-DD HH:mi'));


insert into pay
values('asdasd@naver.com', 37500, 'asd111', '7Tpbg9', sysdate, '��Ź', to_date('2020-07-29 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-30 15:00', 'YYYY-MM-DD HH24:mi'), '���� �Ϸ�');

insert into pay
values('asdasd@naver.com', 120000, 'asd111', 'Eng82o', sysdate, '��Ź', to_date('2020-07-25 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-29 15:00', 'YYYY-MM-DD HH24:mi'), '���� �Ϸ�');

insert into pay
values('asdasd@naver.com', 75000, 'asd111', 'iaPgv1', sysdate, '��Ź', to_date('2020-07-21 14:00', 'YYYY-MM-DD HH24:mi'), to_date('2020-07-23 15:00', 'YYYY-MM-DD HH24:mi'), '���� �Ϸ�');

insert into petsitter
values('asd111', 'N', '��������', '123123', '01011112222', 'asd111@asd111.com', 0, 0,	'N', '13494,��� ������ �д籸 �Ǳ����� 233-1,101ȣ',	'������������ ���������Դϴ�', 15000,	1500, '�Ⱦ� ����,���� ����,������ �ɾ� ����,��� �ɾ� ����', '715744dd7f8347c6a7a87b0855129ece.jpg', '44353bd42b3849e8ae8849d4c60edc89.jpg', 'N', 'N', 'b0520cdf66144c63a6d989c192c21b3c.jpg,5b3deed78e754722ad2316740f95dff2.jpg', sysdate, '�湮,��Ź', 0, 'N', 0, 'N', 0, 127.109420804531, 37.4016559594071, 'N');

insert into member
values('asdasd@naver.com', 'ȣ����', '123123', '�Ѹ�', '01011112222', 'Green', 1, 37500, sysdate, 'cf58b71ad91c4eb1a4372de3b2bfdf62.png', 0, '��', '18132,��� ����� ��Ϸ� 122,106�� 1803ȣ');
commit;
