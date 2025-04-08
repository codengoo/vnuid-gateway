local jwt = require "resty.jwt"

local secret = os.getenv("JWT_SECRET")
local auth = ngx.var.http_authorization

if not secret then
    ngx.status = 500
    ngx.say("Server misconfiguration: JWT_SECRET not set")
    return ngx.exit(500)
end

if not auth then
    ngx.status = 401
    ngx.say("Missing token")
    return ngx.exit(401)
end

local _, _, token = string.find(auth, "Bearer%s+(.+)")
if not token then
    ngx.status = 401
    ngx.say("Malformed token")
    return ngx.exit(401)
end

local jwt_obj = jwt:verify(secret, token)
if not jwt_obj.verified then
    ngx.status = 401
    ngx.say("Invalid token")
    return ngx.exit(401)
end

ngx.req.set_header("X-User-Id", jwt_obj.payload.sub)
ngx.req.set_header("X-User-Role", jwt_obj.payload.sub)