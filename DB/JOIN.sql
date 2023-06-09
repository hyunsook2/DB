--JOIN
SELECT * FROM EMP;
SELECT * FROM DEPT;
--CARTESIAN PRODUCT 카티션 곱 , 상호조인
SELECT * FROM EMP A CROSS JOIN DEPT B;
--INNER JOIN
SELECT E.EMPNO,E.ENAME,E.JOB,D.DNAME FROM EMP E INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO WHERE E.JOB='CLERK';

SELECT E.EMPNO,E.ENAME,E.JOB,D.DNAME FROM EMP E,DEPT D WHERE E.DEPTNO=D.DEPTNO AND E.JOB='CLERK';
--FULL OUTER JOIN
SELECT E.*,D.* FROM EMP E FULL OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
--LEFT OUTER JOIN
SELECT E.*,D.* FROM EMP E LEFT OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
--WHERE E.DEPTNO IS NULL;
SELECT E.*,D.* FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO(+);
--RIGHT OUTER JOIN
SELECT E.*,D.* FROM EMP E RIGHT OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT E.*,D.* FROM EMP E,DEPT D WHERE E.DEPTNO(+)=D.DEPTNO;

--SELF JOIN
SELECT A.EMPNO,A.ENAME,A.JOB,A.MGR,D.DEPTNO,D.DNAME,B.EMPNO,B.ENAME,B.JOB FROM EMP A, EMP B, DEPT D WHERE A.DEPTNO=D.DEPTNO
AND A.MGR=B.EMPNO;

--SUB QUERY 서브쿼리
SELECT E.ENAME,(SELECT D.DNAME FROM DEPT D WHERE D.DEPTNO=E.DEPTNO) AS DEPTNAME 
FROM EMP E WHERE E.JOB='MANAGER';

--FROM INLINE VIEW 결과 반드시 하나의 테이블로 리턴
SELECT EMP_NAME,SALARY 
FROM(SELECT E.ENAME AS EMP_NAME, E.SAL AS SALARY FROM EMP E, DEPT D WHERE E.DEPTNO=D.DEPTNO AND D.DNAME='SALES') 
WHERE SALARY BETWEEN 1000 AND 2000;
--WHERE 행과 무관하게 단일 컬럼으로 리턴
SELECT * FROM DEPT D 
WHERE D.DEPTNO IN(SELECT E.DEPTNO FROM EMP E WHERE E.SAL>2000);

SELECT ENAME, SAL FROM EMP 
WHERE SAL>(SELECT AVG(SAL) FROM EMP);

SELECT ENAME, SAL FROM EMP
WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT ENAME, SAL FROM EMP
WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT D.DNAME FROM DEPT D
WHERE NOT EXISTS (SELECT E.ENAME FROM EMP E WHERE E.DEPTNO=D.DEPTNO AND E.SAL>3000);

SELECT D.DNAME FROM DEPT D
WHERE EXISTS (SELECT E.ENAME FROM EMP E WHERE E.DEPTNO=D.DEPTNO AND E.SAL>3000);

--수업예문
--Q1 부서명 부서이름 사원번호 사원명 봉급
--사원의 봉급이 2000초과인 사원만
SELECT D.DEPTNO , D.DNAME , E.EMPNO ,E.ENAME,SAL FROM DEPT d , EMP e
WHERE E.DEPTNO = D.DEPTNO AND E.SAL>2000;
--Q2 부서별 
--부서코드 부서명 급여평균 최대급여 최소급여 부서인원수
SELECT D.DEPTNO, D.DNAME , AVG(E.SAL), MIN(E.SAL), COUNT(*) FROM DEPT D, EMP E
WHERE E.DEPTNO = D.DEPTNO;

--예문
select d.deptno,d.dname, e.empno, e.ename, e.sal
from dept d join emp e on d.deptno=e.deptno
where (d.deptno,e.sal) in 
(select deptno,min(sal) from emp group by deptno);


