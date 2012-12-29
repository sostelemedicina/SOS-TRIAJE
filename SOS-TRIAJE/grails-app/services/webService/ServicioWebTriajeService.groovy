package webService
import pojos.PojoPrueba
import pojos.PojoCaso
//import pojos.PojoMedico
import triaje.PojoCasoResuelto
import persona.Paciente
import pojos.PojoArchivo
import pojos.PojoEspecialidad
import pojos.PojoPaciente

import java.util.List

import archivo.Archivo
import caso.Caso
import opinion.Opinion
import centro.CentroSOS
import especialidad.Especialidad
import persona.Persona
import persona.Paciente
import status.Status
import java.text.SimpleDateFormat


class ServicioWebTriajeService {

    static transactional = true
    static expose=['cxf']

    def triajeService

    public PojoCaso thisCaso
    public List<PojoArchivo> thisArchivos
    public List<PojoEspecialidad> thisEspecialidades
    public PojoPaciente thisPaciente
    public String thisUuid

    //SERVICIO PARA ENVIAR EL CASO A SOS-TRIAJE DESDE SOS-HME Y OPERAR SOS-TRIAJE
    boolean enviarCasoTriaje(PojoCaso caso, String uuid){
        boolean flag = false

        if(caso){
            def centroInstance = CentroSOS.findByUuid(uuid)
            if (centroInstance){
                def casoNuevo = new Caso()
                println "centro encontrado"
                flag = true

                //OPERACIONES PARA GUARDAR TODO EN LA BASE DE DATOS
                this.thisCaso = caso
                this.thisArchivos = thisCaso.archivos
                this.thisEspecialidades = thisCaso.especialidad
                this.thisPaciente = thisCaso.paciente
                this.thisUuid = uuid

                def status = Status.get(1)         //En espera

                Date today = new Date()
                
                def pacienteNuevo = new Paciente()
                pacienteNuevo.nombre = thisPaciente.nombre
                pacienteNuevo.apellido = thisPaciente.apellido
                pacienteNuevo.cedula = Integer.parseInt(thisPaciente.cedula)
                pacienteNuevo.sexo = thisPaciente.sexo
                pacienteNuevo.fechaNacimiento = new Date().parse("yyyy-MM-dd",thisPaciente.fechaNacimiento)
                
                def pacienteInstance = Paciente.findByCedula(Integer.parseInt(thisPaciente.cedula))
                if(pacienteInstance){
                    println "Paciente encontrado"
                    casoNuevo.paciente = pacienteInstance
                }else{
                    if (!pacienteNuevo.save()) println "Error al guardar el paciente: "+paciente.errors
                    casoNuevo.paciente = pacienteNuevo
                }              
                
                casoNuevo.descripcion = thisCaso.descripcion
                casoNuevo.fechaInicio = today                
                casoNuevo.status = status
                casoNuevo.idCasoSOS = thisCaso.idCasoSOS
                casoNuevo.centro = centroInstance

                if (thisEspecialidades){
                    int i=0;
                    while (i< thisEspecialidades.size())
                    {
                        def especialidad = Especialidad.findByNombre(thisEspecialidades.get(i).nombre)
                        casoNuevo.addToEspecialidades(especialidad)
                        i++;
                    }
                }
                if (thisArchivos){
                    int j=0;
                    while (j< thisArchivos.size())
                    {
                        def archivo = new Archivo()
                        archivo.nombre = thisArchivos.get(j).nombre
                        archivo.descripcion = thisArchivos.get(j).descripcion
                        archivo.adjunto = thisArchivos.get(j).adjunto
                        archivo.save()
                        casoNuevo.addToArchivos(archivo)
                        j++;
                    }
                }
                
                def casoInstance = Caso.findByIdCasoSOS(thisCaso.idCasoSOS)
                if (casoInstance){
                    println "Caso ya existente"
                }else{
                    if (!casoNuevo.save()) println "Error al guardar el caso: "+casoNuevo.errors
                }                
            }
        }

        return flag
    }

