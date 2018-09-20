def token_header(user)
  token = Knock::AuthToken.new(payload: {sub: user.id}).token
  return {'Authorization': "#{token}"}
end

def api_auth(req, user)
  req.headers.merge!(token_header(user))
end
