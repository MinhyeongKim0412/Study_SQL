/***********************************************************************************[like]**********************************************************************************
: 검색하고자하는 WHERE 조건의 데이터 일부만 입력하여 해당 내용이 포함된 모든 데이터를 검색합니다.
: 이때, 검색할 범위 지정의 기호는 '%'입니다.(중요)

: 사용자는 주어진 인터페이스에서 값을 입력함. 공백(입력하지않고 비워둠)과 데이터 값 입력 모두가 가능함. 경우의 수가 아주 많이 늘어나는 것.
: 여기서 like %를 이용하면 짧은 쿼리문으로 기능의 다양한 경우를 모두 구현할 수 있다는 효율성 증대가 가능해짐
: 즉, UI를 구현, 구성할 때 효율적이고 중요한 기능임.
*/
select *
from  t_itemmaster ti 
where ITEMCODE like '%-2S%'
ITEMNAME like '%%';

select *
from  t_itemmaster ti 
where ITEMCODE like '%-2S%'; -- 포함될 글자의 앞뒤에 % 기호가 있는 경우는, 해당 글자가 있는 모든 데이터를 검색한다는 뜻

-- % + Word + %  : Word라는 글자가 들어가있는 모든 데이터 검색

-- Word + %      : Word로 시작하는 - 
-- % + Word      : - 로 끝나는 - 

-- Word1 + % + Word2 : 글자1로 시작해서 2로 끝나는 데이터 검색
-- Word1 + % + Word2 + % : 글자1로 시작해서 글자2가 들어가있는 데이터를 검색
-- Word1 + % + Word2 + % + Word3 : 

-- %% (%+공백+%) : 입력값 없이 비워둠 (전체 검색)

-- % + Value + % : Value(특정 변수)가 들어가있는 모든 데이터 검색 
                   -- ?) 왜 변수를 넣나요? !)사용자가 어떤 값을 입력할 지 모르기 때문에 고정되지않은 변수로 가정합니다.

/***********************************************************************************[CONCAT]**********************************************************************************
 * 
 */
select concat('안녕하세요', '반갑습니다') as HELLO;

-- LIKE 응용
select *
from  t_itemmaster ti 
where ITEMCODE like concat('%','64','%','14','%','900','%');

-- ?) 그렇다면 실제로 문자에 %가 자체적으로 포함된 건 어떻게 검색하나요?
-- !)                                                                        
-- (c.f. Java에서도 역슬러시를 이용해서 컴파일러에게 지시했습니다.)
/*ex. 
select *
from t_itemmaster ti 
where ITEMCODE like '%\%%';   -- escape '\'
*/

/**********************************************************************************[NULL]**********************************************************************************
 * : 데이터가 없음, 비어있는 상태, 공허한 상태, 메모리가 할당되어있지 않은 상태
 * : =가 아닌 IS로 표현 (Why? 참/거짓이 아닌 상태값이므로)(=는 비교 연산자임. 연산자는 특정 데이터값에 대한 부분만 다룰 수 있기에 연산자는 상태를 표현할 수 없음)
 */

select *
from  t_itemmaster ti 
where MAXSTOCK is null;        -- (O)
-- where MAXSTOCK = null;      -- (X)
-- where MAXSTOCK is not null; --(부정의 경우)

/*실습
 * : 품목 마스터 테이블에서 규격(SPEC)이 '01'로 끝나면서 null이 아닌 품목코드(ITEMCODE), 품목명(ITEMNAME), 규격 컬럼(SPEC)의 데이터를 검색하세요.
 */
select ITEMCODE, ITEMNAME, SPEC 
from   t_itemmaster ti
where  SPEC like '%01'and SPEC is not null;

/*********************************************************************[order by ASC, DESC)**********************************************************************************
 * : 테이블에서 검색한 결과를 조건에 따라 정렬
 * : NULL데이터(빈 칸)는 항상 최상위로 SORTING됨
 * : 오름차순(ASC)이 기본값이고, 내림차순(DESC)은 별도로 설정해야함
 * c.f. 왼쪽에서 오른쪽 방향으로 순차적으로 비교하여 정렬기준을 가짐     -- ex. 품목코드 숫자 데이터에서 첫자리 -> 두번째 자리 ... 이렇게 순서대로 정렬되는 규칙
 */

-- -------------------- <오름차순>
-- 품목 마스터에 품목 코드 순으로 오름차순 정렬하여 검색
-- 품목코드, 품목명, 날짜
select    ITEMCODE , ITEMNAME , `MAKEDATE`
from      t_itemmaster ti 
order by `MAKEDATE` asc;

-- 컴마를 이용해서 순서대로 정렬기준을 설정 가능
-- 품목 마스터 테이블에서 품목 구분이 HALB인 품목코드, 품목구분, 창고, 규격 컬럼을 검색
-- 품목 구분이 같다면 창고 코드 오름차순, 창고 코드 값이 값다면 규격 오름차순으로 검색
select   ITEMCODE , ITEMTYPE , WHCODE , SPEC 
from     t_itemmaster ti 
order by ITEMTYPE, WHCODE, SPEC asc;

-- 조회 컬럼이 아니어도 정렬기준으로는 삼을 수 있음
select ITEMCODE , ITEMTYPE
from     t_itemmaster ti 
order by WHCODE, SPEC asc;

-- -------------------- <내림차순>
select *
from     t_itemmaster ti 
where    INSPFLAG is not null
order by ITEMTYPE, WHCODE desc, INSPFLAG;

/*실습
 * : 품목 마스터에서 규격이 NULL값이고, 품목코드값이 001을 포함하고,
 * 단가 값이 10000~20000 사이인 품목의 모든 정보를 품명은 내림차순, 창고코드는 오름차순으로 조회하세요.
 */
select *
from     t_itemmaster ti
where    SPEC     is null 
  and    ITEMCODE like '%001%' 
  and    UNITCOST between 10000 and 20000
order by ITEMNAME desc, WHCODE;

/**********************************************************************[LIMIT]******************************************************************************
 * : 검색된 데이터 중 특정 행의 개수를 표현하는 기능
 * : 추이, 과거 현황, 판매 데이터 보고서 등에서 효율적
 *   int1, int2; 형태: int1 위치(행)부터 int2개의 데이터
 * : EX.판매량 상위 TOP 10
 */
select *
from   t_itemmaster ti 
limit  0,10;

-- 품목 마스터 테이블에서, 창고 코드가 WH005에 저장되어야하는 품목 중
-- 단가가 높은 품목 기준으로 상위 10개의 데이터를 표현하세요.
select   *
from     t_itemmaster ti 
where    WHCODE = 'WH005'
order by UNITCOST DESC
limit    0,10;

/*실습
 * : 제품 입출고 이력 테이블에서 입출일자가 가장 최근인 데이터 상위 10건의
 *   모든 컬럼 데이터를 입출수량 오름차순 정렬하여 나타내세요.
 */
select   *
from     t_stockhst ts 
order by INOUTDATE DESC, INOUTQTY
limit    0,10;



