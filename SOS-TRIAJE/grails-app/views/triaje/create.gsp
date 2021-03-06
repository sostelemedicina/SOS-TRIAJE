

<%@ page import="medico.Triaje" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="referenc" />
        <g:set var="entityName" value="${message(code: 'triaje.label', default: 'Triaje')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        
        
        <g:javascript library="jquery" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery.Jcrop.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'estilo.css')}" />
    
        <script type="text/javascript" src="../js/jquery.js"></script>
        <script type="text/javascript" src="../js/jquery.validate.js"> </script>
    
        
        <script id="demo" type="text/javascript">
        $(document).ready(function() {
                // propose username by combining first- and lastname
                $("#login").focus(function() {
                        var firstname = $("#nombre").val();
                        var lastname = $("#apellido").val();
                        if(firstname && lastname && !this.value) {
                                this.value = firstname + "." + lastname;
                        }
                });
        });
      </script>
      
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
         <li><g:link controller="triaje" action="list"><g:message code="Modificar Encargado de Triaje"/></g:link></li>
         <li><g:link controller="triaje" action="create" class="selected"><g:message code="Cargar Encargado de Triaje"/></g:link></li>
        </ul>
      </div>     
      
<div id="nivel1">
        <div id="nivel2">
          <div id="contenido">
          <h1>Datos del encargado de triaje</h1>
          <g:link class="boton1" controller="actorSistema" action="menuAdministrador"><g:message code="Volver"/></g:link>
            <p>&nbsp;</p>
            
        <div class="form1">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${triajeInstance}">
            <div class="errors">
                <g:renderErrors bean="${triajeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >              
                    <table class="tabla2">
                        <tbody>
                        <span class="obligatorio">&nbsp;*</span> Campos Obligatorios 
                        <h1></h1>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="nombre"><g:message code="triaje.nombre.label" default="Nombre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'nombre', 'errors')}">
                                    <g:textField style="width:250px" name="nombre" value="${triajeInstance?.nombre}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="apellido"><g:message code="triaje.apellido.label" default="Apellido" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'apellido', 'errors')}">
                                    <g:textField style="width:250px" name="apellido" value="${triajeInstance?.apellido}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="cedula"><g:message code="triaje.cedula.label" default="Cedula" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'cedula', 'errors')}">
                                    <g:textField style="width:250px" name="cedula" value="${fieldValue(bean: triajeInstance, field: 'cedula')}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="sexo"><g:message code="triaje.sexo.label" default="Sexo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'sexo', 'errors')}">
                                    <g:select style="width:250px" name="sexo" noSelection="['':'Seleccione']" from="['Masculino', 'Femenino']" value="${triajeInstance?.sexo}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="nacionalidad"><g:message code="triaje.nacionalidad.label" default="Nacionalidad" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'nacionalidad', 'errors')}">
                                    <g:textField style="width:250px" name="nacionalidad" value="${triajeInstance?.nacionalidad}" />
                                </td>
                            </tr>                        
                            <tr>
                                <td valign="top" class="name">
                                    <label for="login"><g:message code="triaje.login.label" default="Login" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'login', 'errors')}">
                                    <g:textField style="width:250px" name="login" value="${triajeInstance?.login}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                             <tr>
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="triaje.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'password', 'errors')}">
                                    <g:passwordField style="width:250px" name="password" value="${triajeInstance?.password}" /><span class="obligatorio">&nbsp;*</span>
                                </td>
                            </tr>
                           <tr>
                                <td valign="top" class="name">
                                    <label for="mail"><g:message code="triaje.mail.label" default="Mail" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'mail', 'errors')}">
                                    <g:textField style="width:250px" name="mail" value="${triajeInstance?.mail}" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="numColegioMedico"><g:message code="triaje.numColegioMedico.label" default="Num Colegio Medico" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'numColegioMedico', 'errors')}">
                                    <g:textField style="width:250px" name="numColegioMedico" value="${fieldValue(bean: triajeInstance, field: 'numColegioMedico')}" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label for="numMinisterioSalud"><g:message code="triaje.numMinisterioSalud.label" default="Num Ministerio Salud" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: triajeInstance, field: 'numMinisterioSalud', 'errors')}">
                                    <g:textField style="width:250px" name="numMinisterioSalud" value="${fieldValue(bean: triajeInstance, field: 'numMinisterioSalud')}" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                <p>&nbsp;</p>
                <div>
                    <g:submitButton name="create" class="boton_submit" value="${message(code: 'button.create.label', default: 'Crear')}" />
                </div>
            </g:form>
        </div>
           <p>&nbsp;</p>
          </div>
       </div>
        <p style="clear:both">&nbsp;</p>
      </div>
    </body>
</html>
