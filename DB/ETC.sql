-- INDEX
CREATE INDEX EMP_INDEX ON EMP (EMPNO,ENAME);
DROP INDEX EMP_INDEX;

--DICTIONARY
SELECT * FROM DICT;
SELECT * FROM DICTIONARY
WHERE TABLE_NAME LIKE 'USER%';
/*
USER_?? 사용자 관련 객체 정보
ALL_?? 사용자 사용가능한 객체 정보
DBA_?? DB관련 정보(SYSTEM SYS)
v$_?? VIEW 관련

*/
SELECT * FROM USER_TABLES;
SELECT * FROM ALL_TABLES WHERE OWNER = 'SCOTT';
SELECT * FROM DBA_TABLES;
SELECT * FROM DBA_USERS;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;
SELECT * FROM OBJ;

--VIEW
DROP VIEW VW_EMP2;
CREATE VIEW VW_EMP2 AS (SELECT E.*,D.DNAME,D.LOC FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO);

SELECT * FROM USER_VIEWS;
SELECT * FROM VW_EMP2;

/* SEQUENCE CREATE SEQUENCE [SEQ NAME]
    INCREMENT BY [NUM]
    START WITH [START NUM]
    NOMINVALUE OR MINVALUE [MINNUM]
    NOMAXVALUE OR MAXVALUE [MAXNUM]
    CYCLE OR NOCYCLE
    CACHE OR NOCACHE   
    */
    
DROP SEQUENCE EX_SEQ;
CREATE SEQUENCE EX_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100
NOCYCLE
NOCACHE;

DROP TABLE SEQTABLE;
CREATE TABLE SEQTABLE(SEQNUM NUMBER(4),TESTTXT VARCHAR2(10));
SELECT * FROM SEQTABLE;
INSERT INTO SEQTABLE VALUES(EX_SEQ.NEXTVAL,'TEST TEXT');
SELECT EX_SEQ.CURRVAL FROM DUAL;
SELECT EX_SEQ.NEXTVAL FROM DUAL;
ALTER SEQUENCE EX_SEQ INCREMENT BY -2;

/*줄번호*/
SELECT ROWNUM, A.* FROM (SELECT E.* FROM EMP E ORDER BY ENAME) A ORDER BY A.JOB;

SELECT ROW_NUMBER() OVER(ORDER BY E.JOB,E.ENAME) ROW_NUM,E.* FROM EMP E ORDER BY E.JOB,E.ENAME;


SELECT ROW_NUMBER() OVER(ORDER BY E.JOB,E.ENAME) ROW_NUM,E.JOB,E.ENAME FROM EMP E ORDER BY E.JOB,E.ENAME;

-- OVER (PARTITION BY)
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB IN('MANAGER','SALESMAN') GROUP BY JOB ORDER BY JOB;

SELECT EMPNO,ENAME,DEPTNO,JOB,SUM(SAL) OVER(PARTITION BY JOB,DEPTNO) FROM EMP WHERE JOB IN ('MANAGER','SALESMAN')
ORDER BY JOB,DEPTNO;

SELECT EMPNO,ENAME,JOB,SAL,RANK() 
OVER(ORDER BY SAL DESC) AS 등수,DENSE_RANK() OVER(ORDER BY SAL DESC) AS 등수2 FROM EMP WHERE SAL IS NOT NULL ORDER BY SAL DESC;

/* SYNONYM 동의어
    CREATE PUBLIC SYNONYM [NAME]
    FOR [TARGET]
    */
CREATE SYNONYM DE 
FOR DEPT;
SELECT * FROM DE;
DROP SYNONYM DE;

--Q1
DROP TABLE EMPIDX;
CREATE TABLE EMPIDX AS SELECT * FROM EMP;
--EMPIDX 테이블의 EMPNO값을 기준으로 한 인덱스 IDX_EMPIDX_EMPNO 생성

CREATE INDEX IDX_EMPIDX_EMPNO ON EMPIDX (EMPNO);
SELECT *FROM USER_INDEXES WHERE INDEX_NAME='IDX_EMPIDX_EMPNO';
--Q2 급여가 1500을 넘는 사람의 사번 이름 직급 급여를 담은 뷰 EMPIDX_OVER15를 생성
DROP VIEW EMPIDX_OVER15;
CREATE VIEW EMPIDX_OVER15 AS (SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>1500);

SELECT * FROM USER_VIEWS WHERE VIEW_NAME='EMPIDX_OVER15';
SELECT * FROM EMPIDX_OVER15;
--Q3
DROP TABLE DEPTSEQ;
CREATE TABLE DEPTSEQ AS SELECT * FROM DEPT;


--SEQ_DEPTSEQ 시퀀스를 생성(1에서 99까지 1씩 증가 순환없음 캐쉬안씀)
DROP SEQUENCE SEQ_DEPTSEQ;
CREATE SEQUENCE SEQ_DEPTSEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100
NOCYCLE
NOCACHE;

DROP TABLE SEQ;
CREATE TABLE SEQ(SEQNUM NUMBER(4),TESTTXT VARCHAR2(10));
SELECT * FROM SEQ;
INSERT INTO SEQ VALUES(SEQ_DEPTSEQ.NEXTVAL,'TEST TEXT');
SELECT SEQ_DEPTSEQ.NEXTVAL FROM DUAL;

--SEQ_DEPTSEQ 시퀀스 삭제
DROP SEQUENCE SEQ_DEPTSEQ;

--SEQ_DEPTSEQ 시퀀스를 생성(10에서 100까지 60부터 10씩증가 순환없음 캐쉬안씀)

DROP SEQUENCE SEQ_DEPTSEQ;
CREATE SEQUENCE SEQ_DEPTSEQ
INCREMENT BY 10
START WITH 60
MINVALUE 10
MAXVALUE 100
NOCYCLE
NOCACHE;

DROP TABLE SEQ;
CREATE TABLE SEQ(SEQNUM NUMBER(4),TESTTXT VARCHAR2(10));
SELECT * FROM SEQ;
INSERT INTO SEQ VALUES(SEQ_DEPTSEQ.NEXTVAL,'TEST TEXT');
SELECT SEQ_DEPTSEQ.NEXTVAL FROM DUAL;

SELECT * FROM DEPTSEQ;
--UNION 
SELECT DEPTNO, ENAME NAME FROM EMP WHERE DEPTNO=10
UNION
SELECT DEPTNO,DNAME NAME FROM DEPT;

SELECT * FROM EMP WHERE DEPTNO=20
UNION ALL
SELECT * FROM EMP WHERE DEPTNO=20
UNION ALL
SELECT * FROM EMP WHERE DEPTNO=20;

/* 계층구조
 START WITH [CONDITION]
 CONNECT BY PRIOR [CONDITION]
 */
--SELECT A.EMPNO,A.ENAME,A.JOB,A.MGR,B.EMPNO,B.ENAME,B.JOB FROM EMP A, EMP B WHERE A.MGR=B.EMPNO;

SELECT LEVEL,EMPNO,ENAME,MGR,JOB FROM EMP START WITH JOB='PRESIDENT' CONNECT BY PRIOR EMPNO=MGR AND LEVEL<=2;

--숫자 찍기