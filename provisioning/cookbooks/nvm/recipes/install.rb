nvm_install node[:nvm][:version]  do
  from_source false
  alias_as_default true
  action :create
end
