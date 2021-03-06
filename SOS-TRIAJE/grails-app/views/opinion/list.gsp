
<%@ page import="opinion.Opinion" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'opinion.label', default: 'Opinion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'opinion.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="fechaOpinion" title="${message(code: 'opinion.fechaOpinion.label', default: 'Fecha Opinion')}" />
                        
                            <g:sortableColumn property="cuerpoOpinion" title="${message(code: 'opinion.cuerpoOpinion.label', default: 'Cuerpo Opinion')}" />
                        
                            <g:sortableColumn property="estadoOpinion" title="${message(code: 'opinion.estadoOpinion.label', default: 'Estado Opinion')}" />
                        
                            <th><g:message code="opinion.medico.label" default="Medico" /></th>
                        
                            <th><g:message code="opinion.caso.label" default="Caso" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${opinionInstanceList}" status="i" var="opinionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${opinionInstance.id}">${fieldValue(bean: opinionInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${opinionInstance.fechaOpinion}" /></td>
                        
                            <td>${fieldValue(bean: opinionInstance, field: "cuerpoOpinion")}</td>
                        
                            <td>${fieldValue(bean: opinionInstance, field: "estadoOpinion")}</td>
                        
                            <td>${fieldValue(bean: opinionInstance, field: "medico")}</td>
                        
                            <td>${fieldValue(bean: opinionInstance, field: "caso")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${opinionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
