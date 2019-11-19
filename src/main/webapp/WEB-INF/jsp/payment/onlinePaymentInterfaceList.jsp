<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD>
<base href="${config:url(pageContext.request)}">
<TITLE>在线支付接口管理</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf_token" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link href="backstage/css/list.css" type="text/css" rel="stylesheet"/>
<link href="backstage/css/table.css" type="text/css" rel="stylesheet"/>
<script language="javascript" src="backstage/js/Tool.js" type="text/javascript"></script>
<script language="javascript" src="backstage/js/ajax.js" type="text/javascript"></script>

<script type="text/javascript">
//删除支付接口
function deletePaymentInterface(id){
	var parameter = "";

	parameter += "&onlinePaymentInterfaceId="+id;
	
	var csrf =  getCsrf();
	parameter += "&_csrf_token="+csrf.token;
	parameter += "&_csrf_header="+csrf.header;

   	//删除第一个&号,防止因为多了&号而出现警告: Parameters: Invalid chunk ignored.信息
	if(parameter.indexOf("&") == 0){
		parameter = parameter.substring(1,parameter.length);
	}
   	post_request(function(value){
		if(value == "1"){
			window.location.reload();
		}else{
			alert("删除失败");
		}
	},
		"${config:url(pageContext.request)}control/onlinePaymentInterface/manage${config:suffix()}?method=delete&timestamp=" + new Date().getTime(), true,parameter);
}

</script>
</HEAD>

<BODY>
<!-- IE6 会弹出'已终止操作'错误，本JS要放在Body标签下面 -->
<script type="text/javascript" src="backstage/spin/spin.min.js" ></script>
<DIV class="d-box">
<div class="d-button">
	<input class="functionButton" type="button" onClick="javascript:window.location.href='${config:url(pageContext.request)}control/onlinePaymentInterface/manage${config:suffix()}?method=add'" value="添加支付接口">
</div>
<form:form>
<TABLE class="t-list-table" cellSpacing="1" cellPadding="0" width="100%" border="0">
  <THEAD class="t-list-thead">
  <TR>
    <TH>支付接口名称</TH>
    <TH>接口产品</TH>
    <TH>是否启用</TH>
    <TH>排序</TH>
    <TH>操作</TH>
    </TR></THEAD>
  <TBODY class="t-list-tbody" align="center">
   <c:forEach items="${pageView.records}" var="entry">
	  <TR >
	    <TD width="30%">${entry.name }</TD>
	    <TD width="35%">
	    	<c:if test="${entry.interfaceProduct == 1}">支付宝即时到账</c:if>
	    	<c:if test="${entry.interfaceProduct == 3}">支付宝手机网站(alipay.wap.create.direct.pay.by.user)</c:if>
	    	<c:if test="${entry.interfaceProduct == 4}">支付宝手机网站(alipay.trade.wap.pay)</c:if>
	    	
	    </TD>
	    <TD width="10%"><c:if test="${entry.enable}">启用</c:if><c:if test="${!entry.enable}">禁止</c:if></TD>
	    <TD width="10%" >${entry.sort }</TD>
	    <TD width="15%">
	    	<a href="control/onlinePaymentInterface/manage${config:suffix()}?method=edit&onlinePaymentInterfaceId=${entry.id }&page=${param.page}">修改</a>
	    	<a href="#" onclick="javascript:if(window.confirm('确定删除吗? ')){deletePaymentInterface('${entry.id }');return false;}else{return false};" hidefocus="true" ondragstart= "return false">删除</a>
	    </TD>
	  </TR>
	 </c:forEach>
  </TBODY>
</TABLE>
<!-- 分页栏开始 -->
  	<%@ include file="/WEB-INF/jsp/common/page.jsp" %>
<!-- 分页栏结束 -->
</form:form>
</DIV></BODY></HTML>