
import pyrpio
from pyrpio import i2c, mdio

# Configure options
options = pyrpio.RPIOConfigs(
  gpiomem=True
  
)
# Must be called prior to using any interface
pyrpio.configure(options)

### MDIO Operations ###

# Create bus using GPIO pins 23 and 24 (bit-bang)
mdio_bus = mdio.MDIO(4, 17)
mdio_bus.open()
i=0
while i<10:
	i=i+1
	# Read register 0x10 from device 0x30 (CLAUSE-45)
	#print(mdio_bus.read_c45_register(0x00, 0x00, 0x00))
	print(mdio_bus.read_c22_register(0x00, 0x00))

	# Read register set from device 0x30 (CLAUSE-45)
	#print(mdio_bus.read_c45_registers(0x00, 0x00, [0,1,2,3,4]))
	print(mdio_bus.read_c22_registers(0x00, [0,1,2,3,4]))
# Close up shop
mdio_bus.close()
