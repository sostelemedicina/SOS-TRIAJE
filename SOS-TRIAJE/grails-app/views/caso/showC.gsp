
<%@ page import="caso.Caso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="referenc" />
        <g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
    <d>Detalle de operación</d>        
  </ul>
  </div>
      
      <div id="nivel1">
  <div id="nivel2">
    <div id="contenido">
      
        <div class="form1">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
     
                <table class="tabla2">
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.descripcion.label" default="Descripcion" /></td>
                            <td valign="top" class="value">${fieldValue(bean: casoInstance, field: "descripcion")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.fechaInicio.label" default="Fecha Inicio" /></td>
                            <td valign="top" class="value"><g:formatDate date="${casoInstance?.fechaInicio}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.paciente.label" default="Paciente" /></td>
                            <td>${casoInstance.paciente.nombre} ${casoInstance.paciente.apellido}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.fechaSolucion.label" default="Fecha Solucion" /></td>
                            <td valign="top" class="value"><g:formatDate date="${casoInstance?.fechaSolucion}" /></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.status.label" default="Status" /></td>
                            <td>${casoInstance.status.nombre}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.archivos.label" default="Archivos" /></td>
                             <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${casoInstance.archivos}" var="a">
                                    <li><g:link controller="archivo" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        </tr>
                   
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="caso.opiniones.label" default="Opiniones" /></td>
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${casoInstance.opiniones}" var="o">
                                    <li><g:link controller="opinion" action="show" id="${o.id}">${o?.nombreOpinion}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                        </tr>
                    
                    </tbody>
                </table>
<p>&nbsp;</p>
<g:link class="boton1" controller="caso" action="listaDeCasosT"><g:message code="Ok"/></g:link>  
        </div>
<p>&nbsp;</p>
    </div>      
  </div>
  <p style="clear:both">&nbsp;</p>
</div>      
    </body>
</html>
