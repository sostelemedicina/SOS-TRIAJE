package caso

import medico.Triaje
import persona.ActorSistema
import java.util.List
import status.Status
import medico.Medico

class CasoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def beforeInterceptor = [action:this.&auth]

    def auth() {
        if(!session.ActorSistema) {
            redirect(controller:"actorSistema", action:"login")
        }
    }
   
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [casoInstanceList: Caso.list(params), casoInstanceTotal: Caso.count()]
    }

    def create = {
        def casoInstance = new Caso()
        casoInstance.properties = params
        return [casoInstance: casoInstance]
    }

    def save = {
        def s = Status.createCriteria()
        def statusInstance = s.list{                
            eq("nombre", "En espera")
        }

        def auxiliar = ""
        statusInstance.each{
            auxiliar = auxiliar + it.id
        }  
        def status = Status.get(auxiliar)

        def casoInstance = new Caso(params)
        casoInstance.status=status
        
        if (casoInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])}"
            redirect(action: "show", id: casoInstance.id)
        }
        else {
            render(view: "create", model: [casoInstance: casoInstance])
        }
    }

    def show = {
        def casoInstance = Caso.get(params.id)
        if (!casoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
            redirect(action: "list")
        }
        else {
            [casoInstance: casoInstance]
        }
    }
        
    def listaDeCasosT = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        if(session?.ActorSistema?.rol == "Triaje" ){
           
          render(view: "menuTriaje", model: [casoInstanceList: Caso.list(params), casoInstanceTotal: Caso.count()]) 
        }
        
        if(session?.ActorSistema?.rol == "Especialista" ){
            
            def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
            
            def c = HistorialCaso.createCriteria()
            def results = c.list {
                eq("medico", actorInstance) 
                projections { 
                   distinct("caso")            
                }            
    //      CONDICIONALES PARA EL ORDENAMIENTO
                    if ((params.sort=="fechaInicio")||(params.sort=="fechaSolucion")||(params.sort=="status")||(params.sort=="descripcion")){
                       caso{//OPERADOR ELVIS
                            def campo=params.sort?:"fecha"
                            def orden=params.order?:"asc"
                            order(campo, orden)
                        }
                    }

                    if ((params.sort=="nombre")||(params.sort=="cedula")){
                        caso{
                            paciente{
                                def campo=params.sort?:"nombre"
                                def orden=params.order?:"asc"
                                order(campo, orden)  
                            }
                        }
                    }                
                maxResults(10)        
            }    
            render(view: "menuEspecialista", model: [casoInstanceList: results, casoInstanceTotal: Caso.count()])
         }
    }
    
    def mostrarPorMedico = {
//      MEDICO QUE INGRESO AL SISTEMA
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)

//      OPERADOR ELVIS - OPERADOR TERNARIO ACORTADO
        def campo=params.sort?:"fecha"
        def orden=params.order?:"asc"
        
//      HISTORIALES EN LOS CUALES HA SIDO ACTOR EL MEDICO QUE INGRESO EL SISTEMA        
        def historialInstance = HistorialCaso.findAllByMedico(actorInstance, [sort:campo, order:orden]) 
        
        render(view: "mostrarPorMedico", model: [historialCasoInstanceList: historialInstance, historialCasoInstanceTotal: HistorialCaso.count()]) 
} 

    def miHistorial = {
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        def historialInstance = HistorialCaso.findAllByMedico(actorInstance)
        
        def campo=params.sort?:"fecha"
        def orden=params.order?:"asc"
        
        List casoInstanceList = []
        
        historialInstance.each{
            casoInstanceList.add(HistorialCaso.findAllByCaso(it.caso))          
        }
        
     render(view: "mostrarPorMedicoP", model: [historialCasoInstanceList: casoInstanceList, historialCasoInstanceTotal: casoInstanceList.count()]) 
    }
    
    def casosAsociados = {
//      MEDICO QUE INGRESO AL SISTEMA
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)

