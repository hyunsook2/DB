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
WHERE EXISTS (SELECT E.ENAME FROM EMP E WHERE E.DEPTNO=D.DEPTNO AND E.SAL>3000);

select d.deptno,d.dname, e.empno, e.ename, e.sal
from dept d join emp e on d.deptno=e.deptno
where (d.deptno,e.sal) in 
(select deptno,min(sal) from emp group by deptno);