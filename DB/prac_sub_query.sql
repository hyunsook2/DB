
-- 1. EMP 테이블에서 BLAKE보다 급여가 많은 사원들의 사번, 이름, 급여를 검색하시오.
SELECT * FROM EMP;
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL >= (SELECT SAL FROM EMP WHERE ENAME = 'BLAKE');

-- 2. EMP 테이블에서 MILLER보다 늦게 입사한 사원의 사번, 이름, 입사일을 검색하시오.
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'MILLER');

-- 3. EMP 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색하시오.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

-- 4. EMP 테이블에서 CLARK와 같은 부서이며, 사번이 7698인 직원의 급여보다 많은 급여를 받는 사원들의 사번, 이름, 급여를 검색하시오.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'CLARK')
AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7698);

--서브쿼리 예제 추가

-- 5.문제 : 사번이 '7844'인 사원의 사번, 이름, job 을 출력!
SELECT EMPNO,ENAME,JOB FROM EMP WHERE EMPNO=7844;

-- 6.문제 : 사번이 '7844'인 사원의 job 과 동일한 job 인 사원의 사번, 이름, job 을 출력!
SELECT EMPNO,ENAME,JOB FROM EMP WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7844);

-- 7.문제 : 사번이 '7521' 인 사원의 job 과 동일하고 '7900' 인 사번의 급여보다 많은 급여를 받는 사원의 사번, 이름, job, 급여를 출력하라
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE JOB =  (SELECT JOB FROM EMP WHERE EMPNO = 7521)
AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7900);

-- 8.문제 : 가장 적은 급여를 받는 사원의 사번, 이름, 급여를 출력!
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL = (SELECT MIN(SAL) FROM EMP);

-- 9.문제 : 부서별 최소 급여 중에서 30번 부서의 최소급여보다는 큰 최소급여인 부서의 부서번호, 최소 급여를 출력하라
SELECT DEPTNO, MIN(SAL) FROM EMP
WHERE (DEPTNO, SAL) NOT IN (SELECT DEPTNO, MIN(SAL) FROM EMP WHERE DEPTNO = 30 GROUP BY DEPTNO) 
GROUP BY DEPTNO HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 30) ORDER BY DEPTNO;

-- 10.문제 : job이 CLERK 인 사원이 2명 이상 있는 부서의 부서번호, 부서명을 출력하라


--11.문제 : job 이 'CLERK' 인 사원이 한명이라도 있는 부서의 부서명만 출력하라


--12.문제 : 각 부서별로 최소 급여를 받는 사원의 부서번호, 부서명, 사번, 이름, 급여를 출력하라


--13.문제 : 직속상사가 없는 사원을 포함해서 부하직원사번, 부하직원명, 직속상사사번, 직속상사명을  출력하라


--14.문제 : 평균 급여보다 많거나 같고 최대 급여보다는 적은 급여를 받는 사원의 사번, 이름, 급여를 출력하라


--15.문제 : 월급이 높은 순으로 사번, 이름, 월급을 상위 5명만 출력하라

