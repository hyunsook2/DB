/* CREATE TABLE TABLE_NAME(
        COLUMN_NAME DATA_TYPE(LENGTH) ,
        ......
    );
*/ 
DROP TABLE EMP_DDL;
CREATE TABLE EMP_DDL(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COM NUMBER(7,2),
    DEPTNO NUMBER(2)
    );
    