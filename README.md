# CursedHelloWorld
## C++ and Rust
### Short description
The necessary information can be obtained with following command:
```sh
$ make info
```
Example:
```sh
who@what:~/.../CursedHelloWorld$ make info
USAGE:
    make <target>
TARGETS:
        info Show this message                                           
         all Rebuild components and run both with valgrind and without   
   build-lib Build rust static library                                   
   clean-lib Delete rust static library                                  
 rebuild-lib Delete rust static library and build a new one instead      
       build Build from C++ executable using rust static library         
         run Run executable                                              
      valrun Run executable with memory check                            
     rebuild Delete executable and build a new one instead               
       clean Delete executable
```
### [Return to main](https://github.com/NikolayB800H/CursedHelloWorld)
