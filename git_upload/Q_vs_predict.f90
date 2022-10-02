!this is based on Y & T (2016), by zkx ,2022.5
!
        
        program main
        use thermodel
        implicit none

        real::age,seisfreq,temperature,pressure,vs,Q,depth,tmax,u_shear_modulus
        real,parameter::half_srate=20.0!mm/yr,Harmon(2020)
        real::Tm,eta,J1,J2,Q_b,vs_b
        integer::i

        seisfreq=0.02!Hz

        write(*,*)'seafloor age(in Ma):'
        read(*,*)age

        call setupzeroage(zeroaget,zerocoeff,pottemp,adbatgrad,half_srate)
        tmax=zeroaget(201)

        open(1,file='Q_Don.txt')
        open(2,file='Vs_Don.txt')
        open(3,file='Viscosity-Yamauchi_Don.txt')
        open(4,file='shear_modulus.txt')
        open(5,file='Temperature_Don.txt')

        
        do i=1,200
          depth=i-1
          call tempest(zeroaget,zerocoeff,age,depth,tmax,temperature)
          call hydrostatic_pressure(depth,pressure)
          call unrelaxed_shear_modulus_issak_1992(temperature,pressure,u_shear_modulus)
       !   call predotite_solidus_Hirschmann2000(pressure,Tm)
          call yamauchi_takei_2016(depth,temperature,seisfreq,Vs,Q,Tm,eta,J1,J2,Q_b,vs_b)
       !   this includes solidus by Ruan  
          write(1,*)depth,1./Q
          write(2,*)depth,Vs
          write(3,*)depth,eta
          write(4,*)depth,u_shear_modulus/1e+09
          write(5,*)depth,temperature
        end do

        close(1)
        close(2)
        close(3)
        close(4)
        close(5)
        stop
        end program

