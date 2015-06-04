guard :bundler do
  watch("Gemfile")
end

guard :rspec, cmd: 'bundle exec rspec' do
  watch('db/schema.rb') { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
  watch(%r{^spec/factories/(.+)_factory\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb"}
  watch(%r{^spec/.+_spec\.rb$})
end