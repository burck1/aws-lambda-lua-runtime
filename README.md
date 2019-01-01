# AWS Lambda Lua Runtime

## Getting Started

```sh
# Clone this repo
git clone https://github.com/burck1/aws-lambda-lua-runtime
cd aws-lambda-lua-runtime

# Setup deployment dependencies
npm install

# Deploy the sample function (index.lua)
npm run deploy

# Invoke the sample function
npm run invoke

# UPADTE index.lua with your custom Lua code
# UPADTE event.json with your sample event
# Update the function code
npm run deploy-function

# Invoke the updated function
npm run invoke

# Cleanup our AWS resources
npm run remove
```

## Version 0

Version 0 of the AWS Lambda Lua Runtime will use the pre-existing [AWS Lambda Bash Runtime](https://github.com/gkrizek/bash-lambda-layer) to download the Lua binary from http://luabinaries.sourceforge.net and use it to execute the provided Lua script.

### TODO

- Instructions for including package dependencies using [LuaRocks](https://luarocks.org)

## Version 1

Version 1 of the AWS Lambda Lua Runtime will use the LUA C API to create a [Custom AWS Lambda Runtime](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html) using the [AWS Lambda Runtime Interface](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-api.html). Should use the [AWS Lambda C++ Runtime](https://github.com/awslabs/aws-lambda-cpp) as a reference implementation.

## Helpful Lua Functions

https://www.lua.org/manual/5.1/manual.html

### [luaL_callmeta](https://www.lua.org/manual/5.1/manual.html#luaL_callmeta)

`int luaL_callmeta (lua_State *L, int obj, const char *e);`

Calls a metamethod.

If the object at index obj has a metatable and this metatable has a field e, this function calls this field and passes the object as its only argument. In this case this function returns 1 and pushes onto the stack the value returned by the call. If there is no metatable or no metamethod, this function returns 0 (without pushing any value on the stack).

### [luaL_dofile](https://www.lua.org/manual/5.1/manual.html#luaL_dofile)

`int luaL_dofile (lua_State *L, const char *filename);`

Loads and runs the given file. It is defined as the following macro:

```
(luaL_loadfile(L, filename) || lua_pcall(L, 0, LUA_MULTRET, 0))
```

It returns 0 if there are no errors or 1 in case of errors.

### [luaL_dostring](https://www.lua.org/manual/5.1/manual.html#luaL_dostring)

`int luaL_dostring (lua_State *L, const char *str);`

Loads and runs the given string. It is defined as the following macro:

```
(luaL_loadstring(L, str) || lua_pcall(L, 0, LUA_MULTRET, 0))
```

It returns 0 if there are no errors or 1 in case of errors.

### [luaL_loadfile](https://www.lua.org/manual/5.1/manual.html#luaL_loadfile)

`int luaL_loadfile (lua_State *L, const char *filename);`

Loads a file as a Lua chunk. This function uses lua_load to load the chunk in the file named filename. If filename is NULL, then it loads from the standard input. The first line in the file is ignored if it starts with a #.

This function returns the same results as lua_load, but it has an extra error code LUA_ERRFILE if it cannot open/read the file.

As lua_load, this function only loads the chunk; it does not run it.

### [luaL_openlibs](https://www.lua.org/manual/5.1/manual.html#luaL_openlibs)

`void luaL_openlibs (lua_State *L);`

Opens all standard Lua libraries into the given state.

### [lua_call](https://www.lua.org/manual/5.1/manual.html#lua_call)

`void lua_call (lua_State *L, int nargs, int nresults);`

Calls a function.

To call a function you must use the following protocol: first, the function to be called is pushed onto the stack; then, the arguments to the function are pushed in direct order; that is, the first argument is pushed first. Finally you call lua_call; nargs is the number of arguments that you pushed onto the stack. All arguments and the function value are popped from the stack when the function is called. The function results are pushed onto the stack when the function returns. The number of results is adjusted to nresults, unless nresults is LUA_MULTRET. In this case, all results from the function are pushed. Lua takes care that the returned values fit into the stack space. The function results are pushed onto the stack in direct order (the first result is pushed first), so that after the call the last result is on the top of the stack.

Any error inside the called function is propagated upwards (with a longjmp).

The following example shows how the host program can do the equivalent to this Lua code:

```C
a = f("how", t.x, 14)
```

Here it is in C:

```C
lua_getfield(L, LUA_GLOBALSINDEX, "f"); /* function to be called */
lua_pushstring(L, "how");                        /* 1st argument */
lua_getfield(L, LUA_GLOBALSINDEX, "t");   /* table to be indexed */
lua_getfield(L, -1, "x");        /* push result of t.x (2nd arg) */
lua_remove(L, -2);                  /* remove 't' from the stack */
lua_pushinteger(L, 14);                          /* 3rd argument */
lua_call(L, 3, 1);     /* call 'f' with 3 arguments and 1 result */
lua_setfield(L, LUA_GLOBALSINDEX, "a");        /* set global 'a' */
```

Note that the code above is "balanced": at its end, the stack is back to its original configuration. This is considered good programming practice.

### [lua_pcall](https://www.lua.org/manual/5.1/manual.html#lua_pcall)

`int lua_pcall (lua_State *L, int nargs, int nresults, int errfunc);`

Calls a function in protected mode.