SELECT D.DEPTNO, D.DNAME, AVG(E.SAL), MAX(E.SAL), MIN(E.SAL), COUNT(*)
FROM EMP E FULL OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE E.SAL IS NOT NULL GROUP BY D.DEPTNO,D.DNAME;




--============================================

--JOIN
--CARTESIAN PRODUCT 카티션 곱 , 상호조인
SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT *
FROM EMP A
CROSS JOIN DEPT B;
--INNER JOIN
SELECT E.EMPNO,E.ENAME,E.JOB,D.DNAME
FROM EMP E
INNER JOIN DEPT D --JOIN
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB='CLERK';

SELECT E.EMPNO,E.ENAME,E.JOB,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO=D.DEPTNO
AND E.JOB='CLERK';
--FULL OUTER JOIN
SELECT E.*,D.*
FROM EMP E
FULL OUTER JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO;
--LEFT OUTER JOIN
SELECT E.*,D.*
FROM EMP E LEFT OUTER JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO;
--WHERE E.DEPTNO IS NULL;
SELECT E.*,D.*
FROM EMP E ,DEPT D
WHERE E.DEPTNO=D.DEPTNO(+);

--RIGHT OUTER JOIN
SELECT E.*,D.*
FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO;
    
SELECT E.*,D.*
FROM EMP E ,DEPT D
WHERE E.DEPTNO(+)=D.DEPTNO;

--SELF JOIN
SELECT A.EMPNO,A.ENAME,A.JOB,A.MGR
    ,B.EMPNO,B.ENAME,B.JOB
FROM EMP A, EMP B
WHERE A.MGR=B.EMPNO;

/* SUB QUERY 서브쿼리
    SELECT / FROM / WHERE 
*/
--SELECT 결과가 반드시 단일 행 단일 값
SELECT E.ENAME
    ,(SELECT D.DNAME
        FROM DEPT D
        WHERE D.DEPTNO=E.DEPTNO) AS DEPTNAME
FROM EMP E
WHERE E.JOB='MANAGER';
--FROM INLINE VIEW 결과 반드시 하나의 테이블로 리턴
SELECT EMP_NAME,SALARY
FROM(SELECT E.ENAME AS EMP_NAME
    ,E.SAL AS SALARY
    FROM EMP E, DEPT D
    WHERE E.DEPTNO=D.DEPTNO
    AND D.DNAME='SALES')
WHERE SALARY BETWEEN 1000 AND 2000;
--WHERE 행과 무관하게 단일 컬럼으로 리턴
SELECT * FROM DEPT D
WHERE D.DEPTNO IN(SELECT E.DEPTNO FROM EMP E WHERE E.SAL>2000);

SELECT ENAME,SAL FROM EMP
WHERE SAL>(SELECT AVG(SAL) FROM EMP);

SELECT ENAME,SAL FROM EMP
WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT ENAME,SAL FROM EMP
WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);

SELECT D.DNAME
FROM DEPT D
WHERE EXISTS(SELECT E.ENAME
            FROM EMP E
            WHERE E.DEPTNO=D.DEPTNO
            AND E.SAL>3000);

SELECT D.DNAME
FROM DEPT D
WHERE NOT EXISTS(SELECT E.ENAME
            FROM EMP E
            WHERE E.DEPTNO=D.DEPTNO
            AND E.SAL>3000);

--Q1 부서코드 부서이름 사원번호 사원명 봉급
--사원의 봉급이 2000초과인 사원만
SELECT E.DEPTNO, D.DNAME,E.EMPNO,E.ENAME,E.SAL
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE E.SAL>2000;

--Q2 부서별 
--부서코드 부서명 급여평균 최대급여 최소급여 부서인원수 
SELECT D.DEPTNO, D.DNAME, AVG(E.SAL),MAX(E.SAL),MIN(E.SAL),COUNT(*)
FROM EMP E FULL OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO
WHERE E.SAL IS NOT NULL GROUP BY D.DEPTNO,D.DNAME;
--Q3
--부서별 고용인의 정보
--부서코드 부서명 사원번호 이름 직급 봉급
SELECT * FROM EMP;
SELECT D.DEPTNO,D.DNAME,E.EMPNO,E.ENAME,E.JOB,E.SAL FROM EMP E RIGHT OUTER JOIN DEPT D ON E.DEPTNO=D.DEPTNO ORDER BY DEPTNO;

