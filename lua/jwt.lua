local jwt = require "resty.jwt"

-- local secret = os.getenv("JWT_SECRET")
local secret = "your-secret-key"
local internal_secret = "iNt3rnAl"
local token = ngx.var.http_authorization

if not secret then
    ngx.status = 500
    ngx.say("Server misconfiguration: JWT_SECRET not set")
    return ngx.exit(500)
end

if not token then
    ngx.status = 401
    ngx.say("Missing token")
    return ngx.exit(401)
end

if string.sub(token, 1, 7) == "Bearer " then
    token = string.sub(token, 8)  -- Remove 'Bearer ' (first 7 characters)
end

local jwt_obj = jwt:verify(secret, token)
if not jwt_obj.verified then
    ngx.status = 401
    ngx.say("Invalid JWT: " .. (jwt_obj.reason or "unknown error"))
    return ngx.exit(401)
end

ngx.req.set_header("X-User-Id", jwt_obj.payload.uid)
ngx.req.set_header("X-User-Role", jwt_obj.payload.role)
ngx.req.set_header("X-User-SID", jwt_obj.payload.sid)
ngx.req.set_header("X-User-Key", internal_secret)
ngx.req.set_header("X-User-Token", token)