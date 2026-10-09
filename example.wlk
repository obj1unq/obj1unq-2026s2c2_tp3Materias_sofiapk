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

class Estudiante {
  const carreras = #{}

  method carreras() = carreras

  method inscribirseACarrera(carrera) {
    self.validarInscripciónACarrera(carrera)
    self.agregarCarrera(carrera)
  }

  method validarInscripciónACarrera(carrera) {
    if ( self.seEncuentraInscripteEn(carrera) ) {
      self.error( 'Ya estás inscripte en ' + carrera )
    }
  }

  method seEncuentraInscripteEn(carrera) {
    return carreras.contains(carrera)
  }

  method agregarCarrera(carrera) {
    carreras.add(carrera)
  }

  method cursaLaMateria(materia) {
    return carreras.any( { carrera => carrera.incluyeMateria(materia) } )
  }
}