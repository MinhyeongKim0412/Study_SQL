/*************************************************************************************************************************************
** 관계형 데이터 베이스 를 사용하기 위한 가장 중요한 검색 문법 
   반드시 사용법을 잘 숙지 할수 있도록 할것. 

1. 테이블 간 데이터 연결 및 조회 (JOIN)
  JOIN : 둘 이상의 테이블을 연결해서 데이터를 검색하는 방법
         테이블을 서로 연결하기 위해서는 하나 이상의 컬럼을 공유 하고 있어야함.   
    ON : 두 테이블간의 관계 를 지어줄 컬럼 또는 조건을 작성한다.
	

   내부조인 (INNER JOIN) : JOIN (관계를 가지는 테이블 의 데이터 중 둘다 존재 할 경우 표현) 
   외부조인 (OUTER JOIN) : LEFT JOIN, RIGHT JOIN (기준 테이블에 따라 다른 결과)
     . 기준 테이블의 모든 값이 포함된 결과 에서 부가적인 정보를 확인 하기 위하여 사용.
     . LEFT JOIN  : 왼쪽에 기술한 테이블을 기준 테이블로 결정함 
     . RIGHT JOIN : 오른쪽에 기술한 테이블을 기준 테이블로 결정함

   기준 테이블 : 테이블 간 데이터 를 연계할때 가장 많은 정보를 포함하거나 
	             표현할 데이터의 Key 를 포함하는 테이블.  
	     
  */

 -- ****** JOIN  (INNER JOIN)
 -- 테이블간 공통으로 존재하는 데이터만 조회.  


  -- JOIN 을 통한 데이터 추출 ( 두 테이블 간의 연결 )
  -- 아래와 같은 결과 에서 원하는 컬럼을 추출하는 방식.

  SELECT A.Cust_id,
  		 B.Name, 
         A.fruit
    FROM T_Saleshst A JOIN T_Customer B           -- 연결 할 테이블 기술 및 별칭 
					    ON A.CUST_ID = B.CUST_ID; -- 테이블간 관계를 설정 
  
  
  
					    
					    
					    
   /* 고객 마스터(T_Customer) 테이블과 판매현황(T_Saleshst) 테이블 을 
    각각 T_Customer.CUST_ID, T_Saleshst.CUST_ID 로 관계를 맺고 
	고객 ID (cust_id), 고객이름(Name) , 판매일자(Date), 과일(Fruit), 판매수량(Amount) 을 표현 하세요 . */
	
  -- ** 명시적 표현법 JOIN 문과 ON 을 써서 표현하는 방법. 
  SELECT A.CUST_ID
        ,A.NAME
		,B.DATE
		,b.fruit 
		,B.AMOUNT 
    FROM T_Customer A JOIN T_Saleshst B -- INNER JOIN = JOIN   
				        ON A.CUST_ID = B.CUST_ID;
  -- JOIN : T_Customer 테이블을 기준으로 조회 하지만.
  --        T_Saleshst 테이블에 7 성시경, 8 임재범 에 대한 
  --        거래 내역 데이터가 없으므로 제외 되어 조회됨. 

  SELECT * FROM T_Customer;
  SELECT * FROM T_Saleshst; 
				          
  

 
 
 
 
  -- 묵시적 표현법 
  -- JOIN 문을 쓰지 않고, 로  테이블을 나열 후  WHERE 절에 참조 될 컬럼을 정의 
  SELECT A.CUST_ID
        ,A.NAME
		,B.DATE
		,B.fruit 
		,B.AMOUNT 
    FROM T_Customer A ,T_Saleshst B -- INNER JOIN = JOIN   
   WHERE A.CUST_ID = B.CUST_ID 
	 AND B.DATE = '2023-12-03';
	
	
	
	
	
	
