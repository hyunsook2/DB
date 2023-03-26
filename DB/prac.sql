--<JOIN함수 예제>

-- 1. DEPT 테이블과 EMP 테이블에서 사번, 사원명, 부서코드, 부서명을 검색하시오. (사원명 오름차순 정렬)
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT EMPNO,ENAME,DEPT.DEPTNO,DNAME FROM EMP 
	JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO ORDER BY ENAME ASC;
    --(오더바이 기본값이 오름차순(ASC 생략가능) 내림차순이면 DESC를 뒤에쓰기
    
-- 2. DEPT 테이블과 EMP 테이블에서 사번, 사원명, 급여, 부서명을 검색하시오. 
--단, 급여가 2000 이상인 사원에 대하여 급여기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,SAL,DEPT.DNAME FROM EMP JOIN DEPT 
ON EMP.DEPTNO=DEPT.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;

-- 3. DEPT 테이블과 EMP 테이블에서 사번, 사원명, 업무, 급여, 부서명을 검색하시오. 
--단, 업무가 MANAGER이며 급여가 2500 이상인 사원에 대해, 사번을 기준으로 오름차순 정렬할 것.
SELECT EMPNO,ENAME,JOB,SAL,DEPT.DNAME FROM EMP
JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO WHERE JOB='MANAGER' 
AND SAL>=2500 ORDER BY EMPNO ASC;

-- 4. EMP 테이블과 SALGRADE 테이블에서 사번, 사원명, 급여, 등급을 검색하시오. 
--단, 등급은 급여가  LOSAL과 HISAL 범위에 포함되고 등급이 4이며 급여를 기준으로 내림차순 정렬할 것.
SELECT * FROM SALGRADE; --2001~3000

SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE 
	ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC;
-- 5. DEPT 테이블, EMP 테이블, SALGRADE 테이블에서 사번, 사원명, 부서명, 급여, 등급을 검색하시오.
--단, 등급은 급여가 LOSAL과 HISAL 범위에 포함되며 등급을 기준으로 내림차순 정렬할 것.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP 
JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO 
JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;

-- 6. EMP 테이블에서 사원명과 해당 사원의 관리자명을 검색하시오.
SELECT * FROM EMP;

SELECT W.ENAME 사원명 ,M.ENAME 관리자명 FROM EMP 
	W JOIN EMP M ON W.MGR=M.EMPNO;
    
-- 7. EMP 테이블에서 사원명과 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색하시오.
SELECT W.ENAME 사원명,M.ENAME 관리자명,MM.ENAME 관리자의_관리자명
    FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO JOIN EMP MM ON M.MGR=MM.EMPNO; 

-- 8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오.
SELECT W.ENAME 사원명,M.ENAME 관리자명,MM.ENAME 관리자의_관리자명 FROM EMP W 
	LEFT JOIN EMP M ON W.MGR=M.EMPNO LEFT JOIN EMP MM ON M.MGR=MM.EMPNO; 
    