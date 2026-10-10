class Carrera {
  const materias = #{}

  method materias() = materias

  method incluyeMateria(materia) {
    return materias.contains(materia)
  }
}

class Materia {
  // const property carrera
}

class MateriaCursada {
  var property materia
  var property nota

  method estáAprobada() {
    return nota >= 6
    //return nota.between(6, 10)
  }
}

class Estudiante {
  const carreras = #{}
  var materiasCursadas = [] // lista porque requiere un orden y puede haber cursado la materia mas de una vez

  method materiasCursadas() = materiasCursadas
  method materiasCursadas(_materiasCursadas) { materiasCursadas = _materiasCursadas }
  
  method carreras() = carreras
  
  method inscribirseACarrera(carrera) {
    self.validarInscripciónACarrera(carrera)
    self.agregarCarrera(carrera)
  }

  method validarInscripciónACarrera(carrera) {
    if ( self.estáInscripteEn(carrera) ) {
      self.error( 'Ya estás inscripte en ' + carrera )
    }
  }

  method estáInscripteEn(carrera) {
    return carreras.contains(carrera)
  }

  method agregarCarrera(carrera) {
    carreras.add(carrera)
  }

  method cursaLaMateria(materia) {
    return carreras.any( { carrera => carrera.incluyeMateria(materia) } )
  }

  // 2.1
  method registrarFinalDeCursada(materia, nota) {
    self.validarMateria(materia)
    self.validarNotaObtenida(nota)
    self.validarAprobaciónPrevia(materia) 
    self.registrar(materia, nota)
  }

  method validarMateria(materia) {
    return if ( not self.cursaLaMateria(materia) ) {
      self.error( "La materia " + materia + " no pertenece a ninguna carrera inscripta")
    }
  }

  method validarNotaObtenida(nota) {
    return if ( not nota.between(1, 10) ) { // not ( nota >= 1 && nota <= 10  )
      self.error( "La nota obtenida no es válida" )
    }
  }

  method validarAprobaciónPrevia(materia) {
    return if ( self.tieneAprobadaLaMateria(materia) ) {
      self.error( "La materia " + materia + " ya fue aprobada" )
    }
  }

  method registrar(materia, nota) {
    materiasCursadas.add( new MateriaCursada( materia = materia, nota = nota) )
  }
  
  //2.2
  method tieneAprobadaLaMateria(materia) { // conocer para una persona: si tiene o no aprobada una materia 
    return materiasCursadas.any( { materiaCursada => materiaCursada.estáAprobada() && materiaCursada.materia() == materia } )
  }

  // 2.3
  method cantidadDeMateriasAprobadasEnCarrera(carrera) {
    return self.materiasCursadasAprobadasEn(carrera).size()
  }

  method materiasCursadasAprobadasEn(carrera) {
    return materiasCursadas.filter( { materiaCursada => carrera.incluyeMateria( materiaCursada.materia() ) && materiaCursada.estáAprobada() } )
  }

  method promedioDeMateriasAprobadasEnCarrera(carrera) {
    return self.materiasCursadasAprobadasEn(carrera).average( { materiaCursada => materiaCursada.nota() } )
  }

  /*
  method promedioDeMateriasAprobadasEnCarrera(carrera) {
    return self.totalDeNotasDeMateriasAprobadasEnCarrera(carrera) / self.cantidadDeMateriasAprobadasEnCarrera(carrera)
  }

  method totalDeNotasDeMateriasAprobadasEnCarrera(carrera) {
    return self.materiasCursadasAprobadasEn(carrera).sum( { materiaCursada => materiaCursada.nota() } )
  }
  */

  // 2.4
  method cantidadDeMateriasAprobadasDeTodasLasCarreras() {
    return self.materiasCursadasAprobadasDeTodasLasCarreras().size()
  }

  method materiasCursadasAprobadasDeTodasLasCarreras() {
    return materiasCursadas.filter( { materiaCursada => materiaCursada.estáAprobada() } )
  }

  method promedioDeCarreras() {
    return self.materiasCursadasAprobadasDeTodasLasCarreras().average( { materiaCursada => materiaCursada.nota() } )
  }

  /*
  method promedioDeCarreras() {
    //self.validarPromedio()
    return self.totalDeNotasDeMateriasAprobadasDeTodasLasCarreras() / self.cantidadDeMateriasAprobadasDeTodasLasCarreras()
  }

  method totalDeNotasDeMateriasAprobadasDeTodasLasCarreras() {
    return self.materiasCursadasAprobadasDeTodasLasCarreras().sum( { materiaCursada => materiaCursada.nota() } )
  }

  //method validarPromedio() { PREGUNTAR
  //  if ( self.materiasCursadasAprobadasDeTodasLasCarreras().isEmpty() ){
  //    self.error( "No tenes aprobada ninguna materia en ninguna" )
  //  }
  //}
  */

  // 2.5 
  method cursadasDeMateria(materia) { // para saber la cant de veces que curso x materia
    //return materiasCursadas.count( { materiaCursada => materiaCursada.materia() == materia } )
    return materiasCursadas.filter( { materiaCursada => materiaCursada.materia() == materia } )
  }
}