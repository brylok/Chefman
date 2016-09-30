
node[:mysql][:databases].each do |_db|
  execute 'create database stuffs' do
    command <<-EOT
      sudo mysql -e "grant all on *.* to '#{_db[:username]}'@#{_db[:host]} identified by '#{_db[:password]}'"
      EOT
  end
end
