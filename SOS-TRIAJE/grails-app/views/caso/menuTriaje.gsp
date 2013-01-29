
<%@ page import="caso.Caso" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="referenc" />
        <g:set var="entityName" value="${message(code: 'caso.label', default: 'Caso')}" />
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
          <div id="infoSec"><g:formatDate format="dd-MM-yyyy HH:mm a" date="${new Date()}"/>&nbsp;<div><br/></div></div>
          <div id="header"><div id="loginHeader"><g:loginControl/></div></div>
        </div>
      </div>

      <div id="menu1">
        <ul>
        <li><g:link controller="caso" action="listaDeCasosT" class="selected"><g:message code="Casos" /></g:link></li>
        <li><g:link controller="historialCaso" action="listaDeHistorialesT"><g:message code="Historiales" /></g:link></li>        
        <li><g:link controller="caso" action="casosAsociados"><g:message code="Mis casos" /></g:link></li>
        <li><g:link controller="caso" action="miHistorial"><g:message code="Mi historial" /></g:link></li>
        <li><g:link controller="opinion" action="verRespuestasT"><g:message code="Ver Respuestas" /></g:link></li>       
        <li><g:link controller="caso" action="aceptarCaso"><g:message code="Tramitar casos" /></g:link></li>  
        </ul>
      </div>

<div id="nivel1">
<div id="nivel3"> 
<g:form  method="post">
    <label for="desde">
      <g:message code="buscar.desde.label" default="Desde" />
    </label>
      <g:datePicker name="desde" value="" precision="day" noSelection="['':'']" />

    <label for="hasta">
      <g:message code="buscar.hasta.label" default="Hasta" />
    </label>
      <g:datePicker name="hasta" value="" precision="day" noSelection="['':'']" />    
   
<g:actionSubmit action="verPorFechaT" value="Filtrar" class="boton1"/>

<g:actionSubmit action="listaDeCasosT" value="Todos" class="boton1"/>

</g:form>     
 
</div>      
</div>
      
<div id="nivel1">
  <div id="nivel2">
    <div id="contenido">
        
        <div  class="form1">
              <table class="tabla2" >
                    <thead>
                        <tr>
                          <g:if test="${tipoBusqueda==1}">  
                            <g:sortableColumn property="id" title="${message(code: 'id.label', default: 'Id')}" />
                          
                            <g:sortableColumn property="descripcion" title="${message(code: 'descipcion.caso.label', default: 'Caso')}"/>
                                    
                            <g:sortableColumn property="status" title="${message(code: 'estado.caso.label', default: 'Estado')}" />

                            <g:sortableColumn property="fechaInicio" title="${message(code: 'fecha.inicio.label', default: 'Fecha inicio')}" />

                            <th><g:message code="especialidad.label" default="Especialidad" /></th>

                            <th><g:message code="medico.nombre.label" default="Nombre Médico" /></th>
                            
                            <th><g:message code="paciente.nombre.label" default="Nombre Paciente" /></th>
                             
                            <th><g:message code="paciente.ci.label" default="CI Paciente" /></th>
                            
                            <th><g:message code="archivos.label" default="Archivos" /></th>
                    
                            <th><g:message code="opiniones.label" default="Diagnósticos" /></th>
                          </g:if>
                          <g:if test="${tipoBusqueda==2}">
                            <th><g:message code="id.label" default="Id" /></th>
                            
                            <th><g:message code="descipcion.caso.label" default="Caso" /></th>
                                    
                            <th><g:message code="estado.caso.label" default="Estado" /></th>

                            <th><g:message code="fecha.inicio.label" default="Fecha inicio" /></th>

                            <th><g:message code="especialidad.label" default="Especialidad" /></th>
                            
                            <th><g:message code="medico.nombre.label" default="Nombre Médico" /></th>
                            
                            <th><g:message code="paciente.nombre.label" default="Nombre Paciente" /></th>
                             
                            <th><g:message code="paciente.ci.label" default="CI Paciente" /></th>
                            
                            <th><g:message code="archivos.label" default="Archivos" /></th>
                    
                            <th><g:message code="opiniones.label" default="Diagnósticos" /></th>                            
                          </g:if>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${casoInstanceList}" status="i" var="casoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td style="width:10px;">${casoInstance.id}</td>
                          
                            <td style="width:320px;" class="pJustifica"><g:encodeAs codec="NL2BR">${casoInstance.descripcion}</g:encodeAs></td>
                        
                            <td style="width:65px;">${casoInstance.status.nombre}</td>
                            
                            <td style="width:85px;"><g:formatDate format="dd-MM-yyyy HH:mm a" date="${casoInstance.fechaInicio}"/></td>
                            
                            <td style="width:85px;">
                                <g:each in="${casoInstance.especialidades}" var="e">
                                  ${e?.nombre?.encodeAsHTML()}
                                </g:each>                            
                            </td>
                                                       
                            <td style="width:85px;">${medicoList[i]?.nombre} 
                                ${medicoList[i]?.apellido}
                            </td>                             
                        
                            <td style="width:8px;">${casoInstance.paciente.nombre}
                                ${casoInstance.paciente.apellido}
                            </td>                        
                            
                            <td style="width:60px;">${casoInstance.paciente.cedula}</td>
                            
                            <td style="width:120px;">
                                <g:each in="${casoInstance.archivos}" var="archivos">                                  
                                  <li><g:link controller="archivo" action="showArchivoSeleccionado" id="${archivos.id}" target="_blank">${archivos?.nombre?.encodeAsHTML()}</g:link></li>
                                </g:each>                            
                            </td>
                            
                            <td style="width:125px;">
                               <g:each in="${casoInstance.opiniones}" var="o">
                                 <li><g:link controller="opinion" action="show" id="${o.id}">${o?.nombreOpinion?.encodeAsHTML()}</g:link></li>
                               </g:each>
                          </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            
            <div class="paginateButtons">
                <g:paginate total="${casoInstanceTotal}" />
            </div>           
        </div>
          <p>&nbsp;</p>
          
    </div>      
  </div>
  <p style="clear:both">&nbsp;</p>
</div>
    </body>
</html>