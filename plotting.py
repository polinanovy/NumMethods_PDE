import numpy as np
from matplotlib import pyplot as plt

x = []
u = []
ureal = []
with open('RESULT') as table:
	for line in table:
		x.append(float(line.split()[0]))
		u.append(float(line.split()[1]))
		ureal.append(float(line.split()[2]))

plt.figure()
plt.title('Results visualisation')
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
