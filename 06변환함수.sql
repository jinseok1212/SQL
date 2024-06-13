--��ȯ �Լ�

--����ȯ �Լ�
--�ڵ�����ȯ�� �������ݴϴ�. (���ڿ� ���ڰ�, ���ڿ� ��¥)
SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; --���� -> ���� �ڵ�����ȯ�� �Ͼ
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '08/01/01'; -- ���� -> ��¥ �ڵ�����ȯ

--��������ȯ
--TO_CHAR -> ��¥�� ����
SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS �ð� FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YY-MM-DD AM HH12:MI:SS') AS TIME FROM DUAL;
SELECT TO_CHAR (SYSDATE, 'YY"��" MM"��" DD"��"') AS TIME FROM DUAL; --���˰��� �ƴ� ���� ������ ""���� ������� ��

--TO_CHAR -> ���ڸ� ����
SELECT TO_CHAR(20000, '9999999999') AS RESULT FROM DUAL; -- 9�ڸ� ���ڷ� ǥ��
SELECT TO_CHAR(20000, '0999999999') AS RESULT FROM DUAL; -- 9�ڸ� �� 0���� ä��
SELECT TO_CHAR(20000, '999') AS RESULT FROM DUAL; -- �ڸ����� �����ϸ� # ó���˴ϴ�.
SELECT TO_CHAR(20000.123, '999999.9999') AS RESULT FROM DUAL; -- ���� 6�ڸ�, �Ǽ� 4�ڸ�
SELECT TO_CHAR(20000, '$999,999,999') AS RESULT FROM DUAL; -- $��ȣ
SELECT TO_CHAR(20000, 'L999,999,999') AS RESULT FROM DUAL; -- �� �� ����ȭ�� ��ȣ

--���� ȯ�� 1372.17�� �� ��, SALARY���� �ѱ� ������ ǥ��
SELECT FIRST_NAME, TO_CHAR(SALARY * 1372.17, 'L999,999,999') AS ��ȭ FROM EMPLOYEES;

--TO_DATE ���ڸ� ��¥��
SELECT SYSDATE - TO_DATE('2024-06-13', 'YYYY-MM-DD') FROM DUAL; --��¥ ������ ���缭 ��Ȯ�� ����
SELECT TO_DATE('2024�� 06�� 13��', 'YYYY"��" MM"��" DD"��"') FROM DUAL; -- ��¥ ���� ���ڰ� �ƴ϶�� ""
SELECT TO_DATE('24-06-13 11�� 30�� 23��', 'YY-MM-DD HH"��" MI"��" SS"��"') FROM DUAL;

-- 2024��06��13�� �� ���ڷ� ��ȯ�Ѵٸ�?
SELECT '240613' FROM DUAL;
SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"��"MM"��"DD"��') AS �� FROM DUAL;

--TO_NUMBER ���ڸ� ���ڷ�
SELECT '4000' - 1000 FROM DUAL; --�ڵ�����ȯ
SELECT TO_NUMBER('4000') - 1000 FROM DUAL; --�������ȯ �� ����
SELECT TO_NUMBER('$5,500') - 1000 FROM DUAL; --�ڵ�����ȯ X
SELECT TO_NUMBER('$5,500', '$999,999') - 1000 FROM DUAL; --���ڷ� ������ �ڵ����� �Ұ����� ��� ����� ��ȯ
-------------------------------------------------------------
--NULLó�� �Լ�
SELECT NVL(1000, 0), NVL(NULL, 0) FROM DUAL; 
SELECT NULL + 1000 FROM DUAL; -- NULL�� ������ ���� NULL�� ����
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT AS �����޿� FROM EMPLOYEES;
SELECT FIRST_NAME, SALARY, COMMISSION_PCT, SALARY + SALARY * NVL(COMMISSION_PCT, 0) AS �����޿� FROM EMPLOYEES;

--NVL2 (���, NULL�� �ƴѰ��, NULL �� ���)

SELECT NVL2(NULL, 'NULL�� �ƴմϴ�', 'NULL�Դϴ�') FROM DUAL;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, NVL2(COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT , SALARY) AS �����޿� FROM EMPLOYEES;

-- COALESCE(��, ��, ��....) - NULL�� �ƴ� ù�� ° ���� ��ȯ ������
SELECT COALESCE(1, 2, 3) FROM DUAL; -- 1�� ���
SELECT COALESCE(NULL, 2, 3, 4) FROM DUAL; --2�� ���
SELECT COALESCE(NULL, NULL, 3, NULL) FROM DUAL; --3 ���
SELECT COALESCE(COMMISSION_PCT, 0) FROM EMPLOYEES; -- NVL�� ����

--DECODE (���, �񱳰�, �����, �񱳰�, �����......., ELSE��)
SELECT DECODE('A', 'A', 'A�Դϴ�') FROM DUAL; --IF��
SELECT DECODE('X', 'A', 'A�Դϴ�', 'A���ƴ�') FROM DUAL; -- IF~ELSE����
SELECT DECODE('B', 'A', 'A�Դϴ�'
                 , 'B', 'B�Դϴ�'
                 , 'C', 'C�Դϴ�'    
                 , '���� �ƴմϴ�'
                 )
FROM DUAL; --ELSE IF ����

SELECT * FROM EMPLOYEES;
SELECT JOB_ID, DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                    , 'AD_VP', SALARY * 1.2
                    , 'FI_MGR', SALARY * 1.3
                    , SALARY) AS �޿�
FROM EMPLOYEES;

--CASE WHEN THEN ELSE END (SWITCH���� ���)
SELECT JOB_ID,
       CASE JOB_ID WHEN 'IT_PROG' THEN SALARY * 1.1
                   WHEN 'AD_VP' THEN SALARY * 1.2
                   WHEN 'FI_MGR' THEN SALARY * 1.3
                   ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;
-- �񱳿� ���� ������ WHEN���� �� �� ����
SELECT JOB_ID,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.1
            WHEN JOB_ID = 'AD_VP' THEN SALARY * 1.2
            WHEN JOB_ID = 'FI_MGR' THEN SALARY * 1.3
            ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;
