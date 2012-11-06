
<%@ page import="status.Status" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'status.label', default: 'Status')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'status.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'status.nombre.label', default: 'Nombre')}" />
                        
                            <g:sortableColumn property="fechaStatus" title="${message(code: 'status.fechaStatus.label', default: 'Fecha Status')}" />
                        
                            <g:sortableColumn property="decripcion" title="${message(code: 'status.decripcion.label', default: 'Decripcion')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${statusInstanceList}" status="i" var="statusInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${statusInstance.id}">${fieldValue(bean: statusInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: statusInstance, field: "nombre")}</td>
                        
                            <td><g:formatDate date="${statusInstance.fechaStatus}" /></td>
                        
                            <td>${fieldValue(bean: statusInstance, field: "decripcion")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${statusInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
