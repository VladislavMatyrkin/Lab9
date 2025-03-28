<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="ad" uri="http://tag/ad"%>
<fmt:requestEncoding value="UTF-8" />

<c:choose>
	<c:when test="${param.id == null || param.id == 0}">
		<c:set var="title" scope="page" value="Создание" />
	</c:when>
	<c:otherwise>
		<c:set var="title" scope="page" value="Редактирование" />
		<c:if test="${sessionScope.errorMessage == null}">
			<ad:getAds id="${param.id}" var="ad" />
			<c:set var="adData" scope="session" value="${ad}" />
		</c:if>
	</c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
	<title><c:out value="${title}" /> объявления</title>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
</head>
<body>
<jsp:include page="/static/header.jsp"></jsp:include>
<my:layout1Column>
	<h1>
		<c:out value="${title}" />
		объявления
	</h1>
	<c:if test="${not empty sessionScope.errorMessage}">
		<div style="color: red;">
			<c:out value="${sessionScope.errorMessage}" />
		</div>
	</c:if>
	<form action="doUpdateAd.jsp" method="post">
		<c:if test="${param.id > 0}">
			<input type="hidden" name="id" value="${param.id}">
		</c:if>
		<table>
			<tr>
				<td>Заголовок:</td>
				<td><input type="text" name="subject" value="${sessionScope.adData.subject}" style="width: 90%"></td>
			</tr>
			<tr>
				<td>Текст:</td>
				<td><textarea name="body" rows="10" cols="80" style="width: 90%">${sessionScope.adData.body}</textarea></td>
			</tr>
			<tr>
				<td>Дата начала публикации (FROM):</td>
				<td>
					<c:if test="${sessionScope.adData.fromDate != null}">
						<fmt:formatDate value="${sessionScope.adData.fromDate}" pattern="yyyy-MM-dd'T'HH:mm" var="formattedFromDate" />
					</c:if>
					<input type="datetime-local" name="fromDate" value="${formattedFromDate != null ? formattedFromDate : ''}" style="width: 90%;" />
				</td>
			</tr>
			<tr>
				<td>Дата окончания публикации (TO):</td>
				<td>
					<c:if test="${sessionScope.adData.toDate != null}">
						<fmt:formatDate value="${sessionScope.adData.toDate}" pattern="yyyy-MM-dd'T'HH:mm" var="formattedToDate" />
					</c:if>
					<input type="datetime-local" name="toDate" value="${formattedToDate != null ? formattedToDate : ''}" style="width: 90%;" />
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="submit" value="Сохранить">
					<input type="button" value="Отменить" onclick="window.location='<c:url value="/cabinet.jsp" />'">
				</td>
			</tr>
		</table>
	</form>
</my:layout1Column>
<%@ include file="/static/footer.jsp"%>
</body>
</html>