import numpy as np
from matplotlib import pyplot as plt

x = []
u = []
ureal = []
with open('RESULT') as table:
	line1 = table.readline()
	N = int(line1.split()[0])
	C = float(line1.split()[1])
	t_stop = float(line1.split()[2])
	for line in table:
		x.append(float(line.split()[0]))
		u.append(float(line.split()[1]))
		ureal.append(float(line.split()[2]))

plt.figure()
plt.plot([], [], color = 'w', label = f'N = {N}') 
plt.plot([], [], color = 'w', label = f'C = {round(C, 6)}') 
plt.title(r'$t_{stop}$ = '+f'{round(t_stop, 1)} s')
plt.xlabel('x [m]')
plt.ylabel(r'T [$^\circ C$]')
plt.plot(x, ureal, 'r-', label = 'analytical (Fourier)')
plt.plot(x, u, 'b--', label = 'numerical')
plt.legend()

plt.figure()
plt.title('Residuals')
plt.xlabel('x [m]')
plt.ylabel(r'T [$^\circ C$]')
plt.plot(x, np.array(u) - np.array(ureal), 'r--', label = r'$T_{comp} - T_{real}$')
plt.legend()

plt.tight_layout()
plt.show()