    //SERVICIO PARA OBTENER EL STATUS DEL CASO, SI ES "CERRADO" LLAMAR AL SERVICIO SIGUIENTE
    List<String> getIdCasoCerrado(String uuid){
        List<String> IdCasosCerrados = new ArrayList<String>();
           
        def centroInstance = CentroSOS.findByUuid(uuid)
        def status8 = Status.get(8)         //Cerrado
        def casosCerrados

        if(centroInstance){
            
            def c = Caso.findByCentro(centroInstance).createCriteria()
            casosCerrados = c.list {
                eq("status", status8) 
            }
                
            casosCerrados.each{
//                println "caso cerrado: "+it.idCasoSOS
                IdCasosCerrados.add(it.idCasoSOS)
            }
        }

        return IdCasosCerrados
    }


    PojoCasoResuelto getCasoResuelto(String idCasoSOS){
        //OPERACIONES PARA OBTENER EL CASO RESUELTO
//        println "id caso a buscar: "+idCasoSOS
//        println "paso por aqui 1"
        def casoInstance = Caso.findByIdCasoSOS(idCasoSOS)
//        println "caso en triaje: "+casoInstance        
//        println "paso por aqui 2"

        //Ultima opinion del caso, tiene consigo el medico quien emitio la opinion
        def opinionInstance = Opinion.findAllByCaso(casoInstance, [sort: "fechaOpinion", order: "desc"])
            opinionInstance=opinionInstance.first()
        println "cuerpo opinion: "+opinionInstance.cuerpoOpinion+" "+opinionInstance.cuerpoOpinion.class
        String Opinion = opinionInstance.cuerpoOpinion
        
        SimpleDateFormat fecha = new SimpleDateFormat("yyyy-MM-dd")
        String fechaSolucion = fecha.format(casoInstance.fechaSolucion)
//        println " fecha solucion en string: "+fechaSolucion  
        
//            println "paso 1"
//            //Medico que emitio la solucion al caso   
//            PojoMedico medicoCaso = new PojoMedico()
//            println "paso 2"
//            medicoCaso.nombre = opinionInstance.medico.nombre
//            println "paso 3a "+opinionInstance.medico.nombre
//            println "paso 3b "+medicoCaso.nombre
//            medicoCaso.apellido = opinionInstance.medico.apellido
//            println "paso 4a "+opinionInstance.medico.apellido
//            println "paso 4b "+medicoCaso.apellido
//            if (opinionInstance.medico.numColegioMedico){
//                medicoCaso.colegioDeMedico = opinionInstance.medico.numColegioMedico
//            println "paso 5a "+opinionInstance.medico.numColegioMedico
//            println "paso 5b "+medicoCaso.colegioDeMedico
//            }   
//            if (opinionInstance.medico.numMinisterioSalud){
//               medicoCaso.ministerioDeSalud = opinionInstance.medico.numMinisterioSalud 
//               println "paso 6a "+opinionInstance.medico.numMinisterioSalud
//               println "paso 6b "+medicoCaso.ministerioDeSalud
//            }
            println "paso 7"
            
            println "paso 8"
            /*
//    public String opinion; //VERIFICAR SI ES MEJOR QUE SEA UN POJO PARA QUE ENVIE ARCHIVOS TAMBIEN
        PojoCasoResuelto casoResuelto = new PojoCasoResuelto()
        println "paso 9"
            casoResuelto.setIdCasoSOS(idCasoSOS)
            println "paso 10 "+casoResuelto.getIdCasoSOS()
            println "Opinion: "+Opinion
            casoResuelto.setOpinion(Opinion)
            println "paso 11 "+casoResuelto.getOpinion()
//            println "Medico: "+medicoCaso.nombre
//            casoResuelto.setResponsable(medicoCaso)            
            println "paso 12 "+casoResuelto.getResponsable()
            casoResuelto.setFechaSolucion(fechaSolucion)
            println "paso 13 "+casoResuelto.getFechaSolucion
            
        println "pojo caso resuelto: "
        println "pojo caso resuelto: "+casoResuelto
        */
        return casoResuelto
    }
}
