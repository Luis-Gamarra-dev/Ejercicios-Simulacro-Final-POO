class Animal
	attr_reader :iD, :especie, :nombre, :sexo 
	def initialize(iD, especie, nombre, sexo)
		@iD      = iD
		@especie = especie
		@nombre  = nombre
		@sexo    = sexo
	end
	def calcularGastoMensualEnAlimentacion() 
	 	
	end 
	def calcularGastoMensulaEnMantenimiento()
		
	end
end

class Mamifero < Animal
	attr_reader :edad, :peso
	def initialize(iD, especie, nombre, sexo, edad, peso)
		super(iD, especie, nombre, sexo)
		@edad = edad
		@peso = peso
	end
	def calcularGastoMensualEnAlimentacion() 
	 	return 30*2.00*peso
	end 
	def calcularGastoMensualEnMantenimiento()
		return 30*1.00*peso
	end
end

class Reptil < Animal
	attr_reader :edad , :tamanio
	def initialize(iD, especie, nombre, sexo, edad, tamanio)
		super(iD, especie, nombre, sexo)
		@edad    = edad
   		@tamanio = tamanio
	end
	def obtenerFactorPorConceptoYTamanio(concepto,tamanio)
		case concepto
		when "alimentacion"
			case tamanio[0]
			    when "G"
			    	return 30
		     	when "M"
		     		return 20
			    when "P"	
			        return 10
			end
		when "mantenimiento"
			case tamanio[0]	
			    when "G"
			    	return 12
		     	when "M"
		     		return 8
			    when "P"	
			        return 4
			end
		end
	end
	def calcularGastoMensualEnAlimentacion() 
		concepto = "alimentacion"
	 	return 30*obtenerFactorPorConceptoYTamanio(concepto,tamanio)
	end 
	def calcularGastoMensualEnMantenimiento()
		concepto = "mantenimiento"
		return 30*obtenerFactorPorConceptoYTamanio(concepto,tamanio)
	end
end

class Ave < Animal
	attr_reader :tipo
	def initialize(iD, especie, nombre, sexo, tipo)
		super(iD, especie, nombre, sexo)
		@tipo = tipo
	end
	def obtenerFactorPorTipo(tipo)
		case tipo[0]
		when "F"
			return 15
		when "C"
			return 30
		end	
	end
	def calcularGastoMensualEnAlimentacion() 
	 	return 30*obtenerFactorPorTipo(tipo)
	end 
	def calcularGastoMensualEnMantenimiento()
		return 30*8
	end
end
############################################################
class Administrador
	attr_accessor :animales
	def initialize()
		@animales = []
	end
	def registrarAnimal(animal)
		animales.push(animal)
	end
	def validarSexo(sexo)
		unless  sexo == "Macho" || sexo == "Hembra"
			raise "Sexo ingresado no válido!" + "\n" + "Ingrese nuevamente el sexo del animal."
		end	
		return true	
	end	
	def validarEdadOPeso(numero)
		unless numero >= 0
			raise "No se permiten valores negativos!" + "\n" + "Ingrese nuevamente la edad o peso del animal."
	    end
		return true
	end
		
	def validarTamanioAnimal(tamanio)
		unless tamanio == "Grande" || tamanio == "Mediano" || tamanio == "Pequenio"
			raise "Tamaño ingresado no válido!" + "\n" + "Ingrese nuevamente el tamaño del animal."
		end
		return true
	end
	def validarTipoAve(tipoAve)
		unless tipoAve == "Carroniera" || tipoAve == "Fruticola" 
			raise "Tipo de Ave ingresado no válido!" + "\n" + "Ingrese nuevamente el tipo de Ave."
		end
		return true
	end
	def borrarDeListaAnimal(id)
		for animal in animales
			if animal.iD == id
				animales.delete(animal)
			end
		end
	end
	def listarAnimales()
		return animales
	end
	def calcularGastoMensualEnAlimentacionAnimales()
		alimentacion = 0
		for animal in animales
			alimentacion = alimentacion + animal.calcularGastoMensualEnAlimentacion()
		end
		return alimentacion
	end
	def calcularGastoMensualEnMantenimientoAnimales()
		mantenimiento = 0
		for animal in animales
			mantenimiento = mantenimiento + animal.calcularGastoMensualEnMantenimiento()
		end
		return mantenimiento
	end
	def calcularGastoTotalMensualAnimales()
		return calcularGastoMensualEnMantenimientoAnimales() + calcularGastoMensualEnAlimentacionAnimales()
	end
