use exam;

-- 1) 'ALLEN'의 직무와 같은 사람의 이름, 부서명, 급여, 직무를 출력하세요.
select ENAME,DNAME,SAL,JOB
from EMP e
JOIN dept d
ON E.DEPTNO = D.DEPTNO
where JOB = (select JOB FROM EMP WHERE ename = 'ALLEN')
;

-- 2) JONES가 속해있는 부서의 모든 사람의 사원번호, 이름, 입사일, 급여를 출력하세요
select empno , ename , hiredate, sal
from EMP 
where DEPTNO = (select DEPTNO FROM EMP WHERE ENAME = 'JONES');

-- 3) 전체 사원의 평균 임금보다 많은 사원의 사원번호, 이름, 부서명, 입사일, 지역, 급여를 출력하세요
 select EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL
 FROM EMP E
 JOIN dept D
 ON E.DEPTNO = D.DEPTNO
 where SAL >= (SELECT AVG(SAL) FROM EMP);
 
 -- 4) 10번 부서와 같은 일을 하는 사원의 사원번호, 이름, 부서명, 지역, 급여를 급여가 많은 순(정렬-내림차순)으로 출력하세요.
SELECT EMPNO, ENAME, DNAME, LOC, SAL
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB in (select JOB FROM emp where DEPTNO = 10)
ORDER BY SAL desc;

-- ODER BY의 순서는 WHERE이 있으면 WHERE밑에 적어주고 없으면 ON 밑에 적어준다(DESC는 오름차순, ASC는 내림차순)

-- 5) 'MARTIN'이나 'SCOTT'의 급여와 같은 사원의 사원번호, 이름, 급여를 출력하세요. (다중연산자)
select EMPNO, ENAME, SAL
FROM EMP 
where SAL IN (select SAL FROM EMP WHERE ENAME IN('MARTIN','SCOTT'))
;
-- MARIN과 SCOTT의 급여
-- select SAL FROM EMP WHERE ENAME IN('MARTIN','SCOTT');

-- 6) 부서번호가 30번 부서의 최고 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하세요.
select EMPNO, ENAME, SAL
from EMP
where SAL > (select MAX(SAL) FROM EMP where DEPTNO = 30)
;
-- 부서번호 30번 부서의 최고급여
-- select MAX(SAL) FROM EMP where DEPTNO = 30;

--  7) 사원중에서 급여(sal)와 보너스(comm)을 합친 금액이 가장 많은 경우와 가장 적은 경우, 평균 금액을 구하세요. (함수 이용)
select MAX(SAL + ifnull(COMM,0)) MAX,
	   MAX(SAL + ifnull(COMM,0)) MIN,
	   AVG(SAL + ifnull(COMM,0)) AVG
FROM EMP
;

-- 8) 부서별로 급여합계를 구하세요.(함수와 GROUP BY를 이용)
-- 급여합계
SELECT SUM(SAL) 
FROM EMP
group by DEPTNO 
;
 
 -- 9) 급여가 3000이상이면, 급여+급여의 15%의 격려금을, 급여가 2000이상이면, 급여+급여의 10%의 격려금을,급여가 1000이상이면, 급여+급여의 5%의 격려금을, 그렇지 않으면 급여를 구하여, 이름, 직업, 급여,격려금을 표시하시오. [HINT : CASE WHEN사용(구글로 검색해보세요.)]
-- 이름,직업,급여	
-- 격려금= CASE WHEN 조건 THEN 참이될결과 ELSE 거짓될결과  (CASE WEN 문법)
select ENAME, JOB, SAL, CASE WHEN SAL >= 3000 THEN SAL + SAL * 0.15
							 WHEN SAL >= 2000 THEN SAL + SAL * 0.1
							 WHEN SAL >= 1000 THEN SAL + SAL * 0.05
							 ELSE SAL
							 END AS ENCOURAGEMENT
FROM EMP; 

-- 10) 'MARTIN'과 같은 매니저와 일하는 이름, 직업, 급여, 부서명, 지역을 구하세요.
select ENAME , JOB , SAL , DNAME , LOC
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE MGR = (select MGR from EMP WHERE ENAME = 'MARTIN')
;

-- 11) 부서명이 'RESEARCH'인 사람의 이름, 직업, 급여,부서명을 표시하시오.
select ENAME, JOB, SAL, DNAME
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE DNAME = 'RESEARCH'
;

