-- STORED PROCEDURE 이후 수업


/***********************************************************************************
  8. 쿼리 문 에서 변수를 지정하고 사용하는 방법
  @       : SQL 에서의 전역 변수 . 
  DECLARE : SQL 문 내부의 지역 변수. 
  
  SQL 의 전역 변수 와 지역 변수 적용은 추후 STOREPROCEDURE 수업에서 확인.
  
  사용자 변수 : SET @[변수명] = 리터럴;
  DECARE [변수명] [데이터타입](용량);
  

  -. (변수에 값을 할당하는 연산 기호) :=
    . 조건절에 쓰이는 = 과 구분을 주어 가독성을 높이기 위하여 변수에 값을 할당 할 때는 := 를 사용한다. 
    . 필수 사항은 아님. 
    
    
  -. SQL 에서의 블럭 지정 BEGIN END 
   . BEGIN 시작 과 END 끝 을 통해 블럭을 지정하여 전역과 지역을 구분
    
  */



 -- 변수에 값을 대입하는 방법. @ 전역변수 
SET @S_ITEMCODE := '안녕하세요';
SET @I_LOTQTY   := 1;
 
SELECT @S_ITEMCODE 




/*##########################################################################
변수 
- 프로시저 또는 VIEW 등 함수 호출 형식으로 일괄 처리  블럭 형 SQL 에서 사용 
- 변수 의 선언 SET(사용자 변수)  , DECLARE( 지역변수 ) 
  > 값 할당 : SET 
- 변수에 값을 대입 할 때는 조건절 문법 등과 구분하기 위하여 := 기호를 사용한다.
- 사용자 정의 변수 @
  . 임의의 데이터를 담는 순간 자료형이 결정
  . 쿼리 문 어디에서 호출 가능.  
 ###########################################################################*/

DROP PROCEDURE IF EXISTS SP__DeclareSet;   
DELIMITER $$
CREATE PROCEDURE SP__DeclareSet 
( 
    P_itemcode varchar(30)
)
BEGIN
 -- =============================================
 -- Author :	    동상현
 -- Create date : 2024-05-10
 -- Description : 프로시저 에서 변수 사용하기 실습. 
 -- ============================================= 
	-- 사용자 정의 변수의 선언 과 사용   
	SET @P_ITEMNAME := '품명';  -- 문자열

	-- 여러줄 동시 설정
	SET @P_MAXSTOCK := 15,      -- 실수
		@P_UserVar := 'ROH1';  -- 문자열 
	
	   
		
   -- 프로시저 내의 지역 변수 와 사용자 정의 변수 선언 (블럭 지정)
   BEGIN
		 DECLARE S_LOCALvar VARCHAR(20);
        	SET S_LOCALvar := 'S_LOCALvar'; -- 다른 코드 블럭에서는 재생성 및 초기화 가능. 
       
      
     	SET @P_INSET := 'declare 내의 사용자 변수';      -- 실수
     
      SELECT @P_UserVar AS '사용자변수1', 
     		 -- S_PUBLICvar AS 'begin 외부 지역변수', -- 다른 코드블럭 에서 호출 불가  
     		 S_LOCALvar AS '지역변수', 
     		 @P_INSET   AS 'begin 내부의 사용자 변수';
	END; 
   
	SET @P_INSET := 'declare 내의 사용자 변수'; -- 프로시저 내부 어디서든 호출 가능.
	SELECT @P_INSET;
	
END $$
DELIMITER ;


 
CALL SP__DeclareSet('122');

 



       




/****************************************************************
 9. 분기문 (IF)
 조건에 따라 로직의 흐름을 제어 하는 명령문 */ 
DROP PROCEDURE IF EXISTS SP_branch;
DELIMITER $$
CREATE PROCEDURE SP_branch
(
	P_VALUE INT
)
BEGIN  
	SET @LS_VALUE2 = '';
	IF (P_VALUE > 900) THEN 
		SET @LS_VALUE2 = '900 보다 큽니다.'; 
	ELSEIF (P_VALUE > 400 AND P_VALUE <= 900) THEN 
		SET @LS_VALUE2 = '400 초과 900 이하입니다.'; 
	ELSE 
		SET @LS_VALUE2 = '400 보다 작습니다.'; 
	END IF;
	
	SELECT @LS_VALUE2;

END $$
DELIMITER ; 

CALL SP_branch(600); -- 400 초과 900 이하입니다.









 

/*##################################################################################################
 
- 여러 쿼리 를 동시에 수행하는 프로시저 만들기
- 품목의 입고 처리 와 재고 를 관리 하는 프로시저 만들기
- 재고 입고를 위한 처리 절차    
  1. 품목의 정보 확인 
     > 없는 품목일 경우 오류 메세지 반환
  2. 재고의 등록 (품목 이 있으면 UPDATE, 없으면 INSERT)
  
. SELECT INTO 		  : 조회 한 결과 를 변수 에 등록하기 .
. CURRENT_TIMESTAMP() : 데이터 베이스 서버의 시간 
*/

DROP PROCEDURE IF EXISTS SP_RegStock_I;
DELIMITER $$ 
CREATE PROCEDURE SP_RegStock_I
(
    P_itemcode varchar(30)   -- 품목 코드
   ,P_InQty    int           -- 입고수량
   ,P_Worker   varchar(30)   -- 입고 등록자 
   
)
BEGIN
 -- =============================================
 -- Author :	    동상현
 -- Create date : 2024-05-10
 -- Description : 재고 입고 및 이력 생성 
 -- =============================================   
 
	-- 1. 품목의 정보 확인
    DECLARE P_WHCODE  VARCHAR(10);
    DECLARE P_LOCCODE VARCHAR(10);
	
    -- 2. SELECT INTO 구문을 사용하여 변수에 값 할당
    SELECT WHCODE,   LOCCODE 
      INTO P_WHCODE, P_LOCCODE
      FROM t_itemmaster ti 
     WHERE ITEMCODE = P_itemcode;
 
	-- 3. 재고 수량 등록 ( 존재하면 UPDATE, 없으면 INSERT )
 	insert into t_stock (WHCODE ,  LOCCODE ,   ITEMCODE,   STOCKQTY, MAKER,   `MAKEDATE`) 
		 		values  (P_WHCODE, P_LOCCODE,  P_itemcode, P_InQty,  P_Worker, CURRENT_TIMESTAMP())
			 on DUPLICATE key 
		  update STOCKQTY = STOCKQTY + P_InQty,MAKER = P_Worker, `MAKEDATE` = CURRENT_TIMESTAMP();
		 
END $$
DELIMITER ; 


-- 프로시져의 실행	 
call SP_RegStock_I('12904-08160H',500,'SYSTEM');
call SP_RegStock_I('12904-08250H',500,'SYSTEM'); -- 재고 에 없는 품목을 넣었을 경우 INSERT 되는지 확인.
-- 결과 확인하기
SELECT * FROM t_stock WHERE ITEMCODE IN  ('12904-08160H','12904-08250H');












  -- 임시 테이블 # , @ 과  with