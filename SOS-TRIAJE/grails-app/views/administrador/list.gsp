
<%@ page import="persona.Administrador" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="referenc" />
        <g:set var="entityName" value="${message(code: 'administrador.label', default: 'Administrador')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
      
      <div id="cabecera">
        <div id="cabColI">
          <div id="logo">
             <h1><img src="${resource(dir:'images',file:'SOS.gif')}" width="97" height="53" align="texttop" />Referencias Médicas</h1>        
          </div>
          <div id="breadcrumbs">
              <p>&nbsp;</p>
          </div>
        </div>
        <div id="cabColD">
          <div id="infoSec">14-12-2011 06:59 PM &nbsp; | &nbsp; Cambiar idioma <a href="#"><img src="${resource(dir:'images',file:'ico_ingles.jpg')}" alt="Inglés" width="25" height="34" hspace="2" border="0" align="absmiddle" /></a> <a href="#"><img src="${resource(dir:'images',file:'ico_port.jpg')}" alt="Portugués" width="25" height="34" hspace="2" border="0" align="absmiddle" /></a></div>
          <div id="header"><div id="loginHeader"><g:loginControl/></div></div>
        </div>
      </div>

      <div id="menu1">
        <ul>
         <li><g:link controller="administrador" action="list" class="selected"><g:message code="Modificar Administrador"/></g:link></li>
         <li><g:link controller="administrador" action="create"><g:message code="Crear Administrador"/></g:link></li>
     </div>
      
<div id="nivel1">
  <div id="nivel2">
    <div id="contenido">
    <h1>Datos del administrador</h1>

        <div class="form1">
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
         
                <table class="tabla2">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'administrador.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="nombre" title="${message(code: 'administrador.nombre.label', default: 'Nombre')}" />
                        
                            <g:sortableColumn property="apellido" title="${message(code: 'administrador.apellido.label', default: 'Apellido')}" />
                        
                            <g:sortableColumn property="cedula" title="${message(code: 'administrador.cedula.label', default: 'Cedula')}" />
                        
                            <g:sortableColumn property="sexo" title="${message(code: 'administrador.sexo.label', default: 'Sexo')}" />
                        
                            <g:sortableColumn property="nacionalidad" title="${message(code: 'administrador.nacionalidad.label', default: 'Nacionalidad')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${administradorInstanceList}" status="i" var="administradorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${administradorInstance.id}">${fieldValue(bean: administradorInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: administradorInstance, field: "nombre")}</td>
                        
                            <td>${fieldValue(bean: administradorInstance, field: "apellido")}</td>
                        
                            <td>${fieldValue(bean: administradorInstance, field: "cedula")}</td>
                        
                            <td>${fieldValue(bean: administradorInstance, field: "sexo")}</td>
                        
                            <td>${fieldValue(bean: administradorInstance, field: "nacionalidad")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            
            <div class="paginateButtons">
                <g:paginate total="${administradorInstanceTotal}" />
            </div>
          </div>
      <p>&nbsp;</p>
      <g:link class="boton1" controller="actorSistema" action="menuAdministrador"><g:message code="Volver"/></g:link>
    </div>      
  </div>
  <p style="clear:both">&nbsp;</p>
</div>
    </body>
</html>
