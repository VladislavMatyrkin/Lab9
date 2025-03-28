<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="entity.Ad" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ad" uri="http://tag/ad" %>

<fmt:requestEncoding value="UTF-8" />
<c:remove var="adData" />

<%-- Получаем объект из сессии --%>
<%
	Ad adData = (Ad) session.getAttribute("adData");
	if (adData == null) {
		adData = new Ad(); // Создаем новый объект, если adData равен null
		session.setAttribute("adData", adData); // Сохраняем новый объект в сессии
		System.out.println("Объект объявления не инициализирован! Создаем новый объект.");
	} else {
		System.out.println("Объект объявления загружен из сессии: " + adData.getSubject());
	}
%>

<jsp:setProperty name="adData" property="subject" />
<jsp:setProperty name="adData" property="body" />

<%-- Обработка дат --%>
<%
	String fromDateStr = request.getParameter("fromDate");
	String toDateStr = request.getParameter("toDate");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
	boolean dateError = false;

	if (fromDateStr != null && !fromDateStr.isEmpty()) {
		try {
			Date fromDate = sdf.parse(fromDateStr);
			adData.setFromDate(fromDate.getTime());
			System.out.println("Дата начала установлена: " + fromDate);
		} catch (ParseException e) {
			dateError = true;
			System.out.println("Ошибка парсинга даты начала: " + e.getMessage());
		}
	}
	if (toDateStr != null && !toDateStr.isEmpty()) {
		try {
			Date toDate = sdf.parse(toDateStr);
			adData.setToDate(toDate.getTime());
			System.out.println("Дата окончания установлена: " + toDate);
		} catch (ParseException e) {
			dateError = true;
			System.out.println("Ошибка парсинга даты окончания: " + e.getMessage());
		}
	}

	if (!adData.validateDates()) {
		dateError = true;
		session.setAttribute("errorMessage", "Дата окончания должна быть позже даты начала.");
	}
%>

<%-- Вызов тега обновления --%>
<c:if test="${!dateError}">
	<ad:updateAd ad="${adData}" />
</c:if>

<c:choose>
	<c:when test="${sessionScope.errorMessage == null}">
		<c:remove var="adData" scope="session" />
		<c:redirect url="/cabinet.jsp" />
	</c:when>
	<c:otherwise>
		<c:redirect url="/updateAd.jsp">
			<c:param name="id" value="${adData.getId()}" />
		</c:redirect>
	</c:otherwise>
</c:choose>
