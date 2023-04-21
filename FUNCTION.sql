/* 
    FUNCTION 함수
    TO_CHAR,TO_DATE,SYSDATE => 내장 함수
    사용자 정의 함수(USER DEFINED FUNCTION
    특정한 기능을 모듈화,재사용 용이 쿼리문을 간결하게 해줌.
    CREATE OR REPLACE FUNCTION 함수명 [(ARGUMENT...)]
    RETURN 데이터타입 (반환값)
    IS[AS] 선언부
    BEGIN 실행부
    [EXCEPTION]
    RETURN 변수/값; 필수
    END;
*/
CREATE OR REPLACE FUNCTION FN_GET_DEPT_NAME (P_DEPTNO IN NUMBER)
RETURN VARCHAR2
IS
    V_DEPTNAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DNAME INTO V_DEPTNAME
    FROM DEPT
    WHERE DEPTNO=P_DEPTNO;
    RETURN V_DEPTNAME;
END;
/

SELECT FN_GET_DEPT_NAME(20) FROM DUAL;
SELECT EMPNO,ENAME,DEPTNO,FN_GET_DEPT_NAME(DEPTNO)
FROM EMP;
/