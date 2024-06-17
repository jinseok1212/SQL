--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);

--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES);
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID='IT_PROG');
--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
--- EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
SELECT * FROM EMPLOYEES WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');
--- EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');
--- Steven�� ������ �μ��� �ִ� ������� ������ּ���.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');
--- Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.
SELECT * FROM EMPLOYEES WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'); --2200���� ū
--���� 4.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT E.EMPLOYEE_ID,
    CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
    E.DEPARTMENT_ID,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--���� 5.
--���� 4�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT E.EMPLOYEE_ID,
    CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
    E.DEPARTMENT_ID,
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_ID
FROM EMPLOYEES E;

--���� 6.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT D.DEPARTMENT_ID,
        D.DEPARTMENT_NAME,
        L.STREET_ADDRESS,
        L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;
--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT DEPARTMENT_ID,
        DEPARTMENT_NAME,
        (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS STREET_ADDRESS,
        (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) AS CITY
FROM DEPARTMENTS D;

--���� 8.
--LOCATIONS���̺� COUNTRIES���̺��� ��Į�� ������ ��ȸ�ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT L.LOCATION_ID,
        L.STREET_ADDRESS,
        L.CITY,
        (SELECT COUNTRY_ID FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) AS COUNTRY_ID,
        (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L;
----------------------------------------------------------------------------------------------------
--���� 9.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT RN,
        FIRST_NAME
FROM (SELECT ROWNUM AS RN,
            A.*
            FROM (SELECT *
                    FROM EMPLOYEES
                    ORDER BY FIRST_NAME DESC
            ) A
)
WHERE RN BETWEEN 41 AND 50;
            
--���� 10.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT RN,
        EMPLOYEE_ID,
        FIRST_NAME,
        PHONE_NUMBER,
        HIRE_DATE
FROM (SELECT ROWNUM AS RN,
            A.*
        FROM (SELECT *
        FROM EMPLOYEES
        ORDER BY HIRE_DATE) A
        )
WHERE RN BETWEEN 31 AND 40;

        
--���� 11.
--COMMITSSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������. (�ζ��κ並 ���� �˴ϴ�)
SELECT *
FROM (SELECT SALARY + SALARY * NVL(COMMISSION_PCT, 0) AS �޿�,
        SALARY,
        FIRST_NAME
        FROM EMPLOYEES
        )
WHERE �޿� >= 10000;
--------------------------------------------------------------------------------
--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.
/*SELECT *
FROM (SELECT ROWNUM AS RN,
        A.*
    FROM (
            SELECT EMPLOYEE_ID,
                CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
                HIRE_DATE,
                DEPARTMENT_NAME
        FROM EMPLOYEES E
        LEFT JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        ORDER BY HIRE_DATE) A
)
WHERE RN > 10 AND RN <= 20;
*/
SELECT *
FROM(SELECT ROWNUM AS RN,
        A.*,
        (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
        FROM( --�ζ��κ� ��ü�� ���̺�� ������
        SELECT EMPLOYEE_ID,
            CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
            HIRE_DATE,
            DEPARTMENT_ID
    FROM EMPLOYEES E
    ORDER BY HIRE_DATE) A)
WHERE RN > 10 AND RN <= 20;
--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.

--�̰Ŵ� ������ �� �������� �غ�
SELECT ROWNUM AS RN,
        A.*,
        D.DEPARTMENT_NAME
FROM (--�ζ��� ��� ���̺� �ڸ� ���� ��
    SELECT FIRST_NAME,
            SALARY,
            DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE JOB_ID = 'SA_MAN'
    ORDER BY SALARY DESC
) A 
LEFT JOIN DEPARTMENTS D
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;
--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� ���� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.
SELECT DEPARTMENT_NAME,
       MANAGER_ID,
FROM (SELECT COUNT(*),
        DEPARTMENT_NAME,
        MANAGER_ID
    FROM DEPARTMENTS 
    ORDER BY COUNT(*) DESC)
LEFT JOIN EMPLOYEES
ON 

--����15
--�μ��� ��� �÷�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���
--
--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���