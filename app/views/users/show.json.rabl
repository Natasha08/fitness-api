object @user
attributes :email

node(:token) { @token }

node(:exp) do
  @exp
end
