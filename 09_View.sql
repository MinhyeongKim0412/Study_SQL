 /* 								
   - VIEW 
     . 자주 사용되는 SELECT 구문을 미리 만들어 두고 테이블 처럼 호출 하여 사용 할수 있도록 만든 기능.

	 . SQL Server의 View는 하나의 테이블로부터 특정 컬럼들만 보여주거나 특정 조건에 맞는 행을 보여주는데 사용될 수 있으며, 
	   두 개 이상의 테이블을 조인하여 하나의 VIEW로 사용자에게 보여주는데 이용될 수도 있다. 
	   VIEW 자체는 테이블처럼 실제 데이터를 가지고 있지는 않으며, 단지 SELECT문의 정의만을 가지고 있다.
	 
	 . 기본 키 값을 포함한 VIEW 에서삽입, 삭제, 수정 작업이 가능. 

	 . 보안상의 이유로 테이블중 일부 컬럼만 공개 하거나
	   불필요한 갱신 을 미연에 방지 하고자 할때 사용된다. 
 */					
 

  -- VIEW 의 작성

  /* 과일 가게 일자별 판매, 발주 리스트를 VIEW 형태로 만들고 (V_FruitbusinessList) VIEW 를 호출하여 데이터를 표현. */
 

  /**************************************************************************************/
  -- VIEW 의 생성 
  CREATE VIEW V_Fruit_Tran_List AS
  (
  SELECT  AA.DATE
	   ,AA.TITLE 
	   ,AA.CUSTNAME
	   ,AA.FRUIT
	   ,AA.AMOUNT * BB.unitprice AS totalcost
  FROM ( SELECT A.DATE	   AS DATE
		       ,'판매'	   AS TITLE 
		       ,B.name     AS CUSTNAME
			   ,A.FRUIT	   AS FRUIT
			   ,A.AMOUNT   AS AMOUNT 
		   FROM T_Saleshst A  JOIN t_customer B
		   						ON A.cust_id = B.cust_id
		 UNION ALL 
		 SELECT DATE								   AS DATE
		       ,'발주'							       AS TITLE  
			   ,CASE CUSTCODE WHEN 10 THEN '대림'
								WHEN 20 THEN '삼전'
								WHEN 30 THEN '하나' 
								WHEN 40 THEN '농협'
								END	 AS CUSTNAME
			   ,FRUIT                                AS FRUIT
			   ,AMOUNT                               AS AMOUNT 
		  FROM T_OrderList  ) AA JOIN t_fruitmaster BB
		  							 ON aa.fruit = BB.Fruit 
ORDER BY AA.DATE
) ;


-- View 생성 을 통해 복잡한 sql 을 미리 생성 해 두고 테이블 처럼 사용할 수 있다.
SELECT * FROM V_Fruit_Tran_List;
 



/******************** 실습 *******************************
 위에서만든 V_Fruit_Tran_List 를 이용해 
 과일가게에서 발주금액이 가장 많았던 업체와 발주금액 을 산출하세요 */ 







								
								
/* ************************************
   테이블의 기본 키 값을 가진 VIEW 의 생성 과 데이터 삭제 및 등록.  */ 
    CREATE VIEW V_TEST AS
	(
	SELECT CUST_ID,NAME
	  FROM T_Customer
	 WHERE CUST_ID > 2
	);
 

	 -- 데이터의 등록
	 INSERT INTO V_TEST (CUST_ID, NAME)
				 VALUES (9,'최형배');
	

	-- VIEW 에서 등록 한 윤종신 의 정보를 T_Customer 테이블에서 확인 가능.
	 SELECT * 
	   FROM T_Customer ;

	  
	  
	 -- 데이터 의 삭제 
	 DELETE FROM  V_TEST 
	  WHERE CUST_ID = 9;
	 

	 -- VIEW 의 삭제
     DROP VIEW IF EXISTS V_TEST;
	 SELECT * FROM V_TEST;

	 


/********* 실습 ****************************
  Cahp03_Join_Union 내용의 POINT 1 를 참조하여 

  일자 별 총 판매금액 VIEW 로 만들고 (V_DAY_SALELIST)
  일자 별 총 발주금액 VIEW 를 생성 후 (V_DAY_ORDLIST)

  생성 한 VIEW 를 통해 
  거래(판매,발주)  된 전체 내역의 마진을 구하세요 (TOTALMARGIN)*/ 
 
 
 
 
 
 
 
 