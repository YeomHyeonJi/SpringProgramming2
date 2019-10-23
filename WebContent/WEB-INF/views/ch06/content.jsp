<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<%=application.getContextPath()%>/resources/js/jquery-3.4.1.min.js/"></script>
<link rel="stylesheet" type="text/css"
	href="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="<%=application.getContextPath()%>/resources/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function btnLogin() {
		if ($("#mid").value() == "")
			return false;
		if ($("#mpassword").value() == "")
			return false;
		return true;
	}
	function btnLogout() {
		location.href = "logout";
	}
	function jsonDownload1() {
		$.ajax({
			url : "jsonDownload1",
			success : function(data) {
				var html="";
					html +="<tr>";
					html +="	<td>"+ data.bno	+"</td>";
					html +="	<td>"+ data.btitle +"</td>";
					html +="	<td>"+ data.writer +"</td>";
					html +="	<td>"+ data.date +"</td>";
					html +="	<td>"+ data.hitcount +"</td>";
					html +="</tr>";
					$("tbody").append(html);
			}
		});
	}
	function jsonDownload2() {
		$.ajax({
			url : "jsonDownload2",
			success : function(data) {
				var html="";
					html +="<tr>";
					html +="	<td>"+ data.bno	+"</td>";
					html +="	<td>"+ data.btitle +"</td>";
					html +="	<td>"+ data.writer +"</td>";
					html +="	<td>"+ data.date +"</td>";
					html +="	<td>"+ data.hitcount +"</td>";
					html +="</tr>";
					$("tbody").append(html);
			}
		});
	}
</script>
</head>
<body>
	<h5>[content.jsp]</h5>
	<div>
		<c:if test="${loginResult != 'success'}">
			<form id="loginForm" method="post" action="login">
				<div class="form-group">
					<label for="mid">아이디</label> <input type="text"
						class="form-control" id="mid" name="mid">
					<c:if test="${loginResult == 'wrongMid' }">
						<span style="color: red;">로그인 아이디가 없습니다.</span>
					</c:if>
				</div>
				<div class="form-group">
					<label for="mpassword">패스워드</label> <input type="password"
						class="form-control" id="mpassword" name="mpassword"> <input
						onclick="return btnLogin()" type="submit" class="btn btn-primary"
						value="로그인">
					<c:if test="${loginResult == 'wrongMpassword' }">
						<span style="color: red;">비밀번호가 틀립니다.</span>
					</c:if>
			</form>
		</c:if>
	</div>

	<c:if test="${loginResult == 'success'}">
		<div id="logoutDiv">
			<button onclick="btnLogout()" class="btn btn-danger">로그아웃</button>
		</div>
	</c:if>
	</div>
	
	<h5>[OutputStream을 이용해서 파일 다운로드 구현]</h5>
	<div>
		<img src="<%=application.getContextPath()%>/resources/image/Penguins.jpg"width="100"/>
		<br/>
		<img src="fileDownload?fname=Penguins.jpg" width="100"/>
		<br/>
		<a href="fileDownload?fname=Penguins.jpg">파일 다운로드</a>
	</div>
	
	<br/>

	<h5>[writer를 이용해서 JSON 데이터 다운로드]</h5>
	<a href="javascript:jsonDownload1()">JSP에서 생성</a><br/>
	<a href="javascript:jsonDownload2()">Controller에서 생성</a>
	<br />


	<div>
		<table class="table table-borderless">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">날짜</th>
					<th scope="col">조회수</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

</body>
</html>