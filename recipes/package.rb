
case node['platform']
when 'ubuntu', 'debian'
  if node['asterisk']['package']['repo']['enable']
    apt_repository 'asterisk' do
      uri node['asterisk']['package']['repo']['url']
      distribution node['asterisk']['package']['repo']['distro']
      components node['asterisk']['package']['repo']['branches']
      keyserver node['asterisk']['package']['repo']['keyserver']
      key node['asterisk']['package']['repo']['key']
    end
  end

  node['asterisk']['package']['names'].each do |pkg|
    package pkg
  end
end
