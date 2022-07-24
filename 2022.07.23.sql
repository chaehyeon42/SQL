  -- 트레젝션 설명 (게시판으로 예시)
  SELECT * FROM BOARD;
  
  -- 제목을 클릭 했을때(트래젝션 발동)
  start transaction;
  -- 제목과 내용이 조회됨과 동시에 증가
  SELECT TITLE, CONTENT FROM board;
  -- 조회수가 1씩 증가(원래있던 숫자에 1만큼 수정을 해야하기 때문에 UPDATE를 이용)
  UPDATE BOARD 
  SET CNT = CNT + 1
  where ID = 'C123';
  
  rollback;
  
  