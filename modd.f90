module modd
implicit none
contains

subroutine InitializeParameters(D, a, b, u_left, u_right, N, t_stop)
!Subroutine for setting model parameters

end subroutine InitializeParameters


subroutine Allocation(N,u)
!Subroutine for allocating memory to dynamic arrays
integer :: N
real(8) :: u(0:N-1)
allocate (u(0:N-1))
end subroutine Allocation


subroutine InitializeGrid(N, a, b, dx, dt)
!Subroutine for initialising a grid

end subroutine InitializeGrid


subroutine ISetIC(N, u_old)
!Subroutine for setting the initial condition

end subroutine SetIC


subroutine FirstStep(N, u_old, u_new)

end subroutine FirstStep


subroutine UpdateIC(N, u_old, u_new)
!Subroutine for updating the initial condition

end subroutine UpdateIC


subroutine SetBC(N, a, b, u_old)
!Subroutine for setting the boundary condition

end subroutine SetBC


subroutine Step(N, u_old, u_new)
real(8) :: D
real(8) :: a, b
real(8) :: u_left, u_right
real(8) :: N

real(8), allocatable :: u_old(:), u_new(:)

real(8) :: dx, dt

real(8) :: t, t_stop

call FirstStep() !ту на выходе получается значение u (?), оно для схемы Д-Ф будет u_old
u_old = u !array for holding values 1 step back in time

t = t + dt

end subroutine Step


subroutine SaveData(N, u_new)

end subroutine SaveData


end module
