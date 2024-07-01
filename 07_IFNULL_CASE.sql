

  --*********************************************************************************************************************					
  -- NULL 인 값을 원하는 데이터로 변환하기 IFNULL(?,?)*/

 
 /* t_Stockhst 테이블에서 PLANTCODE ,INOUTDATE ,INOUTSEQ ,ITEMCODE 컬럼의 데이터를 검색하고
    REMARK 가 NULL 일 경우 '-' 으로 표현하세요.*/

  SELECT INOUTDATE
		,INOUTSEQ
		,IFNULL(REMARK ,'-') AS ITEMCODE
    FROM t_Stockhst;



 -- NULL 값이 있는 컬럼 데이터 조회 하기.
 SELECT ITEMCODE,ITEMNAME,SPEC  
   FROM t_ItemMaster
  WHERE SPEC  LIKE '%%'
 -- 모든 데이터 를 검색하는 조건이지만
 -- like '%%' 는 특정 문자를 포함해야 하므로 
 -- 데이터 가 NULL 인 행은 조회 를 할 수 없다. 
  
  
  


 -- NULL 일 경우 값을 빈 공백으로 바꾸어 주어 조회 
 SELECT ITEMCODE,ITEMNAME,SPEC 
   FROM t_ItemMaster
  WHERE IFNULL(SPEC,'') LIKE '%%';
  -- 또는 
  -- WHERE IFNULL(SPEC,'') = '' 
  -- 조건절 데이터 컬럼 에 IFNULL() 함수 를 사용 시 모든 조회 내용을 '' 로 비교 및 변경 로직을 수행하여 
  -- 리소스 를 많이 차지 할 수 있다. 신중히 사용하여야 한다.
   
  
  
  
  
  

/*********************************************************************************
- 분기문 (CASE WHEN THEN END)
     대상의 상태에 따라서 값이나 조건을 다르게 적용하는 분기문. 
    중요 ** 반드시 END 로 끝맺을을 해 주어야 한다. 

   1. CASE [비교대상] WHEN [조건] THEN [결과로직]
     . 고정 된 비교 대상과 다수의 조건에 따른 결과를 표현 할 경우.   (1 : N)

   2. CASE WHEN [비교대상,비교연산자,조건] THEN [결과]
     . 다수의 비교 대상 과 다수의 조건에 따른 결과 를 표현 할 경우 . (N : N)
*/


--  조회 부(SELECT절)에서 사용되는 CASE WHEN 문 
-- 1-1. CASE [비교대상] WHEN [조건] THEN [결과로직]
  SELECT  ITEMCODE
  		 ,ITEMNAME
  		 ,CASE WHCODE  WHEN 'WH003'    THEN '자재'
                       WHEN 'WH004'    THEN '제품'
                       WHEN 'WH005'    THEN 'AS'
                      ELSE '기타' END AS INOUTFLAG
    FROM t_itemmaster ti ; -- 자재 입고 이력 테이블.

    
    
    
-- 1-2. CASE WHEN [비교대상,비교연산자,조건] THEN [결과]
  SELECT ITEMCODE
        ,CASE WHEN STOCKQTY <= 300  THEN '재고미달'
              WHEN STOCKQTY >= 0 
               AND STOCKQTY <= 1000 THEN '-'
           ELSE '재고초과' END AS STOCK_STATE
   FROM t_Stock; -- 자재 재고 테이블

   
  

   -- CASE 의 용법 조건부 2-1 
   -- 입고 등록 일 '2023-01-01' 부터 '2023-12-31' 인 재고 의 수량이 60 이상일 경우 
   -- 12 로 시작하는 모든 품목의 정보를 조회 하고 
   -- 그렇지 않을경우 63 으로 시작하는 모든 품목의 정보를 조회하라. 
  SELECT *
    FROM t_itemmaster ti 
   WHERE ITEMCODE LIKE CONCAT(CASE WHEN (SELECT COUNT(*) 
										   FROM t_stock ts
										  WHERE MAKEDATE BETWEEN '2023-01-01' AND '2023-12-31') >= 60 THEN '12'
			  				  ELSE '63' END, '%');
  
 
					 
  
  
  
  
  -- CASE 용법 조건부 2-2 *** 
  -- 비교 대상을 1 또는 특정 문자열 로 두어 
  -- 조건 문 내에서 분기문을 수행하도록 하여 
  -- 기준 1 과 매칭 or 리턴 하여 쿼리를 실행 하도록 제어가능.  
  SELECT *
    FROM t_Stock
   WHERE 1 = CASE (SELECT COUNT(*) 
				     FROM t_stock ts
				    WHERE MAKEDATE BETWEEN '2023-01-01' AND '2023-12-31') WHEN 105 THEN 1
							    ELSE 0 END;



							   
							   

							   
 
						
