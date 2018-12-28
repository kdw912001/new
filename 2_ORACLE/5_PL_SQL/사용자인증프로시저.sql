-- 프로시저 
-- 1. 사용자 인증 프로시저

-- 익명 프로시저
DECLARE
	V_MID EXAM_MEMBERS.MID%TYPE := '&아이디';
	V_PWD EXAM_MEMBERS.PWD%TYPE := '&비밀번호';
	V_MEMBER EXAM_MEMBERS%ROWTYPE;
	
	CURSOR CUR_MEMBER IS SELECT * FROM EXAM_MEMBERS WHERE MID=V_MID;
BEGIN
	OPEN CUR_MEMBER;
		FETCH CUR_MEMBER INTO V_MEMBER;
		IF CUR_MEMBER%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('회원이 존재하지 않습니다.');
		ELSIF V_PWD <> V_MEMBER.PWD THEN
			DBMS_OUTPUT.PUT_LINE('비밀번호가 일치하지 않습니다.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('인증 성공');
		END IF;	
	CLOSE CUR_MEMBER;
END;

CREATE or replace PROCEDURE VALIDATE_MEMBER
IS
	V_MID EXAM_MEMBERS.MID%TYPE := '&아이디';
	V_PWD EXAM_MEMBERS.PWD%TYPE := '&비밀번호';
	V_MEMBER EXAM_MEMBERS%ROWTYPE;
	
	CURSOR CUR_MEMBER IS SELECT * FROM EXAM_MEMBERS WHERE MID=V_MID;
BEGIN
	OPEN CUR_MEMBER;
		FETCH CUR_MEMBER INTO V_MEMBER;
		IF CUR_MEMBER%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('회원이 존재하지 않습니다.');
		ELSIF V_PWD <> V_MEMBER.PWD THEN
			DBMS_OUTPUT.PUT_LINE('비밀번호가 일치하지 않습니다.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('인증 성공');
		END IF;	
	CLOSE CUR_MEMBER;
END;

-- 생성한 프로시저 리스트
SELECT * FROM USER_PROCEDURES;

--프로시저 사용법
EXECUTE VALIDATE_MEMBER;

-- 기존 프로시저가 있으면 변경 없으면 생성
-- 프로시저 호출시 인자 전달 
CREATE OR REPLACE PROCEDURE VALIDATE_MEMBER 
(
	V_MID EXAM_MEMBERS.MID%TYPE,
	V_PWD EXAM_MEMBERS.PWD%TYPE
)
IS	
	V_MEMBER EXAM_MEMBERS%ROWTYPE;
	
	CURSOR CUR_MEMBER IS SELECT * FROM EXAM_MEMBERS WHERE MID=V_MID;
BEGIN
	OPEN CUR_MEMBER;
		FETCH CUR_MEMBER INTO V_MEMBER;
		IF CUR_MEMBER%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('회원이 존재하지 않습니다.');
		ELSIF V_PWD <> V_MEMBER.PWD THEN
			DBMS_OUTPUT.PUT_LINE('비밀번호가 일치하지 않습니다.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('인증 성공');
		END IF;	
	CLOSE CUR_MEMBER;
END;

EXECUTE VALIDATE_MEMBER('javaking','111');
EXECUTE VALIDATE_MEMBER('javakingddd','111');

-- 호출자에게 결과를 반환
CREATE OR REPLACE PROCEDURE VALIDATE_MEMBER 
(
	V_MID IN EXAM_MEMBERS.MID%TYPE,
	V_PWD IN EXAM_MEMBERS.PWD%TYPE, 
	V_RETURN OUT NUMBER --결과를 반환하기 위한 출력용변수	
)
IS	
	V_MEMBER EXAM_MEMBERS%ROWTYPE;	
	CURSOR CUR_MEMBER IS SELECT * FROM EXAM_MEMBERS WHERE MID=V_MID;
BEGIN
	OPEN CUR_MEMBER;
		FETCH CUR_MEMBER INTO V_MEMBER;
		IF CUR_MEMBER%NOTFOUND THEN
			V_RETURN := 1;
			DBMS_OUTPUT.PUT_LINE('회원이 존재하지 않습니다.');			
		ELSIF V_PWD <> V_MEMBER.PWD THEN
			V_RETURN := 1;
			DBMS_OUTPUT.PUT_LINE('비밀번호가 일치하지 않습니다.');
		ELSE
			V_RETURN := 0;
			DBMS_OUTPUT.PUT_LINE('인증 성공');
		END IF;	
	CLOSE CUR_MEMBER;
END;

-- 프로시저 사용1
DECLARE 
	V_R NUMBER;
BEGIN
	VALIDATE_MEMBER('javaking','111',V_R); --익명블럭에서 EXECUTE키워드 사용하지 않고 호출할수있음.
	DBMS_OUTPUT.PUT_LINE('RESULT : '||V_R);
END;

-- 프로시저 사용2
VARIABLE V_R NUMBER;
EXECUTE VALIDATE_MEMBER('javaking','111',:V_R);
PRINT V_R;