# 실습 ############################################
-- 위 쿼리 내용을 참조 하여 과일 정보 테이블 t_fruitmaster 를 INNER join 을 활용하여 
-- 일자 별 판매 현황을 조회해 보세요
-- 고객ID, 고객명, 과일명, 판매수량, 판매일자.
 





    
 

  -- JOIN 테이블 을 하위 쿼리로 작성 하여 연결 하기 .
  -- 조회 를 원하는 데이터가 가공된 임시 테이블 형태를 JOIN 하여 표현.
  -- JOIN 비교 대상의 표본이 줄어들어 리소스를 줄일 수 있음  

  SELECT A.CUST_ID
        ,A.NAME
		,B.FRUIT
		,B.DATE
    FROM T_Customer A JOIN (SELECT CUST_ID
	                              ,FRUIT
								  ,DATE
							  FROM T_Saleshst
							 WHERE DATE < '2023-12-04'
							) B
				         ON A.CUST_ID = B.CUST_ID;



  -- **** LEFT JOIN (LEFT OUTER JOIN)
  -- 왼쪽에 있는 테이블의 데이터를 기준으로 오른쪽에 있는 테이블의 데이터를 검색 하고 오른쪽 테이블에 데이터가 없을경우 NULL 로 표시된다. 
  

   /* 왼쪽에 있는 T_Customer 의 내용을 기준으로 
	 고객 별 판매현황을 나타 내세요 */
  SELECT A.CUST_ID
        ,A.NAME
        ,A.Address 
		,B.DATE
		,B.FRUIT
		,B.AMOUNT 
    FROM T_Customer A LEFT JOIN T_Saleshst B  
						 ON A.CUST_ID = B.CUST_ID;
-- 고객 테이블에 는 존재하는 성시경 고객 정보는 표현되나 판매이력 데이터는 NULL.

						

						
	
						

  /* 왼쪽에 있는 T_Saleshst 의 내용을 기준으로 
	 판매현황 별 고객 정보 표현 */
  SELECT B.CUST_ID
        ,B.NAME
		,A.DATE
		,A.fruit 
		,A.AMOUNT 
    FROM T_Saleshst A LEFT JOIN T_Customer  B 
						      ON A.CUST_ID = B.CUST_ID;
-- 판매 리스트에 존재하지 않는 성시경 의 데이터는 표현되지 않음. 



						     
						     

						     
						     
						     

  -- **** RIGHT JOIN (RIGHT OUTER JOIN)
  -- 오른쪽에 있는 테이블의 데이터를 기준으로 왼쪽에 있는 테이블의 데이터를 검색 하고 왼쪽 테이블에 데이터가 없을경우 NULL 로 표시된다. 

    /* 오른쪽에 있는 T_Customer 의 내용을 기준으로 
	   고객 별 판매현황을 나타 내세요  */
  SELECT B.CUST_ID
        ,B.NAME
		,A.DATE
		,A.fruit 
		,A.AMOUNT 
    FROM T_Saleshst A RIGHT JOIN T_Customer  B 
						      ON A.CUST_ID = B.CUST_ID;
-- 고객 테이블에 는 존재하는 이수 와 윤종신의 고객 정보 표현됨 판매 데이터는  NULL.

  
						      
						      
						      
						      
						      
  /* 오른쪽에 있는 T_Saleshst 의 내용을 기준으로 
	 고객 별 판매현황을 나타 내세요 */
      SELECT A.CUST_ID
        ,A.NAME
		,B.DATE
		,B.fruit
		,B.AMOUNT 
    FROM T_Customer A RIGHT JOIN T_Saleshst B  
						      ON A.CUST_ID = B.CUST_ID;
 --  T_Saleshst 테이블에는 7 번 고객 성시경 의 구매 내역이 없으므로 
 --  검색 결과에 나타나지 않는다. 


  
# INNER JOIN 과 OUTER JOIN 의 차이
-- 두 테이블간의 관계 를 설정후 두테이블 동시에  존재하는 데이터 만 조회 하고자 할 경우 INNER JOIN
-- 메인 테이블 에 있는 데이터를 기준으로 관련된 데이터를 조회 하고자 할 경우 OUTER JOIN 
						 
						 

     
      
