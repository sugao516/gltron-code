#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# initialisation
AC_PREREQ([2.69])
AC_INIT([gltron], [0.73-w64-mingw32], [BUG-REPORT-ADDRESS])
#AC_CANONICAL_HOST
#AC_CANONICAL_TARGET
AC_CONFIG_SRCDIR([src/gltron.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([subdir-objects])

AC_PREFIX_DEFAULT("/usr/local")

# AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_CPP
AC_PROG_RANLIB

# CFLAGS set-up
#CFLAGS="-DRC_NAME='\"gltron.ini\"' -DPATH_SEPARATOR='\"\\\\\"' -DSEPARATOR='\"\\\\\"'"
CFLAGS="-DRC_NAME='\"gltron.ini\"' -DPATH_SEPARATOR=\"'/'\" -DSEPARATOR=\"'/'\"" 
CFLAGS="$CFLAGS -DVERSION=\\\"0.73-w64-mingw32\\\""
# CFLAGS="-ansi -pedantic"
# CXXFLAGS=""
# CPPFLAGS=""

AC_ARG_ENABLE(warn,
AC_HELP_STRING([--enable-warn],[Enable compiler warnings @<:@default=off@:>@]),
	enable_warn=$enableval, enable_warn=no)
if test "x$enable_warn" = xyes; then
	CFLAGS="$CFLAGS -Wall -Werror"
fi

AC_ARG_ENABLE(debug,
AC_HELP_STRING([--enable-debug],[Enable debugging @<:@default=off@:>@]),
	enable_debug=$enableval, enable_debug=off)
if test "x$enable_debug" = xyes; then
	CFLAGS="$CFLAGS -g3"
	CXXFLAGS="$CXXFLAGS -g3"
fi

AC_ARG_ENABLE(profile,
AC_HELP_STRING([--enable-profile],[Enable profiling @<:@default=off@:>@]),
	enable_profile=$enableval, enable_profile=off)
if test "x$enable_profile" = xyes; then
	if test "x$GCC" = xyes; then
		CFLAGS="$CFLAGS -pg"
	else
		CFLAGS="$CFLAGS -p"
	fi
fi

AC_ARG_ENABLE(optimize,
AC_HELP_STRING([--enable-optimize=@<:@level@:>@],[Enable optimization @<:@default=s@:>@]),
	enable_optmize=$enableval, enable_optimize=s)
# this is always true
if test "x$enable_optimize" ; then
	CFLAGS="$CFLAGS -O$enable_optimize"
	CXXFLAGS="$CXXFLAGS -O$enable_optimize"
fi

# library checks
AM_PATH_SDL2(2.0.1, CFLAGS="$CFLAGS $SDL_CFLAGS"; CXXFLAGS="$CXXFLAGS $SDL_CFLAGS"; LIBS="$LIBS $SDL_LIBS",
	AC_MSG_ERROR(SDL is not installed))
AC_CHECK_LIB(glew32, main,, AC_MSG_ERROR(OpenGL is not installed))
AC_CHECK_LIB(opengl32, main,, AC_MSG_ERROR(OpenGL is not installed))
AC_CHECK_LIB(z, gzopen,, AC_MSG_ERROR(libz is not installed))
AC_CHECK_LIB(png, png_read_info,, AC_MSG_ERROR(libpng is not installed))
# AC_CHECK_LIB(physfs, PHYSFS_init,, AC_MSG_ERROR(physfs is not installed))
AC_CHECK_LIB([lua], [main])

# local data dir setup
AC_ARG_ENABLE(localdata,
AC_HELP_STRING([--enable-localdata],[Use local data directory @<:@default=no@:>@]),
	CPPFLAGSA="$CPPFLAGSA -DLOCAL_DATA",
	CPPFLAGSA="$CPPFLAGSA -DDATA_DIR=\\\"\$(datadir)/\$(PACKAGE)\\\"")

# snapshot dir setup
AC_ARG_WITH(snapshot-dir,
AC_HELP_STRING([--with-snapshot-dir=@<:@path@:>@],[Snapshot directory @<:@default=~@:>@]),
	CPPFLAGSA="$CPPFLAGSA -DSNAP_DIR=\\\"$withval\\\"",
	CPPFLAGSA="$CPPFLAGSA -DSNAP_DIR=\\\"~\\\"")

# preferences dir setup
AC_ARG_WITH(preferences-dir,
AC_HELP_STRING([--with-preferences-dir=@<:@path@:>@],[Preferences directory @<:@default=~@:>@]),
	CPPFLAGSA="$CPPFLAGSA -DPREF_DIR=\\\"$withval\\\"",
	CPPFLAGSA="$CPPFLAGSA -DPREF_DIR=\\\"~\\\"")

# sound set-up
AC_ARG_ENABLE(sound,
AC_HELP_STRING([--disable-sound],[Don't compile in sound @<:@default=off@:>@]),
   use_sound=no, use_sound=yes)
if test "x$use_sound" = xyes; then
	AC_CHECK_LIB(smpeg, main,, AC_MSG_WARN(smpeg not found - music playback may not work correctly))
	AC_CHECK_LIB(ogg, main,, AC_MSG_WARN(ogg not found - music playback may not work correctly))
	AC_CHECK_LIB(vorbis, main,, AC_MSG_WARN(vorbis not found - music playback may not work correctly))
	AC_CHECK_LIB(vorbisfile, main,, AC_MSG_WARN(vorbisfile not found - music playback may not work correctly))
	AC_CHECK_LIB(mikmod, main,, AC_MSG_WARN(mikmod not found - music playback may not work correctly))
	AC_CHECK_LIB(modplug, main,, AC_MSG_WARN(modplug not found - music playback may not work correctly))
	AC_CHECK_LIB(FLAC, main,, AC_MSG_WARN(FLAC not found - music playback may not work correctly))
	AC_CHECK_LIB(speex, main,, AC_MSG_WARN(speex not found - music playback may not work correctly))
#	AC_CHECK_LIB(SDL_sound, Sound_Init,
#		LIBS="-lSDL_sound $LIBS";
#		SOUND_OBJS="sound.o sound_glue.o Source.o Source3D.o SourceMusic.o SourceSample.o SoundSystem.o SourceCopy.o SourceEngine.o",
#		AC_MSG_WARN(SDL_sound not found - disabling sound);
#		SOUND_OBJS="sound_stubs.o sound_glue_stubs.o")
	
	AC_SUBST(SOUND_OBJS)
else
	SOUND_OBJS="sound_stubs.o sound_glue_stubs.o"
	AC_SUBST(SOUND_OBJS)
fi

# network set-up
AC_ARG_ENABLE(network,
AC_HELP_STRING([--enable-network],[Experimental network mode @<:@default=off@:>@]),
	enable_network=$enableval, enable_network=off)
if test "x$enable_network" = xyes; then
	AC_CHECK_LIB(SDL_net, SDLNet_Init,
	CFLAGS="$CFLAGS -DNETWORK";
	LIBS="$LIBS -lSDL_net";
	NETWORK_OBJS="network.o system_net.o",
	AC_MSG_WARN(SDL_net not found - disabling network))
	AC_SUBST(NETWORK_OBJS)
fi

# CXXFLAGS="$CFLAGS"

# header checks
#AC_HEADER_STDC
AC_CHECK_HEADERS([float.h limits.h stdlib.h string.h unistd.h])

AC_CHECK_HEADERS(GL/gl.h, have_gl_h=true, have_gl_h=false)
$have_gl_h || {
	AC_CHECK_HEADERS(/usr/X11R6/include/GL/gl.h, includes_in_x=1 have_gl_h=true, have_gl_h=false)
}
$have_gl_h || {
	AC_CHECK_HEADERS(/usr/local/include/GL/gl.h, includes_in_local=1 have_gl_h=true, have_gl_h=false)
}
$have_gl_h || {
	AC_MSG_ERROR(cant find GL headers)
}

# Checks for typedefs, structures, and compiler characteristics.
#AC_C_CONST
AC_C_INLINE
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_CHECK_FUNCS([memset mkdir pow realpath sqrt strchr strerror strrchr strstr strtol])

CPPFLAGS="$CPPFLAGS $CPPFLAGSA"

AC_CONFIG_FILES([Makefile
                 art/Makefile
                 art/arcade_spots/Makefile
                 art/biohazard/Makefile
                 art/classic/Makefile
                 art/default/Makefile
                 art/metalTron/Makefile
                 data/Makefile
                 levels/Makefile
                 music/Makefile
                 nebu/Makefile
                 nebu/audio/Makefile
                 nebu/base/Makefile
                 nebu/filesystem/Makefile
                 nebu/include/Makefile
                 nebu/include/audio/Makefile
                 nebu/include/base/Makefile
                 nebu/include/filesystem/Makefile
                 nebu/include/input/Makefile
                 nebu/include/scripting/Makefile
                 nebu/include/video/Makefile
                 nebu/input/Makefile
                 nebu/scripting/Makefile
                 nebu/video/Makefile
                 scripts/Makefile
                 src/Makefile
                 src/audio/Makefile
                 src/base/Makefile
                 src/configuration/Makefile
                 src/filesystem/Makefile
                 src/game/Makefile
                 src/include/Makefile
                 src/include/audio/Makefile
                 src/include/base/Makefile
                 src/include/configuration/Makefile
                 src/include/filesystem/Makefile
                 src/include/game/Makefile
                 src/include/input/Makefile
                 src/include/scripting/Makefile
                 src/include/video/Makefile
                 src/input/Makefile
                 src/video/Makefile])
AC_CONFIG_SUBDIRS([sdl_sound])
AC_OUTPUT
