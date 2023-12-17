CONFIG= ./config

include $(CONFIG)

T= lfs

SRCS= src/$T.c
OBJS= src/$T.o

LUA_LIB= ../LuaJIT/src/libluajit-5.1.dll.a

lib: src/lfs.a

src/lfs.a: $(OBJS)
	$(AR) rcs src/lfs.a $(OBJS)

src/%.o: src/%.c
	$(CC) $(CFLAGS) -c $< -o $@

test: lib
	LUA_CPATH=./src/?.a lua tests/test.lua

install:
	mkdir -p $(DESTDIR)$(LUA_LIBDIR)
	cp src/lfs.a $(DESTDIR)$(LUA_LIBDIR)

clean:
	rm -f src/lfs.a $(OBJS)