#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=
CXX=
FC=gfortran

# Macros
PLATFORM=GNU-Linux-x86

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=build/Debug/${PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/foo.o \
	${OBJECTDIR}/bar.o

# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-Debug.mk dist/Debug/${PLATFORM}/analise_tp5

dist/Debug/${PLATFORM}/analise_tp5: ${OBJECTFILES}
	${MKDIR} -p dist/Debug/${PLATFORM}
	${LINK.f} -o dist/Debug/${PLATFORM}/analise_tp5 ${OBJECTFILES} ${LDLIBSOPTIONS} 

${OBJECTDIR}/foo.o: foo.f 
	${MKDIR} -p ${OBJECTDIR}
	$(COMPILE.f) -g -o ${OBJECTDIR}/foo.o foo.f

${OBJECTDIR}/bar.o: bar.f 
	${MKDIR} -p ${OBJECTDIR}
	$(COMPILE.f) -g -o ${OBJECTDIR}/bar.o bar.f

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf:
	${RM} -r build/Debug
	${RM} dist/Debug/${PLATFORM}/analise_tp5
	${RM} *.mod

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