/******** 실습 ***********
	T_Stockhst 자재 입출 이력 중 REMARK(비고) 내역이 있고 (NULL 이아니고)
	ITEMTYPE(품목구분) 이 ROH 인
	입출 이력만 조회해 보세요.
	
	-- 표현 컬럼. 
	[입출일자], [입출순번], [품목],   [품명],   [입출수량],    [최소발주수량]
	INOUTDATE,  INOUTSEQ,   ITEMCODE, ITEMNAME,	ITEMQTY,       MINORDERQTY 정보를 나타내시오. 
	 */  
   
 






							   
	
							  

	  
	   
    
    
    
    						 
						 
  -- **** 다중 JOIN
  -- 참조 할 데이터가 여러 테이블에 있을때 기준테이블 과 참조 테이블 과의 다중 JOIN 으로 데이터를 표현 할 수 있다. 
  /* 사과를 제외한 판매현황 을 
     판매일자, 고객ID, 고객 이름,고객 연락처, 판매과일, 과일단가, 판매 금액 으로 나타내세요 */
   		 
  SELECT A.DATE				    AS DATE			-- 판매일자
        ,A.CUST_ID			    AS CUST_ID		-- 고객ID
		,B.NAME				    AS NAME			-- 고객명
		,B.PHONE			    AS PHONE		-- 연락처
		,C.FRUITNAME		    AS FRUIT	-- 과일명
		,C.unitprice 	        AS unitprice		-- 과일단가
		,C.unitprice * A.AMOUNT AS SALES_unitprice  -- 판매금액
    FROM T_Saleshst A LEFT JOIN T_Customer B
	                         ON A.CUST_ID    = B.CUST_ID
					  LEFT JOIN t_fruitmaster C
					         ON A.fruit  = C.Fruit 
   WHERE A.DATE > '2023-12-03' -- 조회 조건의 추가로 원하는 결과의 조건을 첨부 할 수 있다. 
     AND A.FRUIT <> 'AP' -- 사과가 아닌 데이터를 검색 한 결과를 JOIN 한다. (최종 결과에서 필터)
     ;
   
     
    
    
    
    
    
   
   
 
 /***** 실습*******
  과일 판매 이력의 고객 별 과일 총 계산 금액 구하기 (고객ID, 고객명, 과일이름, 과일별 총계산금액) 
 
 문제의 의도 : GROUP BY 와 JOIN 을 적절히 사용 할 수 있는가 ? . */ 

 






											  

	/***************** 실습 **************
  고객 별 총 구매 금액이 가장 큰 고객을 표현하세요  1사람. 
  (고객ID, 고객이름, 고객주소, 고객연락처, 총구매금액)
  
  상위 데이터 추출 방법과 변수의사용을 이해하고 있는가 ? 
  */
   







   											
   											
   											


   											
  /* 
  2023-12-01 일 부터 2023-12-31 (월간)
  가장 많이 팔린 과일의 종류와 총 판매 수량을구하세요
  (과일 , 판매 수량 ) 

  변수의 사용과 집계함수의 사용법을 이해 하고 있는가 ? 
  */ 
 

-- 최대 구매 금액인 고객의 LIST 를 표현.
  SELECT  FRUIT
         ,SUM(AMOUNT) AS TOTAL_SALES
    FROM T_Saleshst  
   WHERE DATE BETWEEN '2023-12-01' AND '2023-12-31'
GROUP BY FRUIT 
  HAVING SUM(AMOUNT) =  (SELECT MAX(TOTAL_SALES) 
					       FROM (SELECT FRUIT 
						                ,SUM(AMOUNT) AS TOTAL_SALES
       							   FROM T_Saleshst   
	   							  WHERE DATE BETWEEN '2023-12-01' AND '2023-12-31'
       							  GROUP BY FRUIT) AA);

       							 
       							 
       					
       							 
   

  	/******* 실습 *********** 
	고객 별 총 구매 금액이 120000 원이 넘는 고객의 내역만 검색 하세요. (고객ID,  고객이름,  총 구매금액) 
	
	GROUP BY 조건절을 사용 할 수 있는가 ? 
	*/

 




	     
	     

	     
	     
	     
   /**** 실습 ********
     위의 내역을 SUM 집계함수를 Select 절에 한번만 사용하여 표현해 보세요.
	 
	 하위 쿼리를 응용 하여 리소스 를 관리 할 수 있는가 ? 
	 */
		
	 



		 
						  
	/******* 실습 ***********
	2023-12-01 일 부터 2023-12-03 일 까지의 
	고객 별 총 구매 금액을 구하시오. 고객ID,  고객이름,  총 구매금액
	
	WHERE 절의 연산 처리 순서를 이해 하고 있는가 ? 
	*/ 

	  





  	  
/*****************************************************************************
  
  3. UNION / UNION ALL
  다수의 검색 내역 병합 
  조회한 다수의 SELECT 문을 하나로 합치고싶을때 유니온(UNION) 을 사용.
  UNION     : 중복되는 행은 하나만 표시 
  UNION ALL : 중복제거를 하지 않고 모두 표시.  
   

  
  *** 합병 될 컬럼의 데이터 형식과 컬럼의 수는 일치해야한다.
  */


  -- ** UNION 
  -- 중복 되는 데이터는 합병하여 표현한다.  

 SELECT DATE		 AS DATE
       ,CUST_ID      AS CUSTIMF
	   ,FRUIT	     AS FRUIT
	   ,AMOUNT		 AS AMOUNT
   FROM T_Saleshst -- 45 데이터  
 UNION  
 SELECT DATE	   AS DATE
	   ,CUSTCODE   AS CUSTIMF
	   ,FRUIT      AS FRUITNAME
	   ,AMOUNT     AS AMOUNT
  FROM T_OrderList; -- 28 데이터 