-- 12) 각 부서별 평균 급여를 구하고, 그 중에서 평균 급여가 가장 적은 부서의 평균 급여보다 적게 받는 사원들(MIN이용)의 부서명, 지역, 급여를 구하세요.
-- 사원들이 부서명, 지역, 급여를 구함
select DNAME,LOC,SAL
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE SAL < (
				SELECT MIN(AVGSAL)			-- 함수인 MIN을 쓸때 띄어쓰기를 하면 에러가 뜬다(모든함수가 다 그럼)
				FROM(				
					 SELECT AVG(SAL) AVGSAL
					 FROM EMP
					 GROUP BY DEPTNO
					) AS MINSALVIEW
		   )
;

-- SELECT MIN (avgSAL)
-- FROM(				-- 테이블로 묶음(가짜 테이블)
-- 각 부서별 평균 급여
-- SELECT AVG(SAL)
-- FROM EMP
-- GROUP BY DEPTNO
-- )AS MINSALVIEW

-- 13) 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데 'BLAKE'는 빼고 출력하라.
select ENAME, HIREDATE
FROM EMP
WHERE DEPTNO = (select DEPTNO FROM EMP WHERE ENAME = 'BLAKE')
AND ENAME != 'BLAKE'
;

-- 14) 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고있는 사원의 사원번호와 이름을 출력하라.
select EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN( 
		SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%'				-- 이름에 'T'를 포함하고 있는 
)
;

-- 15) 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는 사원  (AND 조건) 과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름, 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO IN(
				select DEPTNO FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP)
				AND ENAME LIKE '%S%'
)
;

-- 16) 커미션을 받는 사원과 부서번호, 월급이 같은 사원의 이름, 월급, 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (		-- 커미션을 받는 사원과 부서번호
				SELECT  DEPTNO
				FROM EMP
				WHERE COMM IS NOT NULL   -- NULL값이 아닌것을 출력
				AND COMM>0  			 -- 0값까지 생각함
)
AND SAL IN(				-- 커미션을 받는 사원과 급여
				SELECT SAL
				FROM EMP
                WHERE COMM IS NOT NULL
                AND COMM > 0
		  )
;

-- 17) 직업명과 사원의 등급을 직업이 'PRESIDENT' 이면 'A', 직업이 'ANALYST' 이면 'B', 직업이 'MANAGER' 이면 'C', 직업이 'SALESMAN' 이면 'D', 직업이 'CLEARK' 이면 'E' 로 표시하시오.(CASE WHEN 이용)
SELECT JOB, CASE WHEN JOB = 'PRESIDENT' THEN 'A' 
				 WHEN JOB = 'ANALYSE'   THEN 'B'
				 WHEN JOB = 'MANAGER'   THEN 'C'
				 WHEN JOB = 'SALESMAN'  THEN 'D'
				 ELSE 'E'
                 END GRADE
FROM EMP;

-- 18) 10번 부서중에서 30번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명,입사일, 지역을 출력하라.
SELECT EMPNO , ENAME, DNAME, HIREDATE, LOC
FROM EMP E 
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 10
AND E.JOB NOT IN (
					SELECT JOB
					FROM EMP
                    WHERE DEPTNO = 30
                    )
;
-- 30번 업무에 있는 직업 파악(SALESMAN,MANAGER,CLERK)
-- select JOB 
-- FROM EMP
-- WHERE DEPTNO = 30;

-- 19) 급여가 30번 부서의 최고 급여보다 높은 사원의 사원번호, 이름, 급여를 출력하라.


-- 20) 급여가 30번 부서의 최저 급여보다 낮은 사원의 사원번호, 이름, 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < (							-- 30번 부서의 최고 급여 파악(2850)
				SELECT MIN(SAL)
				FROM EMP
				WHERE DEPTNO = 30
			)
;

-- 21) 사원 중에서 입사일이 가장 빠른 사원의 사원번호, 이름, 입사일, 부서명을 출력하세요.
SELECT EMPNO, ENAME, HIREDATE, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE HIREDATE = (SELECT MIN(HIREDATE) FROM EMP)
;

-- 22) 평균 연봉보다 많이 받는 사원들의 사원번호, 이름, 연봉을 연봉이 높은 순으로 정렬하여 출력하세요 (연봉은 sal*12+comm으로 계산) HINT : IFNULL사용(구글로 검색해보세요.)
SELECT EMPNO, ENAME, SAL*12+IFNULL(COMM,0) AS YSAL
FROM EMP
WHERE SAL*12+IFNULL(COMM,0) > (														-- WHERE 내 연봉> 평균연봉  (조건)
								SELECT EMPNO, ENAME, SAL*12+IFNULL(COMM,0) AS AVGYSAL		-- 평균연봉
								FROM EMP
							  )
;

SELECT EMPNO, ENAME, SAL*12+IFULL(COMM,0) AS AVGYSAL		-- 평균연봉
FROM EMP
