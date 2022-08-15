import numpy as np
import matplotlib.pyplot as plt

import matplotlib
matplotlib.use('TkAgg')

x = np.linspace(0, 4*np.pi, 500)
y = np.sin(x) 
plt.plot(x, y)
plt.title("Random sine wave")
plt.show()