-- 총 73 개  
-- 중복 된 내역을  1건씩만 표시하여 69건의 데이터 만 표현된다.

 
  -- **** 중복 된 행 찾아보기
     SELECT DATE	   AS DATE
		   ,CUSTCODE   AS CUSTIMF
		   ,FRUIT 	   AS FRUIT
		   ,AMOUNT     AS AMOUNT
		   ,COUNT(*)   AS CNT
	   FROM T_OrderList
   GROUP BY DATE,CUSTCODE,FRUIT,AMOUNT  
     HAVING COUNT(*) >= 2;
   -- 주문 리스트 에서 4건의 중복 데이터 를 확인 할 수 있다.
    
   
    
    
    


  -- ** UNION ALL
  -- 중복 되는 데이터를 모두 표현한다.   - 73 건 확인
 SELECT DATE		 AS DATE
       ,CUST_ID      AS CUSTIMF
	   ,FRUIT		 AS FRUIT
	   ,AMOUNT		 AS AMOUNT
   FROM T_Saleshst 
 UNION ALL
 SELECT date   		AS DATE
	   ,CUSTCODE    AS CUSTIMF_ASDASD
	   ,FRUIT 		AS FRUIT
	   ,AMOUNT      AS AMOUNT
  FROM T_OrderList;

 
 
  # 데이터의 가공 

  -- 1) 판매 내역 / 발주 내역인지 확인 하기 위하여 TITLE 설정 
 SELECT '판매'	 AS TITLE
       ,DATE	 AS DATE
       ,CUST_ID  AS CUSTIMF
	   ,FRUIT    AS FRUIT
	   ,AMOUNT	 AS AMOUNT
   FROM T_Saleshst 
 UNION ALL
 SELECT '발주'     AS TITLE
       ,DATE	   AS DATE
	   ,CUSTCODE   AS CUSTIMF_ASDASD -- 컬럼의 이름은 첫번째 AS 로 표현한다.
	   ,FRUIT      AS FRUIT
	   ,AMOUNT     AS AMOUNT
  FROM T_OrderList ;



 
-- 고객 명 , 거래처 명으로 표현 하고 싶은 경우.
--  T_Customer 테이블 에서 정보를 가져올수 있도록 JOIN 한다. 
-- CUSTCODE 관리 테이블이 없으므로 임의로 코드 별 명칭을 부여한다. case
 SELECT '판매'	     AS TITLE
       ,A.DATE		 AS DATE 
	   ,B.NAME		 AS CUSTNAME
	   ,A.FRUIT      AS FRUIT
	   ,A.AMOUNT	 AS AMOUNT
   FROM T_Saleshst A LEFT JOIN T_Customer B
							 ON A.CUST_ID = B.CUST_ID
 UNION 
 SELECT '발주'							     AS TITLE
       ,DATE								 AS DATE 
	   ,CASE CUSTCODE WHEN 10 THEN '대림'
					  WHEN 20 THEN '삼전'
					  WHEN 30 THEN '하나' 
					  WHEN 40 THEN '농협'
					  END AS CUSTNAME  -- 거래처 정보 테이블이 없으므로 CASE 를 써서 대체함.
	   ,FRUIT							     AS FRUIT
	   ,AMOUNT								 AS AMOUNT
  FROM T_OrderList;

 
 
 
 
 
 
 
 
  /******* 실습 ************
  발주 내역과 주문 내역에 각각 과일의 이름과 
  총 발주 금액(ORDER_unitprice * 주문수량) 과 주문 금액 (unitprice * 구매수량) 을 
  추가하여 표현하세요  
  *컬럼이름은 INOUTunitprice 로 표현.
  *발주 금액은 - 로 표현		*/










					        
 
					        
					        
# 데이터 정렬하기 
-- UNION 을 처리한 결과를 하위 쿼리 테이블로 만들어 ORDER BY   (일자 별 판매 현황) 
-- 공통으로 JOIN 할 수 있는 FRUIT 테이블을 하위 쿼리 테이블 과 JOIN 하여 리소스 활용. 					        
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
ORDER BY AA.DATE;






 
 
/******* 실습 ************
  두가지 방법으로 과일 가게의 일자 별 마진 금액을 산출 하세요 

  * 1. UNION 방법을 사용할 경우 불필요한 컬럼을 제거할것.
  * 2. UNION 을 쓰지 않고 산출.

  * 마진 금액 : 판매한금액 - 발주금액
  * 표현 컬럼 : DATE, DATEPER_MARGIN 

  */


