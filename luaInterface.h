
// Author:  Greg "fugue" Santucci, 2011
// Email:   thecodewitch@gmail.com
// Web:     http://createuniverses.blogspot.com/


#ifndef LUAINTERFACE_H
#define LUAINTERFACE_H

#pragma warning(disable:4311)
#pragma warning(disable:4244)
#pragma warning(disable:4273)

#include <stdio.h>
#include <string.h>

#include <string>

extern "C"
{
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
}

void luaInit();

bool luaCall(std::string sCmd);

std::string & luaGetError();
std::string & luaGetOutput();

void luaClearError();
void luaClearOutput();

void luaClose();

bool luaIsCommandComplete(std::string sCmd);

#endif // LUAINTERFACE_H

