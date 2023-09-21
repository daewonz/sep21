<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<style type="text/css">
body{
margin: 100px;
}
</style>
</head>
<body style="text-align: center;">
<div class="checkPW">
현재 비밀번호를 입력해주세요<br>
<input class="pw" type="password">
<button class="checkPWbtn">비밀번호 확인</button>
</div>

<div class="changePW">
바꿀 비밀번호를 입력해주세요
<br>
<input id="changePW" type="password">
<br>
비밀번호를 다시 한 번 입력해주세요
<br>
<input id="changePW2" type="password">
<br>
<button class="changePWbtn">변경하기</button>
</div>
<script type="text/javascript">
$(function(){
	
	$(".changePW").hide();
	
	$(".checkPWbtn").click(function(){
		let eno = ${sessionScope.eno};
		let pw = $(".pw").val();
		//alert(eno);
		//alert("zz");
		if($(".pw").val().length < 5){
			alert("비밀번호는 5자리 이상입니다.");
			return false;
		}
		$.ajax({
			url : "./checkPW",
			type : "post",
			data : {pw : pw, eno : eno},
			dataType : "json",
			success : function(data){
				if(data.result == 'ok'){
					$(".checkPW").hide();
					$(".changePW").show();
				//비밀번호 바꾸기 폼 만들기
				
				}else{
					alert("사번과 비밀번호가 일치하지 않습니다.");
					return false;
				}
			},
			error : function(error){
				alert("ㅠㅠ");
			}
		});
	});//비밀번호 체크하기 끝
	
	$(".changePWbtn").click(function(){
		let eno = ${sessionScope.eno};
		let pw1 = $("#changePW").val();
		let pw2 = $("#changePW2").val();
		if(pw1.length < 5 ){
			alert("비밀번호는 5자리 이상입니다.")
			return false;
		}
		else if(pw1 != pw2){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		$.ajax({
			url : "./changePW",
			type : "post",
			data : {eno : eno, pw :pw1},
			dataType : "json",
			success : function(data){
				if(data.eno == 'exist'){
					alert("현재 사용하는 비밀번호입니다. 새로운 비밀번호를 입력해주세요.");
					$("#changePW").val("");
					$("#changePW2").val("");
					return false;
				}
				
				alert("비밀번호가 성공적으로 변경되었습니다.");
				window.close();
				
			},
			error : function(error){
				alert("ㅠㅠ");
			}
		});//ajax 끝
		
	
	});
});

</script>
</body>
</html>