      program main
      use thermodel
      implicit none

      real::age,seisfreq,temperature,pressure,vs,Q,depth,tmax,u_shear_modulus
      real,parameter::half_srate=20.0!mm/yr,Harmon(2020)
      real::Tm,eta,J1,J2,Q_b,vs_b
      integer::i
      real::T(2,151)

      seisfreq=0.02!Hz
      open(1,file='Q_aspect.txt')
      open(2,file='Vs_aspect.txt')
      open(3,file='Viscosity-Yamauchi_aspect.txt')
      open(4,file='shear_modulus_aspect.txt')

      open(5,file='Temp_as_long_1Ma.txt')!read T from external profile
      open(6,file='Temp_aspect.txt')

      do i=1,151
          depth=i-1
          read(5,*)T(:,i)
          temperature = T(2,i) !C
          call hydrostatic_pressure(depth,pressure)
          call yamauchi_takei_2016(depth,temperature,seisfreq,Vs,Q,Tm,eta,J1,J2,Q_b,vs_b)
          ! check the solidus!!!!!!

          write(1,*)depth,1./Q
          write(2,*)depth,Vs
          write(3,*)depth,eta
          write(4,*)depth,u_shear_modulus/1e+09
          write(6,*)depth,temperature

      end do

      close(1)
      close(2)
      close(3)
      close(4)
      close(5)
      close(6)

      stop
      end program