end
##################################################################
class Factoria
	def self.crear(tipo, datos)
		case tipo
		    when "Mamifero" 
		    	Mamifero.new(datos[0],datos[1],datos[2],datos[3],datos[4],datos[5])                                                                                                                                                               
		    when "Reptil"
		    	Reptil.new(datos[0],datos[1],datos[2],datos[3],datos[4],datos[5])
	        when "Ave"
	        	Ave.new(datos[0],datos[1],datos[2],datos[3],datos[4])
	    end
	end
end
####################################################################
class VistaEntrada
	def capturarTipoAnimal()
		print("Tipo de animal: ")
		tipo   = gets.chomp.to_s
		return tipo
	end
	def capturarDatosBasicosAnimal()
		print("ID: ")
		id = gets.chomp.to_s
		print("Especie: ")
		especie = gets.chomp.to_s
		print("Nombre: ")
		nombre = gets.chomp.to_s
		return id, especie, nombre
	end
	def capturarSexoAnimal()
		print("Sexo: ")
		sexo = gets.chomp.to_s
		return sexo
	end
	def capturarEdadAnimal()
		print("Edad(meses): ")
		edad = gets.chomp.to_i
		return edad
	end
	def capturarPesoAnimal()
		print("Peso(Kg.): ")
		peso = gets.chomp.to_i
		return peso
	end
	def capturarTamanioAnimal()
		print("Tamaño: ")
		tamanio = gets.chomp.to_s
		return tamanio
	end
    def capturarTipoAve()
		print("Tipo de Ave: ")
	    tipoAve = gets.chomp.to_s
	    return tipoAve
    end
    def capturarIDdeAnimalAEliminar()
    	print("Ingrese el ID del animal que desee eliminar: ")
    	id = gets.chomp.to_s
        return id
    end
end

class VistaSalida
	def mostrarMensaje(mensaje)
		puts mensaje
	end
	def mostrarListaAnimales(lista)
		for animal in lista
			claseAnimal = animal.class.to_s
			case claseAnimal
			    when "Mamifero"
				    mostrarMamifero(animal)
			    when "Reptil"
				    mostrarReptil(animal)
			    when "Ave"	
				    mostrarAve(animal)
			end
		end
	end
	def mostrarMamifero(animal)
		puts "************Mamifero*************"
		puts "ID: #{animal.iD}"
		puts "Especie: #{animal.especie} "
		puts "Nombre: #{animal.nombre}"
		puts "Sexo: #{animal.sexo}"
		puts "Edad: #{animal.edad.to_s} meses"
        puts "Peso: #{animal.peso.to_s} Kg."
	end
	def mostrarReptil(animal)
		puts "************Reptil*************"
		puts "ID: #{animal.iD}"
		puts "Especie: #{animal.especie} "
		puts "Nombre: #{animal.nombre}"
		puts "Sexo: #{animal.sexo}"
		puts "Edad: #{animal.edad.to_s} meses"
        puts "Tamaño: #{animal.tamanio}"
	end
	def mostrarAve(animal)
		puts "************Ave*************"
		puts "ID: #{animal.iD}" 
		puts "Especie: #{animal.especie} "
		puts "Nombre: #{animal.nombre}"
		puts "Sexo: #{animal.sexo}"
		puts "Tipo de ave: #{animal.tipo}"
	end
	def mostrarGastoTotalMensualAnimales(gasto)
		puts "El gasto total mensual por alimentación y mantenimiento de los animales registrados es de S/#{gasto}."
	end
end