--Q4
--부서별
--부서코드 부서명 사번 사원명 관리자사번 관리자명 해당사원의급여등급 등급최저급여 등급최고급여
SELECT d.DEPTNO 부서코드, d.DNAME 부서명, e.EMPNO 사번, e.ENAME 사원명, e.MGR 관리자사번, 
          m.ENAME 관리자명, e.SAL 급여,s.GRADE 등급, s.LOSAL 최저급여, s.HISAL 최고급여
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO LEFT JOIN EMP m ON e.MGR = m.EMPNO 
JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL ORDER BY d.DEPTNO;   

SELECT r1.deptno, r1.dname, r1.empno, r1.ename, r1.mgr, r1.sal, r1.mgr_NAME, S.GRADE ,S.LOSAL ,s.HISAL from
(SELECT r0.deptno, r0.dname, r0.empno, r0.ename,r0.mgr, r0.sal, e1.ename mgr_NAME FROM 
(SELECT d0.DEPTNO ,d0.DNAME ,e0.empno,e0.ename,e0.mgr,e0.sal 
FROM dept d0 
LEFT OUTER JOIN emp e0 ON d0.DEPTNO = e0.DEPTNO 
ORDER BY d0.DEPTNO ,e0.ENAME) r0
LEFT OUTER JOIN emp e1 ON r0.mgr=e1.empno) r1 
LEFT OUTER JOIN SALGRADE s ON (r1.sal BETWEEN s.losal AND s.hisal) ORDER BY r1.deptno, r1.empno;

-- Q1 ALLEN 사원의 직급과 동일한 사원들의 직급 사번 사원명 봉급 부서코드 부서명
SELECT e.JOB , e.EMPNO ,e.ENAME ,e.DEPTNO , d.dname FROM emp e 
JOIN dept d ON e.DEPTNO = d.DEPTNO WHERE e.JOB = (SELECT e1.job FROM emp e1 WHERE e1.ename='ALLEN');  

-- Q2 전체 평균 급여보다 많이 받는 사원의 사번 사원명 입사일(YYYY-MM-DD) 부서명 부서위치 급여 급여등급
SELECT E.EMPNO,E.ENAME,TO_CHAR(E.HIREDATE,'YYYY-MM-DD') HIREDATE , D.DNAME,D.LOC,E.SAL,S.GRADE 
FROM EMP E, DEPT D, SALGRADE S WHERE E.DEPTNO=D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL
AND E.SAL>(SELECT AVG(SAL) FROM EMP) ORDER BY E.SAL DESC,E.ENAME;
-- Q3 10번 부서의 인원 중 30번 부서에 없는 직급을 가진 직원의 사번 사원명 직급 부서코드 부서명 부서위치
SELECT E.EMPNO , E.ENAME , E.JOB,E.DEPTNO,D.DNAME,D.LOC FROM EMP E,DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.DEPTNO=10 AND NOT E.JOB IN (SELECT E.JOB FROM EMP E WHERE E.DEPTNO=30);
--Q4 SALESMAN의 최대급여보다 많이 급여를 받는 사람들의 사번 사원명 급여 등급
SELECT * FROM EMP;

SELECT E.EMPNO,E.ENAME,E.SAL,S.GRADE FROM EMP E,SALGRADE S WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND
E.SAL>(SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN');















create table sal_temp
as select * from salgrade;
select * from sal_temp;
INSERT INTO sal_temp(GRADE,LOSAL,HISAL)
VALUES(6,5000,7000);
UPDATE sal_temp SET LOSAL=3001,HISAL=4999
WHERE GRADE=5;
DELETE FROM sal_temp WHERE GRADE=3;
ROLLBACK;
commit;
drop table sal_temp;