-- 프로시저 (부서번호가 10번 사원을 출력)
-- //는 구분선
DELIMITER //
CREATE PROCEDURE PR1(A VARCHAR(2))
BEGIN
		SELECT * FROM EMP WHERE DEPTNO= A;
END
//
DELIMITER ;

-- PR1 프로시저 호출(부서번호 10을 매개변수 A에 셋팅)
 CALL PR1(10) ;


-- 함수
show global variables like 'log_bin_trust_function_creators';
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
	-- 함수 선언
    CREATE FUNCTION FU1(A int, B int)	returns int
    BEGIN	
		RETURN A + B;
	END
//
DELIMITER ;
-- FU1 함수 호출
SELECT FU1(10,20)
    
    
   
   
   
   
   
   
DELIMITER //
CREATE FUNCTION FU2() returns double
BEGIN
	-- 변수 선언(DECLARE)
    DECLARE R DOUBLE; 
	SELECT AVG(SAL)
    INTO R
    FROM EMP;
    return R;
 END
 //
 DELIMITER ; 
 -- FU2 함수 호출
 SELECT FU2();
   
   
   DELIMITER //
   CREATE FUNCTION F_SALES(B int) RETURNS int
   BEGIN
		declare A INT;
		SELECT SUM(sal) 
        INTO A
		FROM emp
        where DEPTNO = B
        group by deptno;
        RETURN A;
   END
   //
   DELIMITER ;
   
   drop function F_SALES;
   select F_SALES(10);
    
    