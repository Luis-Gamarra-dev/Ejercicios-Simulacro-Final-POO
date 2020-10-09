class Trabajador
	attr_reader :nombre, :dni, :horasExtras, :sueldoBasico
	def initialize(nombre, dni, horasExtras, sueldoBasico)
		@nombre       = nombre
		@dni          = dni
		@horasExtras  = horasExtras
		@sueldoBasico = sueldoBasico
	end
	def calcularAumento()

	end
	def calcularExtra()
		return sueldoBasico * horasExtras / 10.0
	end
	def calcularSueldo()
		return sueldoBasico + calcularExtra + calcularAumento
	end
end

class Staff < Trabajador
	def initialize(nombre, dni, horasExtras, sueldoBasico)
		super(nombre, dni, horasExtras, sueldoBasico)
	end
	def calcularAumento()
		return sueldoBasico * 0.15 + calcularExtra
	end
	def calcularExtra()
		return super()
	end
	def calcularSueldo()
		return super()
	end
end

class Auxiliar < Trabajador
	def initialize(nombre, dni, horasExtras, sueldoBasico)
		super(nombre, dni, horasExtras, sueldoBasico)
	end
	def calcularAumento()
		return sueldoBasico * 0.12 + calcularExtra
	end
	def calcularExtra()
		return super()
	end
	def calcularSueldo()
		return super()
	end
end
#######################################################
class Administrador
	attr_accessor :trabajadores, :sueldoDeCadaTrabajador
	def initialize
		@trabajadores = []
		@sueldoDeCadaTrabajador = []
	end
	def registrarTrabajador(trabajador)
		if validarLaNoExistenciaDNI(trabajador.dni) == nil
			trabajadores.push(trabajador)
			sueldoDeCadaTrabajador.push(trabajador.calcularSueldo)
		else
			raise "DNI ya existe!"
		end
	end
	def validarLaNoExistenciaDNI(dni)
		for trabajador in trabajadores
			if trabajador.dni == dni
				return trabajador
			end	
		end	
		return nil		    
	end
	def incrementarSueldoDeCadaTrabajador(porcentaje)
		for i in 0..sueldoDeCadaTrabajador.size-1
			sueldoDeCadaTrabajador[i] = sueldoDeCadaTrabajador[i] + (sueldoDeCadaTrabajador[i] * porcentaje/100.0)   
		end
		return sueldoDeCadaTrabajador
	end
	def calcularPlanilla()
		sum = 0
		for i in 0..sueldoDeCadaTrabajador.size-1
			sum = sum + sueldoDeCadaTrabajador[i]
		end
		return sum
	end
	def calcularPromedioHorasExtras()
		suma = 0
		for trabajador in trabajadores
			suma = suma + trabajador.horasExtras
		end
		prom = suma*1.0/trabajadores.size
		return prom.round(1)
	end
end
#######################################################
class Factoria
	def self.crear(tipo, datos)
		case tipo
		    when "Staff"
		    	Staff.new(datos[0], datos[1], datos[2], datos[3])
			when "Auxiliar"
				Auxiliar.new(datos[0], datos[1], datos[2], datos[3])
	    end
	end
end
#######################################################
class VistaEntrada
	def capturarDatosTrabajador()
		datos = []
		print("Ingrese tipo de trabajador: ")
		tipo = gets.chomp.to_s
		print("Ingrese nombres completos del trabajador: ")
		nombre = gets.chomp.to_s
		print("Ingrese dni: ")
		dni = gets.chomp.to_s
		print("Ingrese las horas extras del trabajador: ")
		horasExtras = gets.chomp.to_i
		print("Ingrese el sueldo básico del trabajador: ")
		sueldoBasico = gets.chomp.to_f
		datos.push(nombre ,dni ,horasExtras, sueldoBasico)
		return tipo, datos
	end
	def capturarPorcentajeAIncrementar
		print("Ingrese el porcentaje en que se incrementará el sueldo de los trabajadores: ")
		porcentaje = gets.chomp.to_i
		return porcentaje
	end
end
class VistaSalida
	def mostrarMensaje(mensaje)
	    puts mensaje	
	end
	def mostrarMontoNetoAPagar(monto)
		puts "El monto neto a pagar por la empresa es de S/#{monto}." 
	end
	def mostrarPromedioHorasExtrasTrabajadores(promedio)
		puts "El promedio de horas extras de los trabajadores es #{promedio} hrs/trab." 
	end
end
class Controlador
	attr_reader :vistaEntrada, :vistaSalida, :administrador
	def initialize(vistaEntrada, vistaSalida, administrador)
		@vistaEntrada  = vistaEntrada
		@vistaSalida   = vistaSalida
		@administrador = administrador
	end
	def registrarTrabajador
		datos = vistaEntrada.capturarDatosTrabajador
		trabajador = Factoria.crear(datos[0], datos[1])
		administrador.registrarTrabajador(trabajador)
		vistaSalida.mostrarMensaje("Trabajador Registrado!")
	end
	def incrementarSueldoDeTrabajadores
		porcentaje = vistaEntrada.capturarPorcentajeAIncrementar
		administrador.incrementarSueldoDeCadaTrabajador(porcentaje)
		vistaSalida.mostrarMensaje("Incremento realizado!")
	end
	def mostrarMontoNetoAPagarATrabajadores
		monto = administrador.calcularPlanilla
		vistaSalida.mostrarMontoNetoAPagar(monto)
	end
	def mostrarPromedioHorasExtrasTrabajadores
		promedio = administrador.calcularPromedioHorasExtras
		vistaSalida.mostrarPromedioHorasExtrasTrabajadores(promedio)
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
    puts "1. Registrar un trabajador"
    puts "2. Realizar un incremento de sueldo en un porcentaje a todos los trabajadores"
    puts "3. Ver el pago de la planilla de los trabajadores"
    puts "4. Ver el promedio de las horas extras de los trabajadores"
    puts "5. Salir del programa"
    puts "******************************************************************************"
    print "Ingrese la opcion deseada: "
    seleccion = gets.chomp.to_i

    case seleccion
	    when 1
		    puts "Registrando un nuevo trabajador"
		    controlador.registrarTrabajador
		    system('pause')
	    when 2
		    puts "Realizando un incremento de sueldo a los trabajadores registrados"
		    controlador.incrementarSueldoDeTrabajadores
		    system('pause')
	    when 3
		    puts "Mostrando monto neto a pagar a los trabajadores"
		    controlador.mostrarMontoNetoAPagarATrabajadores
		    system('pause')
	    when 4	
		    puts "Mostrando promedio de horas extras de los trabajadores registrados"
		    controlador.mostrarPromedioHorasExtrasTrabajadores
		    system('pause')
    end
end