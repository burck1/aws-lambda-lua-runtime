setup_lua ()
{
    if [ ! -x /tmp/lua53 ]
        then
            curl https://iweb.dl.sourceforge.net/project/luabinaries/5.3.4/Tools%20Executables/lua-5.3.4_Linux44_64_bin.tar.gz -s -o /tmp/lua.tar.gz
            tar xzf /tmp/lua.tar.gz -C /tmp
            chmod +x /tmp/lua53
    fi
}

handler () {
    set -e
    EVENT_DATA=$1
    setup_lua
    /tmp/lua53 index.lua $EVENT_DATA
}
