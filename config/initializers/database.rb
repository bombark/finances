#require 'yaml'

#orientdb_configs = YAML.load_file Rails.root.join('config').to_s.concat('/database.yml')
#env_config = orientdb_configs.fetch(Rails.env)



#OrientDb::Config.host = env_config['host']
#OrientDb::Config.database = env_config['database']
#OrientDb::Config.user = env_config['username']
#OrientDb::Config.password = env_config['password']
