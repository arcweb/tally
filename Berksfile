source "https://supermarket.getchef.com"

def github(repo, opts = {})
  { git: "git://github.com/#{repo}.git" }.merge opts
end

cookbook 'apt'
cookbook 'build-essential'
cookbook 'ruby_build', github('fnichol/chef-ruby_build', tag: 'v0.8.0')
cookbook 'rbenv', github('fnichol/chef-rbenv')
cookbook 'bundler', github('jordanyaker/chef-bundler')
cookbook 'postgresql', github('phlipper/chef-postgresql')
cookbook 'nodejs'
cookbook 'chef-dk', github('RoboticCheese/chef-dk-chef')
cookbook 'sqlite', '~> 1.1.0'
