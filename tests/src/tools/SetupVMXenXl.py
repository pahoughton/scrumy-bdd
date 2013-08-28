import tests.config

class SetupVMXenXl(object):
    '''Perform a clean build of xen vm environment based on the xl tool set.

    NOTE: all of these actions have to be performed as root.
    
    Basic actions will be create and or verify a mountable volume is
    available. The device/files will be completely replaced during a
    clean build process.

    Full clean build proves reproducability.
    
    Future functionallity - delta, partial clean, add components,
    reverse engineer, 
    
    '''

    def reverse(self):
        