class Controlador
	attr_reader :vistaEntrada, :vistaSalida, :administrador
	def initialize(vistaEntrada, vistaSalida, administrador)
		@vistaEntrada  = vistaEntrada
		@vistaSalida   = vistaSalida
		@administrador = administrador
	end
	def registrarAnimal()
		tipoAnimal         = vistaEntrada.capturarTipoAnimal
		datosBasicosAnimal = vistaEntrada.capturarDatosBasicosAnimal
		begin
		sexo = vistaEntrada.capturarSexoAnimal
		administrador.validarSexo(sexo)	
		rescue Exception => e
			vistaSalida.mostrarMensaje(e.message)
			retry while true
		end
		case tipoAnimal
		    when "Mamifero"
		    	begin
		    	edad = vistaEntrada.capturarEdadAnimal
                administrador.validarEdadOPeso(edad) 	
                rescue Exception => e
			        vistaSalida.mostrarMensaje(e.message)
			        retry while true
		        end
		        begin
		    	peso = vistaEntrada.capturarPesoAnimal
		    	administrador.validarEdadOPeso(peso)
		    	rescue Exception => e
			        vistaSalida.mostrarMensaje(e.message)
			        retry while true
		        end
		    	datosBasicosAnimal.push(sexo, edad, peso)
			when "Reptil"
				begin
		    	edad = vistaEntrada.capturarEdadAnimal
		    	administrador.validarEdadOPeso(edad)
		    	rescue Exception => e
			        vistaSalida.mostrarMensaje(e.message)
			        retry while true
		        end
		        begin
		    	tamanio = vistaEntrada.capturarTamanioAnimal
		    	administrador.validarTamanioAnimal(tamanio)
		    	rescue Exception => e
			        vistaSalida.mostrarMensaje(e.message)
			        retry while true
		        end
		    	datosBasicosAnimal.push(sexo, edad, tamanio)
			when "Ave"
				begin
		    	tipoAve = vistaEntrada.capturarTipoAve
		    	administrador.validarTipoAve(tipoAve)
		    	rescue Exception => e
			        vistaSalida.mostrarMensaje(e.message)
			        retry while true
		        end
		    	datosBasicosAnimal.push(sexo, tipoAve)
		    end

		animal = Factoria.crear(tipoAnimal,datosBasicosAnimal)
		administrador.registrarAnimal(animal)
		vistaSalida.mostrarMensaje("Animal registrado!")
	end
	def listarAnimalesRegistrados()
		lista = administrador.listarAnimales
		vistaSalida.mostrarListaAnimales(lista)
	end
	def eliminarAnimalRegistrado()
		id = vistaEntrada.capturarIDdeAnimalAEliminar
		administrador.borrarDeListaAnimal(id)
		vistaSalida.mostrarMensaje("Animal eliminado")
	end
	def mostrarGastoTotalMensualEnAlimentacionYMantenimiento()
	    gastoTotalMensual = administrador.calcularGastoTotalMensualAnimales
	    vistaSalida.mostrarGastoTotalMensualAnimales(gastoTotalMensual)
	end
	
end

##############
administrador = Administrador.new
vistaEntrada  = VistaEntrada.new
vistaSalida   = VistaSalida.new
controlador   = Controlador.new(vistaEntrada, vistaSalida, administrador)

#####MENU#####
seleccion = 0
while(seleccion !=5)
	system('cls')
    puts "*************************************MENU*************************************"
    puts "Opciones: "
    puts "1. Registrar un animal"
    puts "2. Listar animales registrados"
    puts "3. Eliminar animal registrado"
    puts "4. Mostrar gasto total en alimentación y mantenimiento"
    puts "5. Salir del programa"
    puts "******************************************************************************"
    print "Ingrese la opcion deseada: "
    seleccion = gets.chomp.to_i

    case seleccion
	    when 1
		    puts "Registrando nuevo animal"
		    controlador.registrarAnimal
		    system('pause')
	    when 2
		    puts "Listado de animales registrados"
		    controlador.listarAnimalesRegistrados
		    system('pause')
	    when 3
		    puts "Eliminando animal registrado"
		    controlador.eliminarAnimalRegistrado
		    system('pause')
	    when 4	
		    puts "Mostrando gasto total en alimentación y mantenimiento"
		    controlador.mostrarGastoTotalMensualEnAlimentacionYMantenimiento
		    system('pause')
    end
end


