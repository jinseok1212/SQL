--문자열 함수
SELECT LOWER('HELLO WORLD') FROM DUAL; --SQL을 간단하게 연습하기 위한 가상테이블

SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME) FROM EMPLOYEES;

-- LENGTH 문자열 길이
-- INSTR 문자열 찾기
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES;
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'A') FROM EMPLOYEES; -- A가 있는 위치를 반환함, 없는 경우는 0 을 반환

-- SUBSTR 문자열 자르기
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES; --3미만 절삭, 3번째 위치에서 2개 자름

-- CONCAT 문자열 합치기
SELECT FIRST_NAME || LAST_NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD - 범위를 지정하고, 특정문자로 채움
SELECT LPAD('ABC', 10, '*') FROM DUAL; -- ABC를 10칸 잡고 나머지 부분은 왼쪽에서 * 채움
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES;

-- LTRIM, RTRIM, TRIM - 공백삭제 또는 문자삭제
SELECT TRIM('   HELLO WORLD   '), LTRIM('   HELLO WORLD   '), RTRIM('   HELLO WORLD   ') FROM DUAL;
SELECT LTRIM('HELLO WORLD', 'HE')FROM DUAL;

--REPLACE 문자열 변경
SELECT REPLACE('서울 대구 대전 부산 찍고', ' ', '->') FROM DUAL; --공백을 ->로 변경
SELECT REPLACE('서울 대구 대전 부산 찍고', ' ', '') FROM DUAL;-- 공백을 삭제
------------------------------------------
--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT CONCAT(FIRST_NAME, LAST_NAME), REPLACE(HIRE_DATE, '/', '') FROM EMPLOYEES;

--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT LPAD(SUBSTR(PHONE_NUMBER,4), 11, '02') FROM EMPLOYEES;

--문제 3. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT RPAD(SUBSTR(LOWER(FIRST_NAME), 0, 3 ), LENGTH(FIRST_NAME), '*') AS NAME, LPAD(SALARY, 10, '*') FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG');
