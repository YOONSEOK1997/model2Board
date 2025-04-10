<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 월의 기본값은 오늘의 월(1일)
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1);
	
	if(request.getParameter("targetMonth") != null) {
		firstDate.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	
	// 시작날짜 1일
	// 마지막 날짜
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	
	// 1일의 요일 -> 시작 공백
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	int startBlank = dayOfWeek - 1;
	// 뒤 공백
	int endBlank = 0;
	// totalCell은 7의 배수
	int totalCell = startBlank + lastDate + endBlank;
	if(totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		totalCell = totalCell + endBlank;
	}
	int month = firstDate.get(Calendar.MONTH);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>

		
	<table class="calendar">
			<h1> <%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH) + 1%>월</h1>
		<tr>
			<th class="sunday">일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th class="saturday">토</th>
		</tr>
		<tr>
			<%
				for(int i=1; i<=totalCell; i=i+1) {
			%>
					<td>
						<%	
							int d = i-startBlank;
							if(d > 0 && d <= lastDate) {
						%>
								
									<a href="/web0318/dateList.jsp?y=<%=firstDate.get(Calendar.YEAR)%>&m=<%=firstDate.get(Calendar.MONTH)+1%>&d=<%=d%>">
										<%=d%>
									</a>
							
						<%
								while(rs.next()) {
									String diaryDate = rs.getString("diaryDate");
									if(Integer.parseInt(diaryDate.substring(8)) == d) {
						%>
										<div style='color:<%=rs.getString("diaryColor")%>'>
											<%=rs.getString("diaryTitle")%>
										</div>
						<%				
									}
								}
								// 커스를 처음 위치로
								rs.beforeFirst();
							}
						%>
					</td>
			<%	
					if(i%7==0) {
			%>
						</tr><tr>			
			<%				
					}
				}
			%>
		</tr>
	</table>
	<div class="page">
		<a href="/web0318/diary.jsp?targetMonth=<%= month-1 %>">이전 달</a>
		<a href="/web0318/diary.jsp?targetMonth=<%= month+1 %>">다음 달</a>
	</div>
</body>
</html>