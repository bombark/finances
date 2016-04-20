%w[development production test].each do |env|
  desc "Runs the following task in the #{env} environment"
  task env do
    RAILS_ENV = ENV['RAILS_ENV'] = env
  end
end
