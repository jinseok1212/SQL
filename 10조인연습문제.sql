--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT *
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES E
FULL OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT /*CONCAT()*/E.FIRST_NAME || E.LAST_NAME,
        D.DEPARTMENT_ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 200;
--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT E.FIRST_NAME AS �̸�,
        E.JOB_ID,
        J.JOB_TITLE
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY �̸�;
--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT *
FROM JOBS J
LEFT OUTER JOIN JOB_HISTORY B
ON J.JOB_ID = B.JOB_ID;
--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT E.FIRST_NAME,
        E.LAST_NAME,
        D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE FIRST_NAME = 'Steven' AND LAST_NAME = 'King';
--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * FROM EMPLOYEES E
CROSS JOIN DEPARTMENTS D;
--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT E.SALARY,
        E.FIRST_NAME,
        E.SALARY,
        D.DEPARTMENT_NAME,
        L.STREET_ADDRESS
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';
--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT *
FROM EMPLOYEES E
LEFT JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE IN ('Stock Manager','Stock Manager');
--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT *
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE D.MANAGER_ID IS NULL;
--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT CONCAT(E2.FIRST_NAME || ' > ', E.FIRST_NAME) AS �Ŵ���
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID;
--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT E.FIRST_NAME, --���
        E.SALARY,
        E2.FIRST_NAME AS �Ŵ�����,
        E2.SALARY AS �Ŵ����Ǳ޿�
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES E2
ON E.MANAGER_ID = E2.EMPLOYEE_ID
WHERE E.MANAGER_ID IS NOT NULL
ORDER BY E.SALARY DESC;
