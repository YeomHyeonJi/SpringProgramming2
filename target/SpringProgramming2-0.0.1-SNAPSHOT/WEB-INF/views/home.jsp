<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
html, body {
	height: 100%;
	margin: 0px;
}

#wrapper {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
}

#header {
	border-bottom: 1px solid black;
	margin-bottom: 10px;
}

#content {
	display: flex;
	flex-grow: 1;
	min-height: 0;
}

#sideBar {
	width: 300px;
	background-color: #F8E0E6;
	padding-right: :10px;
	border-right: 1px solid black;
	overflow-y: scroll;
}

#center iframe {
	margin: 0px;
	height: 100%;
	width: 100%;
}

#center {
	flex-grow: 1;
	padding: 10px;
}

#center h4 {
	margin-top: 0px;
}

#footer {
	border-top: 1px solid black;
	margin-top: 10px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div id="wrapper">
		<div id="header">
			<h3>SpringProgramming2</h3>
		</div>
		<div id="content">
			<div id="sideBar">
				<ul>
					<li>
					<p>요청 매핑1</p>
					<a href="info" target="iframe">페이지정보</a>
					</li>

				</ul>
			</div>
			<div id="center">
				<iframe name="iframe" src="http://tomcat.apache.org" frameborder="0"></iframe>
			</div>
		</div>
		<div id="footer">2019. IOT. Y.H.J</div>
	</div>
</body>
</html>