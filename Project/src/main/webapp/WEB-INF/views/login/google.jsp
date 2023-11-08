<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HELLO OAuth</title>
<script>
	function onClickGoogleLogin(e){
    	//구글 인증 서버로 인증코드 발급 요청
 		$.ajax({
	 			url:'/study/tmp/test.php', 
	 			type:'post',    
	 			data:{'id':'admin'}, /   
	 			success: function(data) {    
	 				},    
	 			error: function(err) {  
	 			}
 			});

 	}
</script>
</head>

<body>
	<fieldset>
		<label>로그인</label> <br>
		<div id="googleLoginBtn" style="cursor: pointer">
			<img id="googleLoginImg" onclick="onClickGoogleLogin();">
		</div>
	</fieldset>
</body>


</html>