//      CRITERIA PARA LISTAR LOS CASOS DISTINTOS DEL MEDICO ACTOR DEL SISTEMA        
        def c = HistorialCaso.createCriteria()
        def results = c.list {
            eq("medico", actorInstance) 
            projections { 
               distinct("caso")            
            }            
//      CONDICIONALES PARA EL ORDENAMIENTO
                if ((params.sort=="fechaInicio")||(params.sort=="fechaSolucion")||(params.sort=="status")||(params.sort=="descripcion")){
                   caso{
                        def campo=params.sort?:"fecha"
                        def orden=params.order?:"asc"
                        order(campo, orden)
                    }
                }

                if ((params.sort=="nombre")||(params.sort=="cedula")){
                    caso{
                        paciente{
                            def campo=params.sort?:"nombre"
                            def orden=params.order?:"asc"
                            order(campo, orden)  
                        }
                    }
                }                
            maxResults(10)        
        }          
        render(view: "casosAsociados", model: [CasoInstanceList: results])
} 
    
    def modificarCasos = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        
        if(session?.ActorSistema?.rol == "Triaje" ){
            
            def c = HistorialCaso.createCriteria()
            def results = c.list {
                projections { 
                   distinct("caso")            
                }            
                    if ((params.sort=="fechaInicio")||(params.sort=="fechaSolucion")||(params.sort=="status")||(params.sort=="descripcion")){
                       caso{//OPERADOR ELVIS
                            def campo=params.sort?:"fecha"
                            def orden=params.order?:"asc"
                            order(campo, orden)
                        }
                    }

                    if ((params.sort=="nombre")||(params.sort=="cedula")){
                        caso{
                            paciente{
                                def campo=params.sort?:"nombre"
                                def orden=params.order?:"asc"
                                order(campo, orden)  
                            }
                        }
                    }                
                maxResults(10)        
            }

            render(view: "modificarCaso", model: [casoInstanceList: results, casoInstanceTotal: Caso.count()]) 
        }       
    }

    def casosSinAsignar = {
//    params.max = Math.min(params.max ? params.int('max') : 10, 100)
        if(session?.ActorSistema?.rol == "Triaje" ){        
//            
            def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
            def historialInstance = HistorialCaso.getAll()
//
            def status1 = Status.get(1)
            def status2 = Status.get(2)
            def status4 = Status.get(4)
            def status10 = Status.get(10)
            def status11 = Status.get(11)
////
            List casoInstanceList = []
            
            def casoInstance = Caso.findAllByStatus(status1)
            casoInstance.each{
                println "CASO:  "+it.id
                casoInstanceList.add(it)
            }
            
//            List casoInstanceList = []
////
//            casoInstance.each{
//            if ((casoInstance.status==status1){
//                
//                casoInstanceList.add(casoInstance)
//            }
//        }
            historialInstance.each{            
                if (((it.estadoCaso==status1.nombre)&&(it.caso.status.nombre==status1.nombre))||
                    ((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status10.nombre))||
                    ((it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status11.nombre))){  
                    
                        casoInstanceList.add(Caso.get(it.caso.id))  
                }               
            }
////            
            render(view: "asignarCaso", model: [casoInstanceList: casoInstanceList, casoInstanceTotal: casoInstanceList.count()]) 
          
//            def status1 = Status.get(1)
//            def status10 = Status.get(10)
//            def status11 = Status.get(11)
//
//            def c = Caso.createCriteria()
//            def noAsignados = c.list{
//                eq("status", status1)
//                maxResults(10) 
//            }
//
//            render(view: "asignarCaso", model: [casoInstanceList: noAsignados, casoInstanceTotal: noAsignados.count()]) 
        }

        if(session?.ActorSistema?.rol == "Especialista" ){

            def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
            def historialInstance = HistorialCaso.findAllByMedico(actorInstance)

            def status2 = Status.get(2)
            def status3 = Status.get(3)
            def status4 = Status.get(4)
            def status5 = Status.get(5)

            List casoInstanceList = []

            historialInstance.each{            
                if (((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status2.nombre))||
                    ((it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status4.nombre))||
                    ((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status3.nombre))||
                    ((it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status5.nombre))){                    
                
                casoInstanceList.add(Caso.get(it.caso.id))  
                }               
            }            
            render(view: "segundaOpinion", model: [casoInstanceList: casoInstanceList, casoInstanceTotal: casoInstanceList.count()]) 
        }        
    }   
    
    def edit = {
        def casoInstance = Caso.get(params.id)
        if (!casoInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [casoInstance: casoInstance]
        }
    }

    def update = {
        def casoInstance = Caso.get(params.id)
        if (casoInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (casoInstance.version > version) {
                    
                    casoInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'caso.label', default: 'Caso')] as Object[], "Another user has updated this Caso while you were editing")
                    render(view: "edit", model: [casoInstance: casoInstance])
                    return
                }
            }
            casoInstance.properties = params
            if (!casoInstance.hasErrors() && casoInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])}"
                redirect(action: "show", id: casoInstance.id)
            }
            else {
                render(view: "edit", model: [casoInstance: casoInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def casoInstance = Caso.get(params.id)
        if (casoInstance) {
            try {
                casoInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'caso.label', default: 'Caso'), params.id])}"
            redirect(action: "list")
        }
    }
    
    def vResolverCaso = {
//TRIAJE
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        def historialInstance = HistorialCaso.findAllByMedico(actorInstance)
        
        def status2 = Status.get(2)
        def status3 = Status.get(3)
        def status4 = Status.get(4)
        def status5 = Status.get(5)
            
        List casoInstanceList = []
        
        historialInstance.each{            
            if (((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status3.nombre))||
                ((it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status5.nombre))){
                
                casoInstanceList.add(Caso.get(it.caso.id))  
                }               
            }
            
        render(view: "resolverCaso", model: [casoInstanceList: casoInstanceList, casoInstanceTotal: casoInstanceList.count()]) 
    }    
    
    def aceptarCaso = {
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        def historialInstance = HistorialCaso.findAllByMedico(actorInstance)

        def status2 = Status.get(2)
        def status4 = Status.get(4)

        List casoInstanceList = []
        
        historialInstance.each{
            if((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status2.nombre)||
               (it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status4.nombre)){
               
                casoInstanceList.add(Caso.get(it.caso.id))  
            }
        }
        render(view: "aceptarCaso", model: [casoInstanceList: casoInstanceList, casoInstanceTotal: casoInstanceList.count()]) 
    }    
    
    def saveAceptarCaso= {
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        Date date = new Date()
        def casoInstance = Caso.get(params.id)        
        def medicoInstance = Medico.get(actorInstance.id)

        def status2 = Status.get(2)
        def status3 = Status.get(3)
        def status4 = Status.get(4)
        def status5 = Status.get(5)

        if (casoInstance.status==status2){
          casoInstance.status = status3   
        }
        if (casoInstance.status==status4){
          casoInstance.status = status5   
        }        

        def asignacion = new HistorialCaso()
        asignacion.fecha = date
        asignacion.medico = medicoInstance
        asignacion.estadoCaso = casoInstance.status.nombre
        asignacion.caso = casoInstance

        if (asignacion.save(flush: true)) {
                flash.message = "${message(code: 'aceptado', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])}"
                render(view: "aceptarCaso", model: [casoInstance: casoInstance, casoInstanceTotal: casoInstance.count()])
        }
        else {
                render(view: "aceptarCaso", model: [casoInstance: casoInstance, casoInstanceTotal: casoInstance.count()])
        }       
    }
    
	def rechazarCaso = {
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        def historialInstance = HistorialCaso.findAllByMedico(actorInstance)

        def status2 = Status.get(2)
        def status4 = Status.get(4)

        List casoInstanceList = []
        
        historialInstance.each{
            if((it.estadoCaso==status2.nombre)&&(it.caso.status.nombre==status2.nombre)||
               (it.estadoCaso==status4.nombre)&&(it.caso.status.nombre==status4.nombre)){
               
                casoInstanceList.add(Caso.get(it.caso.id))  
            }
        }
        render(view: "rechazarCaso", model: [casoInstanceList: casoInstanceList, casoInstanceTotal: casoInstanceList.count()]) 
    }     
    
    def saveRechazarCaso= {
        def actorInstance = ActorSistema.get(session?.ActorSistema?.id)
        Date date = new Date()
        def casoInstance = Caso.get(params.id)        
        def medicoInstance = Medico.get(actorInstance.id)

        def status2 = Status.get(2)
        def status4 = Status.get(4)
        def status10 = Status.get(10)
        def status11 = Status.get(11)

        if (casoInstance.status==status2){
          casoInstance.status = status10   
        }
        if (casoInstance.status==status4){
          casoInstance.status = status11   
        }        

        def asignacion = new HistorialCaso()
        asignacion.fecha = date
        asignacion.medico = medicoInstance
        asignacion.estadoCaso = casoInstance.status.nombre
        asignacion.caso = casoInstance

        if (asignacion.save(flush: true)) {
                flash.message = "${message(code: 'rechazado', args: [message(code: 'caso.label', default: 'Caso'), casoInstance.id])}"
                render(view: "rechazarCaso", model: [casoInstance: casoInstance, casoInstanceTotal: casoInstance.count()])
        }
        else {
                render(view: "rechazarCaso", model: [casoInstance: casoInstance, casoInstanceTotal: casoInstance.count()])
        }       
    }    
}