module modd
implicit none
contains

subroutine InitializeParameters(D, a, b, u_left, u_right, N, t_stop)
!Subroutine for setting model parameters

end subroutine InitializeParameters


subroutine Allocation(N, u_old)
!Subroutine for allocating memory to dynamic arrays

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

end subroutine Step


end module
